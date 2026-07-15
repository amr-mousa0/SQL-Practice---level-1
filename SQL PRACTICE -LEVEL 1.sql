
-- #1 - Query all columns from the wine table with a limit of getting only 20 records.
 select  *  FROM wine_schema.wine_table 
 limit 20 ;
-- #2 - Query the following columns: Type, Name, Country, Rating from the wine table with a limit of 20 records.
SELECT Type, Name, Country, Rating 
FROM wine_schema.wine_table  
LIMIT 20;

--Exercise #3 - What are the distinct wine types?  
SELECT DISTINCT type  
FROM wine_schema.wine_table ;

--Exercise #4 - Calculate the number of distinct wine types. 
SELECT COUNT(DISTINCT type) AS num_wine_types  
FROM wine_schema.wine_table;

--Exercise #5 - Calculate the number of distinct countries producing Sparkling wines.  
 SELECT count (DISTINCT (country)) FROM wine_schema.wine_table 
 where type = 'Sparkling' ;

--#6 – List the number of wines produced per country in descending order. 
 SELECT count(DISTINCT(name)) as number_of_wine , country FROM wine_schema.wine_table
 GROUP BY country 
 ORDER BY number_of_wine desc ;


-- #7 – What is the average price per each wine type? Round the number to 2 decimal places and order the average price result in ascending order
SELECT type , round(avg(price),2) as avg_price FROM wine_schema.wine_table
GROUP BY type 
ORDER BY avg_price ASC;

 --#8 – What is the average price by year? Order the result in ascending order based on the 
--Year. Exclude NULL values in the Year column from the group-level result.  
SELECT avg(price) , YEAR 
FROM wine_schema.wine_table
GROUP BY year
having year is not null
ORDER BY year ASC;

 #9 – What are the average price and average rating by country? Order by the Country 
--name.
SELECT country , ROUND(COALESCE(AVG(rating),0),2) AS avg_rating, ROUND(COALESCE(AVG(price),0),2) AS avg_price
from wine_schema.wine_table 
GROUP BY country
ORDER BY country ;

-- #10 – What are the average price and average rating by year for Italy? Exclude NULL values 
--in the Year column from the raw table before grouping.  

 select ROUND(avg(price),2) AS AVG_PRICE ,ROUND(avg(rating),2) AS AVG_RATING , year 
 FROM wine_schema.wine_table
 WHERE year is not null AND country =  'Italy'
 GROUP BY year 
 order by year ;

/* #11 – What is the average price by country and by region in each country for the following 
countries: Argentina, Canada, Italy, Greece? Order the result based on the Country ascending and 
secondly based on the average price in a region descending. */

SELECT Country, Region, ROUND(AVG(Price),2) AS avg_price_region
FROM wine_schema.wine_table
WHERE Country IN ('Argentina', 'Canada', 'Italy', 'Greece')
GROUP BY 1, 2
ORDER BY 1, 3 DESC

#12 – How many wines are available per each rating?
select rating , count(DISTINCT(NAME)) 
FROM wine_schema.wine_table
GROUP BY rating
ORDER BY rating ; 

#13 – How many wines of each wine type were produced in each country?
SELECT country ,type , count(DISTINCT (name)) 
FROM wine_schema.wine_table
GROUP BY 1,2
ORDER BY 1 , 2 ;

 #14 – What is the maximum price per each wine type excluding the following years – 2011, 
--2013, 2015, 2018)? Order by maximum price in descending order. 
SELECT type , max(price) 
FROM wine_schema.wine_table
where year  not in (2011 ,2013 ,2015 ,2018)
GROUP BY type 
ORDER BY max(price) asc ;

#15 - What are the names and country locations of the top 10 red wines with the highest 
--rating? 
SELECT Type, Name, Country, Rating
FROM wine_schema.wine_table
WHERE Type = 'Red'
ORDER BY Rating DESC
LIMIT 10

 #16 – List the 10 top Wineries in France that have the highest rating excluding wines with a 
--number of reviews below 200. 
select winery , rating 
FROM wine_schema.wine_table
where (country = 'France' and numofrating >= 200)
ORDER BY rating desc
limit 10 ;

#17 – Which group of wine types has the highest average rating for wines that were 
--produced between 2000 and 2010 or between 2015 and 2020.

select type , avg(rating) 
from wine_schema.wine_table
WHERE (Year BETWEEN 2000 AND 2010) OR (Year BETWEEN 2015 AND 2020)
GROUP BY 1 
order by 2 desc 
limit 1 ;


 #18 – What are the five top countries with the highest average rating for wines that are 
# above the price of 20 Euro? 
select country , avg(rating)
FROM wine_schema.wine_table
where price > 20
GROUP BY country 
order by country DESC
limit 5 ;

/*
#19 – What are the top 20 regions that produce the highest number of wines with a 
minimum of 50 wines, where the price of a wine is below 300 EURO, and the number of rating 
reviews for the wine is more than 100? 
*/
SELECT Region, COUNT(Name) AS amount_wines
FROM wine_schema.wine_table
WHERE Price < 300 AND numofrating > 100
GROUP BY 1
HAVING COUNT(Name) > 50
ORDER BY 2 DESC
LIMIT 20 ;
