-- ============================================
-- CPSC 332 - Project
-- File: queries_group2.sql
-- Group: 2
-- Members: [Stephan Maready, Liyuhan Zhou, Marco Guirguis, Alex Trang]
-- Date: [4/15/26]
-- ============================================

-- ============================================
-- SECTION 1: DATABASE SETUP (DO NOT MODIFY)
-- ============================================
USE world_group2;

-- ============================================
-- SECTION 2: QUERIES (MODIFY THIS SECTION)
-- Table names used in queries must match exactly what you defined in create_tables_groupX.sql

-- Write 12 queries total:
--   - 4 JOIN queries       (Queries 1-4)
--   - 3 Subqueries         (Queries 5-7)
--   - 3 Aggregation queries(Queries 8-10)  must use GROUP BY; at least one must use HAVING
--   - 2 Ranking queries    (Queries 11-12) must use ORDER BY
--
-- Requirements & Self-Check:
--   - Valid MySQL syntax
--   - No trivial SELECT *
--   - Each query must have a one-line comment describing its purpose
--   - Use fully qualified column names in JOIN conditions (e.g., City.CountryCode)
--   - Each query counts toward only ONE category
--   - NO PIGGYBACKING: Do not copy a previous query, add an ORDER BY, and submit it twice.
--   - NO TRIVIAL QUERIES: Every query must answer a distinct, real-world analytical question.
--   - All queries must return at least one row using your inserted data
-- ============================================


-- ============================================
-- PART 1: JOIN QUERIES (4 queries)
-- Must involve two or more tables
-- At least one must be an OUTER JOIN (LEFT JOIN or RIGHT JOIN)

-- EXAMPLE (delete this before submitting):
-- Query 0: Find the GDP of countries specifically in the 'Caribbean' region
-- SELECT Country.Name, Economic_Indicators.gdp_billion
-- FROM Country
-- JOIN Economic_Indicators ON Country.Code = Economic_Indicators.country_code
-- WHERE Country.Region = 'Caribbean';
-- ============================================

-- Query 1 (Category: JOIN): This query retrieves the names of the countries along with their literacy rates for the years where the literacy rate is above 90%.
-- It joins the Country table with the Education table on the country code.
SELECT c.Name, e.Year, e.LiteracyRate FROM Country c
JOIN Education e ON c.Code = e.CountryCode
WHERE e.LiteracyRate > 90;

-- Query 2 (Category: JOIN): This query retrieves the names and populations of cities with a population greater than 1 million, along with the name and population of their respective countries. It uses a RIGHT JOIN to include all cities that meet the population criteria, even if their country information is missing.
SELECT c.Name, c.Population AS CountryPopulation, ci.Name AS CityName, ci.Population AS CityPopulation
FROM Country c
RIGHT JOIN City ci ON c.Code = ci.CountryCode
WHERE ci.Population > 1000000;

-- Query 3 (Category: JOIN): This query retrieves the names of the counties with tourists staying at for at least 7 seven days, along with the tourism revenue.
-- It joins the Country table with Tourism table using the country code.
SELECT c.name, t.TourismRevenueInUSD, t.AvgLengthOfStayInDays FROM Country c
JOIN Tourism t ON c.Code = t.CountryCode
where t.AvgLengthOfStayInDays >= 7;


-- Query 4 (Category: JOIN): [Describe your query here]


-- ============================================
-- PART 2: SUBQUERIES (3 queries)
-- Must include at least one EXISTS or NOT EXISTS
-- Must include at least one IN, NOT IN, or correlated subquery

-- EXAMPLE (delete this before submitting):
-- Query 0: Find countries that are major tourist hubs (over 20 million visitors) using IN
-- SELECT Country.Name
-- FROM Country
-- WHERE Country.Code IN (
--     SELECT Tourism_Statistics.country_code
--     FROM Tourism_Statistics
--     WHERE Tourism_Statistics.visitors_mil > 20
-- );
-- ============================================

-- Query 5 (Category: SUBQUERIES): This query retrieves the names and codes of countries where the literacy rate is above 95%.
SELECT Name, Code FROM Country
WHERE Code IN (
    SELECT CountryCode FROM Education WHERE LiteracyRate > 95
);

-- Query 6 (Category: SUBQUERIES): This query retrieves the names and codes of countries where the access to electricity is below 30%.
SELECT Name, Code FROM COUNTRY
WHERE Code IN (
    SELECT CountryCode FROM Infrastructure where ElectricityAccessPercentage < 30
);


-- Query 7 (Category: SUBQUERIES): [Describe your query here]


-- ============================================
-- PART 3: AGGREGATION QUERIES (3 queries)
-- Must use GROUP BY; at least one must use HAVING

-- EXAMPLE (delete this before submitting):
-- Query 0: Show total tourism revenue by continent (only continents above 100 billion)
-- SELECT Country.Continent, SUM(Tourism_Statistics.revenue_billion) AS total_revenue
-- FROM Country
-- JOIN Tourism_Statistics ON Country.Code = Tourism_Statistics.country_code
-- GROUP BY Country.Continent
-- HAVING SUM(Tourism_Statistics.revenue_billion) > 100;
-- ============================================

-- Query 8 (Category: AGGREGATION QUERIES): This query retrieves the average literacy rate and the number of countries for each continent, only including continents where the average literacy rate is above 85%.
SELECT c.Continent, AVG(e.LiteracyRate) AS AvgLiteracyRate, COUNT(e.CountryCode) AS NumCountries
FROM Country c
JOIN Education e ON c.Code = e.CountryCode
GROUP BY c.Continent
HAVING AVG(e.LiteracyRate) > 85;


-- Query 9 (Category: AGGREGATION QUERIES): This query retrieves the agricultural land percentage and number of countries in each continent with more than 50% of agricultural land.
Select c.Continent, cd.AgriculturalLandPercentage, COUNT(cd.CountryCode) AS NumCountries
FROM Country c
JOIN ClimateData cd ON c.Code = cd.CountryCode
WHERE AgriculturalLandPercentage > 50
GROUP BY c.Continent, cd.AgriculturalLandPercentage;


-- Query 10 (Category: AGGREGATION QUERIES): [Describe your query here]


-- ============================================
-- PART 4: RANKING QUERIES (2 queries)
-- Must use ORDER BY; LIMIT is optional
-- Must involve at least two tables

-- EXAMPLE (delete this before submitting):
-- Query 0: Top 5 countries by number of tourist visitors
-- SELECT Country.Name, Tourism_Statistics.visitors_mil
-- FROM Country
-- JOIN Tourism_Statistics ON Country.Code = Tourism_Statistics.country_code
-- ORDER BY Tourism_Statistics.visitors_mil DESC
-- LIMIT 5;
-- ============================================

-- Query 11 (Category: RANKING QUERIES): This query retrieves the names of cities, their respective countries, populations, and official languages for cities with a population greater than 500,000. The results are ordered by city population in descending order.
SELECT ci.Name AS CityName, c.Name AS CountryName, ci.Population AS CityPopulation, cl.Language
FROM City ci
JOIN Country c ON ci.CountryCode = c.Code
JOIN CountryLanguage cl ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T' AND ci.Population > 500000
GROUP BY ci.Name, c.Name, ci.Population, cl.Language
ORDER BY ci.Population DESC
LIMIT 10;

-- Query 12 (Category: RANKING QUERIES): [Describe your query here]
