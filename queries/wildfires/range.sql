select
    FIRE_YEAR,
    INCIDENT,
    GIS_ACRES,
    SOURCE,
    AGENCY,
    geometry
from
    wildfires
where
    FIRE_YEAR_INT >= cast(:start as numeric)
    and FIRE_YEAR_INT <= cast(:end as numeric)