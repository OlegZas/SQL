-- Procedure: calculates the calendar day and business day difference between two given dates. 

CREATE OR REPLACE PROCEDURE Data.DayDifference()
BEGIN 
    DECLARE startDate DATE; 
    DECLARE endDate DATE; 
    DECLARE days INT64 DEFAULT 60; 


    -- Dates

     SET endDate = CURRENT_DATE("America/Chicago"); 
    SET startDate = date_add(endDate, interval days * -1 DAY);

INSERT INTO Schema.RelationshipDataStaging
(AccountMasterId, CreatedBy, EventDate, InteractionId, IndividualId, EventSequence, 
RelatedAccountMasterId, RelatedCreatedBy, RelatedEventDate, RelatedInteractionId, 
RelatedIndividualId, RelatedSequence, DateDiffCalendar, DateDiffWorkdays, Owner)
WITH Workdays AS (
    -- Generate workdays between the specified date range
    SELECT Workday
    FROM UNNEST(GENERATE_DATE_ARRAY(DATE(startDate), DATE(endDate))) AS Workday
    WHERE Schema.DayTypeIdentifier(Workday) = 'Workday'  -- Only workdays; DayTypeIdentifier returns Workday/Weekend/Holiday
)
SELECT 
    p.AccountMasterId, p.CreatedBy, p.EventDate, p.InteractionId, p.IndividualId, p.EventSequence, 
    c.AccountMasterId, c.CreatedBy, c.EventDate, c.InteractionId, c.IndividualId, c.EventSequence,
    
    -- Calendar day difference
    DATE_DIFF(c.EventDate, p.EventDate, DAY) AS DateDiffCalendar,
    
    -- Workday difference using precomputed workdays
    CASE 
        WHEN c.EventDate IS NOT NULL THEN
            COUNT(wd.Workday) - 1  -- Exclude the start day (p.EventDate)
        ELSE NULL
    END AS DateDiffWorkdays,
    p.Owner

FROM Schema.ParentData p
LEFT JOIN Schema.ParentData c 
    ON p.AccountMasterId = c.AccountMasterId 
    AND p.EventSequence + 1 = c.EventSequence
    AND p.Owner = c.Owner

-- Join the precomputed workdays to calculate the workday difference
LEFT JOIN Workdays wd
    ON wd.Workday BETWEEN p.EventDate AND c.EventDate

WHERE p.AccountMasterId != 0
GROUP BY 
    p.AccountMasterId, 
    p.CreatedBy, 
    p.EventDate, 
    p.InteractionId, 
    p.IndividualId, 
    p.EventSequence, 
    c.AccountMasterId, 
    c.CreatedBy, 
    c.EventDate, 
    c.InteractionId, 
    c.IndividualId, 
    c.EventSequence, 
    p.Owner

ORDER BY p.AccountMasterId, p.EventSequence;
