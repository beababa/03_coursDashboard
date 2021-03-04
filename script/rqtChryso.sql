
create table "res1_234" AS (
	(
with temp as 
(
  select   a.fid, st_union(b.geom) as geom
  from     "1_autres_234" b join "1_234" a on st_intersects(a.geom, b.geom)
  group by a.fid
) 
select st_difference(a.geom,t.geom) as newgeom
from "1_234" a left join temp t on a.fid = t.fid
)
UNION
(
select a.geom as geom
from "1_234" a left join "1_autres_234" b on st_intersects(a.geom,b.geom)
where b.fid IS NULL
))