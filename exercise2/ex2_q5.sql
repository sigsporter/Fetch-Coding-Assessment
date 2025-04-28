/* 
  Q: Which is the leading brand in the Dips & Salsa category?
  ASSUMPTION(S): The Leading Brand would be the one with the highest sale total for all transactions. 
  A: TOSTITOS has $260.99
      BRAND       | SALE TOTAL
      ------------|-------------------
      TOSTITOS    | 260.98999999999995
      null        | 154.37
      GOOD FOODS  | 118.88999999999997	
      PACE        | 118.58000000000007
      MARKETSIDE  | 103.29000000000002
*/

SELECT
  P.BRAND,
  SUM(SAFE_CAST(T.FINAL_SALE AS FLOAT64)) SALE_TOT
FROM
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS` T
  ,`fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.PRODUCTS` P
WHERE 1=1
  AND T.BARCODE = P.BARCODE
  AND P.CATEGORY_2 = 'Dips & Salsa'
GROUP BY
  P.BRAND
ORDER BY 2 DESC;