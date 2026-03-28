SELECT * FROM BlinkIT_Data
SELECT COUNT(*) FROM BlinkIT_Data
-- update the data to clean 
UPDATE BlinkIT_Data
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END
SELECT DISTINCT(Item_Fat_Content) FROM BlinkIT_Data
-- After clean the data
SELECT * FROM BlinkIT_Data
-- find out the total sale using aggregation funtion for requirement
SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
From BlinkIT_Data   

-- avrage total sales 
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales FROM BlinkIT_Data

--FIND OUT THE NUMBER IF ITEMS
SELECT COUNT(*) AS No_OF_Items FROM BlinkIT_Data
  -- FIND OUT ONLY FOR LOW FAT or any entey
SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
From BlinkIT_Data
WHERE Item_Fat_Content = 'Low Fat'
SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
From BlinkIT_Data
WHERE Outlet_Establishment_Year = 2022

 --avg for entery
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales FROM BlinkIT_Data
WHERE Outlet_Establishment_Year = 2022
-- find out the number of item in 2022
SELECT COUNT(*) AS No_OF_Items FROM BlinkIT_Data
WHERE Outlet_Establishment_Year = 2022

--find out avrage the customer Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating From BlinkIT_Data 
-- find out the total sales by fat content (avg sales,no of item,avg Rating)
SELECT Item_Fat_Content,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	  CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	  COUNT(*) AS N0_of_Items,
	  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIT_Data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC
-- TOTAL SALES BY ITEM TYPE
SELECT Item_Type,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	  CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	  COUNT(*) AS N0_of_Items,
	  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIT_Data
GROUP BY Item_Type
ORDER BY Total_Sales DESC
-- top 5 item type
SELECT TOP 5 Item_Type,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	  CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	  COUNT(*) AS N0_of_Items,
	  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIT_Data
GROUP BY Item_Type
ORDER BY Total_Sales ASC
--FAT CONTENT BY OUTLET FOR TOTAL SALES 
SELECT Outlet_Location_Type, Item_Fat_Content,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
 FROM BlinkIT_Data
GROUP BY Outlet_Location_Type ,Item_Fat_Content
ORDER BY Total_Sales ASC
--FAT CONTENT BY OUTLET FOR TOTAL SALES
SELECT Outlet_Location_Type,
        ISNULL([Low Fat], 0) AS Low_Fat,
		ISNULL([Regular], 0) AS Regular
FROM
(
    SELECT Outlet_Location_Type, Item_Fat_Content,
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_sales
	FROM BlinkIT_Data
	GROUP BY Outlet_Location_Type, Item_Fat_Content
	) AS SourceTable
PIVOT
(
 SUM(Total_Sales)
 FOR Item_Fat_Content IN ([Low Fat], [Regular])
 ) AS PivotTable
 ORDER BY Outlet_Location_Type;
  --TOTAL SALES BY OUTLET ESTABLISHMENT
SELECT Outlet_Establishment_Year,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
      CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	  COUNT(*) AS N0_of_Items,
	  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIT_Data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC

-- FIND OUT THE PERSENTAGE SALES BY OUTLET SIZE
SELECT
    Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER() AS DECIMAL(10,2)) AS Sales_Percentage
FROM Blinkit_Data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

--SALES BY LOCATION
 SELECT Outlet_Location_Type,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
      CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	  COUNT(*) AS N0_of_Items,
	  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIT_Data
WHERE Outlet_Establishment_Year = 2022
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC
 
--ALL METRICS BY OUTLET TYPE

SELECT Outlet_Type,
      CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
      CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
	  COUNT(*) AS N0_of_Items,
	  CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM BlinkIT_Data
WHERE Outlet_Establishment_Year = 2022
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC
 
