WITH a0 AS (
SELECT
	a.npp
FROM
	alcoevents a
{WHERE}
)
SELECT
	a1.kogda,
	a1.devtag,
	a1.subdevtag,
	a1.fio,
	a1.dolzhnost,
	a1.podrazdelenie
FROM
	alcoevents a1
INNER JOIN a0 ON
	a1.npp = a0.npp
LEFT JOIN (
	SELECT
		a2.emp_id AS emp_id2
	FROM
		alcoevents a2
	INNER JOIN a0 ON
		a2.npp = a0.npp
	WHERE
		a2.treb_alco
		AND a2."result" IS NOT NULL ) a3 ON
	a1.emp_id = a3.emp_id2
WHERE
	a1.treb_alco
	AND a1."result" IS NULL
	AND a3.emp_id2 IS NULL
ORDER BY a1.fio, a1.kogda