select
    FIRE_YEAR,
    INCIDENT,
    GIS_ACRES,
    geometry
from
    wildfires
where
    FIRE_YEAR = :year