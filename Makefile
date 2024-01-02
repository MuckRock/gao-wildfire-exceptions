WILDFIRES = wildfires.db
PLACES = places.db

# downloaded by hand:
# https://data-nifc.opendata.arcgis.com/datasets/nifc::interagencyfireperimeterhistory-all-years-view/about
FIRES_HISTORIC = data/raw/InterAgencyFirePerimeterHistory_All_Years_View.geojson

install:
	pipenv sync

$(FIRES_HISTORIC):
	 curl -o $@ 'https://opendata.arcgis.com/api/v3/datasets/e02b85c0ea784ce7bd8add7ae3d293d0_0/downloads/data?format=geojson&spatialRefId=4326&where=1%3D1'

data/processed/counties_2020.geojson:
	pipenv run censusmapdownloader --data-dir data counties

data/processed/states_carto_2018.geojson:
	pipenv run censusmapdownloader --data-dir data states-carto

counties: data/processed/counties_2020.geojson $(PLACES)
	pipenv run geojson-to-sqlite $(PLACES) $@ $< --pk geoid --spatial-index

states: data/processed/states_carto_2018.geojson $(PLACES)
	pipenv run geojson-to-sqlite $(PLACES) $@ $< --pk geoid --spatial-index

$(PLACES):
	pipenv run sqlite-utils create-database $@ --enable-wal --init-spatialite

$(WILDFIRES):
	pipenv run sqlite-utils create-database $@ --enable-wal --init-spatialite

wildfires: $(WILDFIRES) $(FIRES_HISTORIC)
	pipenv run geojson-to-sqlite $(WILDFIRES) wildfires $(FIRES_HISTORIC) --spatial-index

run:
	# https://docs.datasette.io/en/stable/settings.html#configuration-directory-mode
	pipenv run datasette serve . \
		--load-extension spatialite \
		--crossdb \
		--setting sql_time_limit_ms 5000 \
		--setting facet_suggest_time_limit_ms 5000 \
		--setting facet_time_limit_ms 10000

exports:
	mkdir -p $@

years: exports
	pipenv run ./export-years.sh 1980 2021

exports/all-years.geojson: exports
	pipenv run datasette . --get "/wildfires/range.geojson?start=1980&end=2021" \
		--load-extension spatialite \
		--setting sql_time_limit_ms 5000 \
		--setting max_returned_rows 500000 > $@

exports/fires.pmtiles: exports/all-years.geojson
	tippecanoe -zg -o $@ --drop-densest-as-needed -l all-years $^

export: exports/all-years.geojson
