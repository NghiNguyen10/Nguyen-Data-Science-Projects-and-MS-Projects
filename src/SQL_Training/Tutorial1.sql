-- How to read the data from database into SQL using FROM
-- Selecting columns

-- SELECT "Name", "Country" FROM "airlines"
-- How to see/select all airline names in the US?
-- SELECT "Name", "Country" FROM "airlines"
-- WHERE "Country" = 'United States'  -- single quotation mark for values and double for the real name

-- SELECT COUNT("Name") FROM "airlines" -- Count how many airlines in the US
-- WHERE "Country" = 'United States'

SELECT "Country", COUNT("Country") FROM "airlines" 
GROUP BY 1       -- "Country"                    -- Select the countries and count the number of airlines of each country (selected) and then group them
ORDER BY 2 DESC  -- by column 2
