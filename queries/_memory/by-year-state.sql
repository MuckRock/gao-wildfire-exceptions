select
    FIRE_YEAR,
    INCIDENT,
    GIS_ACRES,
    w.geometry
from
    wildfires.wildfires as w,
    places.states as s
where
    FIRE_YEAR = :year
    and s.name = :state
    and within(w.geometry, s.geometry)
    and w.rowid in (
        select
            rowid
        from
            SpatialIndex
        where
            f_table_name = 'DB=wildfires.wildfires'
            and search_frame = s.geometry
    )