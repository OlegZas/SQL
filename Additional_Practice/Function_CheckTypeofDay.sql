CREATE OR REPLACE FUNCTION Schema.DayTypeIdentifier(input_date DATE)
RETURNS VARCHAR AS (
  CASE 
    -- Determine if the input date falls on a weekend (Saturday or Sunday)
    WHEN EXTRACT(DAYOFWEEK FROM input_date) IN (1, 7) THEN 'Weekend'
    
    -- Check if the date matches a holiday in the Holidays list
    WHEN EXISTS (SELECT 1 FROM Schema.HolidayList WHERE HolidayDate = input_date) THEN 'Holiday'
    
    -- Otherwise, it's a standard workday
    ELSE 'Workday'
  END
);

