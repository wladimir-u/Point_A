SELECT
  a.*,
  (a.a_kogda IS NULL) AS no_alco,
  (a.t_kogda IS NULL) AS no_termo,
  CASE WHEN a.a_kogda IS NULL THEN '' ELSE result || ' мг/л' END AS a_result,
  CASE WHEN a.a_kogda IS NULL THEN '' ELSE p.devmodel END AS pribor,
  CASE WHEN a.a_kogda IS NULL THEN '' ELSE p.nserial END AS pribor_invn,
  CASE WHEN a.a_kogda IS NULL THEN '' WHEN a.result>0 THEN 'Установлено' ELSE ' Не установлено' END AS ustanovleno,
  e.vid_rabot,
  '{INPUT1}' AS signer
FROM public.alcoevents a
LEFT JOIN public.post_props p ON a.devtag=p.devtag
LEFT JOIN (SELECT id, vid_rabot FROM public.employees) e ON a.emp_id=e.id
{WHERE}
ORDER BY npp ASC
