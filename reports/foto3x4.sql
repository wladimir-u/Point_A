SELECT * FROM public.employees
INNER JOIN generate_series(1, {QUANTITY}) nn
ON TRUE WHERE length(photo)>0 AND id IN ({SelectEmployees})
ORDER BY fio, nn;
