

CREATE TABLE data2019 AS (
SELECT canton.fid, code_cultu, sum(surf_parc)  AS surface, canton.geom
FROM parcelle_graphique, canton
	WHERE ST_INTERSECTS(st_centroid(parcelle_graphique.geom), canton.geom)
	GROUP BY code_cultu, canton.fid
	);