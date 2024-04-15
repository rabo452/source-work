SET search_path TO 'advertising_agency';

-- find team id by name or surname of employee (1)
SELECT team_id FROM employee
WHERE name LIKE '%John%' OR surname LIKE '%Doe%';

-- get applcation by advertiser full name or by date (2)
SELECT * FROM advertiser_application
WHERE advertiser_id = (SELECT id FROM advertiser WHERE full_name LIKE '%John Smith%') OR start_date = '2021-10-01';

-- get archived application (3)
SELECT * FROM archived_application;

-- get teams leaders (4)
SELECT * FROM team_leader;

-- get all managers
SELECT * FROM manager;
