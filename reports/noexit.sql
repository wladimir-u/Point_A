SELECT * FROM employees e
INNER JOIN (
  SELECT a.emp_id FROM alcoevents a
  LEFT JOIN (SELECT emp_id FROM alcoevents a {WHERE} AND subdevtag='Выход') a2
  ON a.emp_id = a2.emp_id {WHERE} AND subdevtag='Вход' AND a2.emp_id IS NULL
) a1
ON e.id = a1.emp_id
ORDER BY podrazdelenie, fio

