
CREATE TABLE mais2018 AS (
SELECT canton.fid, canton.id_geofla,code_cultu, sum(surf_parc), canton.geom  AS surface
FROM rpg2018, canton
	WHERE ST_INTERSECTS(st_centroid(rpg2018.wkb_geometry), canton.geom)
		AND rpg2018.code_cultu LIKE 'MID'
	GROUP BY code_cultu, canton.fid
	);


CREATE TABLE mais2017 AS (
SELECT canton.fid, canton.id_geofla,code_cultu, sum(surf_parc), canton.geom  AS surface
FROM rpg2017, canton
	WHERE ST_INTERSECTS(st_centroid(rpg2017.wkb_geometry), canton.geom)
		AND rpg2017.code_cultu LIKE 'MID'
	GROUP BY code_cultu, canton.fid
	);
/*ogr2ogr -f PostgreSQL PG:"dbname='tachasa' host='localhost' port='5432' user='tachasa' password='bonbon2013'" 
-a_srs EPSG:2154 -nln rpg2017 -nlt MULTIPOLYGON 
parcelles/dataE/01_CULTURES/rpg2017/PARCELLES_GRAPHIQUES.shp
*/


/* pour l'export 
/*\copy lien to lien.csv^C
