/* 
  Q: What are the top 5 brands by receipts scanned among users 21 and over?
  A: Dove, Nerds Candy, Trident, Meijer, and Sour Patch Kids
    BRAND           | RECEIPT COUNT
    -------------------------------
    DOVE            | 6
    NERDS CANDY     | 6
    NULL            | 6
    TRIDENT         | 4
    MEIJER          | 4
    SOUR PATCH KIDS | 4
*/

SELECT  
  p.BRAND,
  COUNT(t.RECEIPT_ID) RECEIPTS
FROM 
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS` t,
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.PRODUCTS` p,
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.USERS` u
WHERE 1=1
  and t.USER_ID = u.id
  and t.barcode = p.barcode
  and DATE_DIFF(CURRENT_DATE(), CAST(u.BIRTH_DATE AS DATETIME), DAY)/365 >= 21
GROUP BY
  p.BRAND
ORDER BY
  RECEIPTS DESC
LIMIT 10
