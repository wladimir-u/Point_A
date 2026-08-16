SELECT
  a.*,
  (a.t_kogda IS NULL) AS no_termo
FROM public.alcoevents a
{WHERE}
ORDER BY t_kogda ASC NULLS LAST, kogda ASC
