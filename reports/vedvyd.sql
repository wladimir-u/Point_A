SELECT id, fio, dolzhnost, podrazdelenie, tn, kluch_dec2
FROM employees
WHERE id IN ({SelectEmployees})
ORDER BY fio