WITH allx AS (
WITH nx AS (
SELECT
	DISTINCT ON (n_npp, x_npp)
	a.npp AS a_npp,
	(SELECT x.npp FROM public.checkevents x WHERE x.subdevtag = 'Вход'  AND x.dannye=a.card AND x.npp <= a.npp ORDER BY x.npp DESC LIMIT 1) AS n_npp,
	(SELECT x.npp FROM public.checkevents x WHERE x.subdevtag = 'Выход' AND x.dannye=a.card AND x.npp >= a.npp ORDER BY x.npp ASC  LIMIT 1) AS x_npp
FROM
	public.alcoevents a
{WHERE} /*a.kogda >= current_date*/
ORDER BY n_npp, x_npp
)
SELECT
	nx.*,
	cn.kogda AS n_kogda,
	cn.devtag AS n_devtag,
	cn.subdevtag AS n_subdevtag,
	CAST(cnr.dannye AS numeric(10,3)) AS n_result_n,
	CASE WHEN cnr.dannye IS NULL THEN '' ELSE cnr.dannye || ' мг/л' END AS n_result,
	cx.kogda AS x_kogda,
	cx.devtag AS x_devtag,
	cx.subdevtag AS x_subdevtag,
	CAST(cxr.dannye AS numeric(10,3)) AS x_result_n,
	CASE WHEN cxr.dannye IS NULL THEN '' ELSE cxr.dannye || ' мг/л' END AS x_result,
	regexp_replace(regexp_replace(regexp_replace(cast(date_trunc('second', cx.kogda - cn.kogda) as text), '([234]) days ?',E'\\1 дня\n'),'([05-9]) days ?',E'\\1 дней\n'),'1 days? ?',E'1 день\n') AS dlit,
	(cx.kogda - cn.kogda) as dlit_vr,
	em.id,
	em.tn,
	em.fio,
	em.podrazdelenie,
	em.dolzhnost,
	cn.dannye AS card
FROM
	nx
INNER JOIN public.checkevents cn ON cn.npp = nx.n_npp
LEFT JOIN public.checkevents cx ON cx.npp = nx.x_npp
INNER JOIN public.employees em ON cn.dannye = em.kluch_dec2
LEFT JOIN public.checkevents cnr ON cnr.rnpp = nx.n_npp AND cnr.subdevtag = 'Алкотестер'
LEFT JOIN public.checkevents cxr ON cxr.rnpp = nx.x_npp AND cxr.subdevtag = 'Алкотестер'
ORDER BY podrazdelenie, fio, n_kogda
)
SELECT * FROM allx
INNER JOIN (
SELECT
	regexp_replace(
		regexp_replace(
			regexp_replace(
				CAST(date_trunc('second', sum(allx.dlit_vr)) AS TEXT),
				'([234]) days ?', E'\\1 дня, '),
			'([05-9]) days ?', E'\\1 дней, '),
		'1 days? ?', E'1 день, ')
	AS dlit_sum
FROM  allx
--WHERE allx.dlit_vr < INTERVAL '1 day'
) itogi ON TRUE
;
