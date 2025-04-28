/* 
  Q: What are the top 5 brands by sales among users that have had their accounts for at least 6 months?
  A: CVS, Trident, Dove, Coors Light, Quaker
    BRAND           | SALE TOTAL
    -------------------------------
    CVS             | 72.00
    TRIDENT         | 46.72
    DOVE            | 42.88
    COORS LIGHT     | 34.96
    NULL            | 16.65
    QUAKER          | 16.60
*/

SELECT  
  p.BRAND,
  SUM(SAFE_CAST(t.FINAL_SALE AS FLOAT64)) SALE
FROM 
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS` t,
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.PRODUCTS` p,
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.USERS` u
WHERE 1=1
  and t.USER_ID = u.id
  and t.barcode = p.barcode
  and DATE_DIFF(CURRENT_DATE(), CAST(u.CREATED_DATE AS DATETIME), DAY)/12 >= 6
GROUP BY
  p.BRAND
ORDER BY
  Sale DESC
LIMIT 10
