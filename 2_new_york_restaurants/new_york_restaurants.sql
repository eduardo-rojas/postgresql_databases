
--1 Column names
select * from nomnom;

--2 Unique neighborhoods
select distinct neighborhood from nomnom;

--3 unique cuisine types
select distinct cuisine from nomnom;

--4 Chinese takeout options
select name from nomnom where cuisine == 'Chinese';

--5 restaurants with reviews of 4 and above
select name from nomnom where review >= 4;

--6 All restaurants that are Italian and  $$$
select name from nomnom 
where cuisine == 'Italian'
and price == '$$$'; 

--7 Restaurant that contains the word 'meatball'
select name from nomnom where name LIKE '%meatball%';

--8 Close by spots in Midtown, Downtown or Chinatown
select name, neighborhood from nomnom where neighborhood == 'Midtown'
OR  neighborhood == 'Downtown'
OR neighborhood == 'Chinatown';

--9 health grade pending restaurants (empty values).
SELECT *
FROM nomnom
WHERE health IS NULL;

--10 Top 10 Restaurants Ranking based on reviews.
SELECT * from nomnom 
order by review DESC
limit 10;

--11 change the rating system 

select name, 
  CASE 
    WHEN review > 4.5 THEN 'Extraordinary' 
    WHEN review > 4.5 THEN 'Excellent' 
    WHEN review > 4.5 THEN 'Good' 
    WHEN review > 4.5 THEN 'Fair' 
  ELSE
    'Poor'
  END
  AS 'Rating'
from nomnom;