select f.event_type,f.diff
from
(
select 
event_type,
row_number() over (partition by event_type order by time desc) as rno,
value-lead(value) over(partition by event_type order by time desc) as diff
from events
) as f
where rno=1 and diff is not null;
