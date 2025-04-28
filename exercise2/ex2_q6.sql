/* 
  Q: At what percent has Fetch grown year over year?
  ASSUMPTION(S): Growth is measured by the users gained or lost. 
  A: Fetch has shown positive growth since it's creation and, while the percentage growth 
     is still worth celebrating, it has slowed notably (though an almost 60% growth rate is
     unsustainable).
     In 2024, Fetch gained 11631 new users for a 13.16% increase from the previous year.
     In 2023, Fetch gained 15464 new users for a 21.21% increase from the previous year.
     In 2022, Fetch gained 26807 new users for a 58.15% increase from the previous year.
      Note: This was the largest single-year gain in total users the company's history 
      (in user count, not percent of growth).
*/

WITH USER_COUNTS AS (
SELECT
  EXTRACT(YEAR FROM U.CREATED_DATE) AS YR,
  COUNT(*) CUR_YR_USR
FROM
  `fetch-coding-assessment-2025.FETCH_CODING_ASSESSMENT.USERS` U
WHERE 1=1
GROUP BY
  EXTRACT(YEAR FROM U.CREATED_DATE)
), USER_TOTALS AS (
SELECT
  YR,
  CUR_YR_USR,
  SUM(CUR_YR_USR) OVER(ORDER BY YR RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) RSUM
FROM USER_COUNTS
GROUP BY YR, CUR_YR_USR
)

SELECT
  A.YR,
  A.RSUM CUR_YR_TOT_USRS,
  A.CUR_YR_USR CUR_YR_NEW_USRS,
  ((A.CUR_YR_USR /*CUR_YR_NEW_USRS*/) 
    / B.RSUM /*PREV_YR_TOT*/) * 100 AS PCT_GROWTH
FROM
  USER_TOTALS A
    LEFT OUTER JOIN USER_TOTALS B ON A.YR = (B.YR+1)
ORDER BY
  A.YR DESC
;