select
    FIRE_YEAR as year,
    count(*) as count,
    trunc(sum(GIS_ACRES)) as acres,
    trunc(
        avg(sum(GIS_ACRES)) over (
            order by
                FIRE_YEAR rows between 3 preceding
                and current row
        )
    ) as moving_average
from
    wildfires
where
    FIRE_YEAR_INT > 1970
    and FIRE_YEAR_INT != 9999
group by
    FIRE_YEAR_INT
order by
    FIRE_YEAR_INT