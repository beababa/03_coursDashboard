

CREATE TABLE data2019 AS (
SELECT canton.fid, canton.id_geofla,code_cultu, sum(surf_parc)  AS surface
FROM parcelle_graphique, canton
	WHERE ST_INTERSECTS(st_centroid(parcelle_graphique.geom), canton.geom)
	GROUP BY code_cultu, canton.fid
	);