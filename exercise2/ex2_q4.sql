/* 
  Q: Who are Fetch's Power Users?
  ASSUMPTION(S): Power users are those who engage with the product the most frequently. 
    In this case, I would argue that it would be the users with the highest number of transactions (recepits).
  A: The following list of user IDs correspond to users with 6 receipts in the past 3 months (Transaction Data Set
     goes from 06/2024 - 09/2024). These users have demonstrated repeated use of the product/service.
    610a8541ca1fab5b417b5d33
    6528a0a388a3a884364d94dc
    646bdaa67a342372c857b958
    62ffec490d9dbaff18c0a999
    61a58ac49c135b462ccddd1c
    5c366bf06d9819129dfa1118
    5f6518d1bf3f5a43fdd0c9a5
    62c09104baa38d1a1f6c260e
    5f64fff6dc25c93de0383513
*/

SELECT
  U.ID,
  COUNT(T.RECEIPT_ID) RECEIPT_COUNT,
  sum(safe_cast(final_sale as float64)) SALE_TOT
FROM
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS` T
  ,`fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.USERS` U
WHERE 1=1
  AND T.USER_ID = U.ID
GROUP BY
  U.ID
ORDER BY 2 DESC, 3 DESC;
