SET search_path TO 'advertising_agency';

DROP VIEW IF EXISTS team_leader;
DROP VIEW IF EXISTS archived_application;
DROP VIEW IF EXISTS manager;
DROP VIEW IF EXISTS team_project;

CREATE VIEW team_leader AS
SELECT employee.id, employee.name, employee.surname, employee.hire_date,
       employee.salary, employee.contact_phone, employee.email,
       employee.living_address,
       job_position.title as job_title,
       team.id as team_id
FROM employee
JOIN team on team.leader_employee_id = employee.id
JOIN job_position ON employee.job_position_id = job_position.id
ORDER BY employee.id;

CREATE VIEW archived_application AS
SELECT advertiser_application.* FROM advertiser_application
WHERE advertiser_application.status_id = 1
ORDER BY advertiser_application.id;

CREATE VIEW manager AS
SELECT employee.id, employee.name, employee.surname, employee.hire_date,
      employee.salary, employee.contact_phone, employee.email,
      employee.living_address,
      job_position.title as job_title,
      COUNT(advertiser_application.id) as application_count
FROM employee
JOIN job_position ON employee.job_position_id = job_position.id
LEFT JOIN advertiser_application ON advertiser_application.manager_id = employee.id
WHERE employee.job_position_id = 6
GROUP BY employee.id, job_title ORDER BY employee.id;

CREATE VIEW team_project AS
SELECT team.id as team_id, COUNT(advertiser_application.id) as application_count FROM team
LEFT JOIN advertiser_application on advertiser_application.team_id = team.id
GROUP BY team.id;
