-- Netflix project
DROP TABLE IF EXISTS netflix;
CREATE TABLE  Netflix
(
	show_id  VARCHAR(5),
	type     VARCHAR(10),
	title    VARCHAR(250),
	director VARCHAR(550),
	casts      VARCHAR(1050),
	country    VARCHAR(550),
	data_added VARCHAR(60),
	release_year INT,
	rating        VARCHAR(15),
	duration      VARCHAR(15),
	listed_in     VARCHAR(250),
	description   VARCHAR(550)
);

select * from Netflix;


select
	count(*) as total_contant
from Netflix;

select 	
	DISTINCT type
from Netflix;

--Count the Number of Movies vs TV Shows

/*SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1; */

select
	type, 
	count(*) as total_content
From Netflix
Group by type

--comoon rating for m

--Movies Released(2020)
SELECT * 
FROM netflix
WHERE release_year = 2020;

--5 Countries with the Most Content on Netflix
SELECT * 
FROM
(
    SELECT 
        UNNEST(STRING_TO_ARRAY(country, ',')) AS country,
        COUNT(*) AS total_content
    FROM netflix
    GROUP BY 1
) AS t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;

--identifiy the logeest movie
select *from netflix
where type ='Movie'
order by Split_part(duration,' ',1)::INT desc;

-- content add in last 10 year

 - interval '10 year'
SELECT *
FROM netflix
WHERE
	TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
	
 --Find All Movies/TV Shows by Director 'Rajiv Chilaka'

 --all shows with more than 5 seasons

 select *
 from netflix
 where type = 'TV show'
 	and split_part(duration,' ',1)::INT>5;
 --Number of Content Items in Each Genre

 SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM netflix
GROUP BY 1;

-- List All Movies that are Documentaries
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';

-- Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;