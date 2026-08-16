SELECT
	e.fio,
	m.meropr,
	cast(m.kogda as date) as kogda,
	regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(cast(m.interval_proh as TEXT), '([^1]?1) *years?\M', '\1 год', 'g'), '([^1]?[2-4]) *years?\M', '\1 года', 'g'), '([0-9]+) *years\M', '\1 лет', 'g') , '\mmon\M', 'месяц', 'g'), '\m([2-4]) *mons\M', '\1 месяца', 'g'), '([0-9]+) *mons\M', '\1 месяцев', 'g') AS interval_proh,
	cast(m.sled_proh as date) as sled_proh,
	m.dney_do,
	m1.min_dney
FROM
	public.meropri m
INNER JOIN public.employees e ON
	m.id_employee = e.id
LEFT JOIN (
SELECT DISTINCT ON (m0.id_employee) m0.id_employee, m0.dney_do AS min_dney FROM public.meropri m0 ORDER BY m0.id_employee, m0.dney_do
) m1
ON m.id_employee=m1.id_employee
ORDER BY
	min_dney, fio, dney_do
