/* 
  Q: What is the percentage of sales in the Health & Wellness category by Generation?
  A: The majority of rows are not able to be assigned to a Generation.
     CATEGORY_1         | GENERATION  | GENERATION TOTAL    | CATEGORY TOTAL      | PERCENT OF CATEGORY
     -------------------|-------------|---------------------|---------------------|--------------------
     Health & Wellness  | null        | 41258.080000000817  | 41447.740000000791  | 99.542411721362924
     Health & Wellness  | Baby Boom   | 89.03               | 41447.740000000791  | 0.21480061397798361
     Health & Wellness  | Millenial   | 59.13               | 41447.740000000791. | 0.14266157817048378
     Health & Wellness  | Gen X       | 41.5                | 41447.740000000791  | 0.100126086488

     Baby Boomers account for 0.21%, Millenials 0.14%, and Gen X 0.10% of the Health & Wellness category.
     The majority of sales cannot be tied back to a generation at 99.5%.

  Thoughts: The number of sales not tied to a generation seems so high I am concerned my calcluations are
            incorrect; however, I've reviewed them several times and cannot find where the flaw may exist
            in my logic. Therefore, I present these results as the answer to the question.
  
  Running the query below returns 17603 distinct user IDs in the Transactions table that do not appear in
  the users table. This is likely the cause of the inconsistencty noted above.
    select
      count(distinct user_id)
    from 
      `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS`
    WHERE 1=1
      AND USER_ID NOT IN (SELECT DISTINCT ID FROM `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.USERS`);
*/

WITH GENERATIONS AS (
  SELECT
    ID as USER_ID,
    CASE 
      WHEN BIRTH_DATE IS NULL THEN 'UNKNOWN'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=1927 THEN 'GI'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=1945 THEN 'Silent'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=1964 THEN 'Baby Boom'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=1980 THEN 'Gen X'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=1996 THEN 'Millenial'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=2010 THEN 'Gen Z'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=2024 THEN 'Gen Alpha'
      WHEN EXTRACT(YEAR from BIRTH_DATE) <=2039 THEN 'Gen Beta'
      ELSE 'UNKNOWN'
    END AS GENERATION
  FROM
    `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.USERS`
  WHERE 1=1
),
CAT_TOT AS (
  SELECT
    CATEGORY_1,
    SUM(SAFE_CAST(FINAL_SALE AS FLOAT64)) AS CAT_TOTAL
  FROM
    `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS` T
    LEFT OUTER JOIN `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.PRODUCTS` P
      ON T.BARCODE = P.BARCODE
  WHERE 1=1
  GROUP BY
    CATEGORY_1
)
SELECT
  P.CATEGORY_1,
  G.GENERATION,
  SUM(SAFE_CAST(T.FINAL_SALE AS FLOAT64)) AS SALE_TOT,
  C.CAT_TOTAL
  ,SUM(SAFE_CAST(T.FINAL_SALE AS FLOAT64)) / C.CAT_TOTAL * 100 AS CAT_PERC
FROM
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.TRANSACTIONS` T
  LEFT OUTER JOIN `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.PRODUCTS` P
    ON T.BARCODE = P.BARCODE
  LEFT OUTER JOIN GENERATIONS G ON T.USER_ID = G.USER_ID
  LEFT OUTER JOIN CAT_TOT C ON P.CATEGORY_1 = C.CATEGORY_1
WHERE 1=1
  AND P.CATEGORY_1 = 'Health & Wellness'
GROUP BY
  CATEGORY_1,
  GENERATION,
  C.CAT_TOTAL
ORDER BY CATEGORY_1 DESC

