# Analysis of wildfire exceptional event submissions and increasing wildfires

This repository contains data and findings that are part of an ongoing collaboration between MuckRock and the California Newsroom on the increasing impact of wildfire smoke on Californians' health. The data and analysis in this repository underpin visualizations and findings in the story "[As Wildfire Smoke Worsens Public Health, Government Watchdog Calls EPA Response 'Ad Hoc'](https://www.muckrock.com/news/archives/2023/may/23/wildfire-smoke-exceptional-event/)".

You can find analysis for earlier work in the series in [`california-wildfire-pollution`](https://github.com/MuckRock/california-wildfire-pollution) and a full catalogue of all the data and analysis driving the investigations of MuckRock's news team in [`news-team`](https://github.com/MuckRock/news-team).

## Data

### Exceptional Events Submissions

Data for exceptional events submissions from 2013 to 2020 originally comes from Figure 3 of the the Government Accountability Office (GAO) report _[Wildfire Smoke: Opportunities to Strengthen Federal Efforts to Manage Growing Risks](https://www.gao.gov/products/gao-23-104723)_. The underlying data for Figure 3 was received via email from the GAO.

### Historic wildfires

The National InterAgency Fire Center maintains an [archive of wildfire perimeters](https://data-nifc.opendata.arcgis.com/datasets/nifc::interagencyfireperimeterhistory-all-years-view/about). The following commands will download that dataset, plus Census data, for spatial analysis using SpatiaLite and Datasette:

```sh
# install dependencies
make install

# download state boundaries
make states

# download and load wilfire data
make wildfires

# run datasette at http://localhost:8001
make run
```

Canned queries live in the `queries` directory, grouped by database name.

## Methodology

### Exceptional Events Submissions

For brevity and clarity, submissions of different categories — such as concurred, placed on hold, nonconcurred or under review — were aggregated together for a total number of wildfire exceptional event submissions by year.
