SELECT *
FROM Amazon_Sale_Report

--CLEAN DATASET
--REMOVING DUPLICATE DATA BASED ON 
WITH cte AS (
	SELECT*, 
		ROW_NUMBER() OVER ( 
			PARTITION BY 
				Order_ID,
				ASIN,
				SKU
			ORDER BY	
				Order_ID,
				ASIN,
				SKU
		) row_num
	FROM Amazon_Sale_Report
)
SELECT * FROM cte
WHERE row_num > 1
-- 7 rows were duplicates. Duplicates are removed below on the final query.



-- Cleaninng DATE format
SELECT CAST(Date AS date) AS Date_clean, *
FROM Amazon_Sale_Report
ORDER BY Date_clean 

--FINAL QUERY

WITH cte AS (
	SELECT*, 
		ROW_NUMBER() OVER ( 
			PARTITION BY 
				Order_ID,
				ASIN,
				SKU
			ORDER BY	
				Order_ID,
				ASIN,
				SKU
		) row_num
	FROM Amazon_Sale_Report
)

SELECT CAST(Date AS date) AS Date_clean, 
UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace(REPLACE(ship_state,'RAJSHTHAN', 'Rajasthan'),'Punjab/Mohali/Zirakpur','PUNJAB'),'PB','PUNJAB'),'RJ','Rajasthan' ),'Arrra','Arunachal Pradesh'),'NL', 'Nagaland'),'ARUNACHAL PRADESHUNACHAL PRADESH','ARUNACHAL PRADESH'),'RAJSTHAN','Rajasthan'),'RAJASHTHAN','Rajashthan')) AS Ship_State_clean,
ISNULL(Courier_Status, 'Unknown') AS Courrier_Status_Clean,* 
--INTO clean_amazon222
FROM cte
WHERE row_num = 1 AND Amount IS NOT NULL
ORDER BY Date_clean;















