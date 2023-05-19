select
    FIRE_YEAR_INT as year,
    floor(FIRE_YEAR_INT / 10) * 10 as decade,
    INCIDENT as name,
    GIS_ACRES as acres,
    SOURCE as source,
    AGENCY as agency,
    geometry
from
    wildfires
where
    FIRE_YEAR_INT >= cast(:start as numeric)
    and FIRE_YEAR_INT <= cast(:end as numeric)