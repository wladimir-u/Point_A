SELECT * FROM employees e
LEFT JOIN (SELECT a.emp_id FROM alcoevents a {WHERE}) a1
ON e.id = a1.emp_id
{WHERE e} AND a1.emp_id IS NULL
ORDER BY podrazdelenie, fio
