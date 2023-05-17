#!/usr/bin/env sh

mkdir -p exports

start=$1
end=$2

YEARS=$(seq $start 1 $end)

for year in $YEARS; do
    datasette wildfires.db --get "/wildfires/by-year.geojson?year=$year" \
        --load-extension spatialite \
        --setting max_returned_rows 25000 > exports/wildfires-$year.geojson &
done

wait
