SET search_path TO 'advertising_agency';

-- get technical task (1) for employee
SELECT employee_task.*,
       employee.name,
       task_status.title
FROM employee_task
JOIN employee on employee.id = employee_task.employee_id
JOIN task_status on task_status.id = employee_task.task_status_id
WHERE employee.name = 'John';

-- get employee
SELECT employee.*,
       job_position.title as job_position
FROM employee
JOIN job_position on job_position.id = employee.job_position_id
WHERE employee.team_id = 1;

-- get team leader by team id (3)
SELECT employee.*,
       job_position.title as job_position
FROM employee
JOIN job_position on job_position.id = employee.job_position_id
WHERE employee.id = (SELECT leader_employee_id FROM team WHERE team.id = 1);

-- get advertising publication and their types (4)
SELECT advertising_publication.name,
       advertising_type.title,
       advertising_publication.price,
       advertising_publication.id
FROM advertising_publication
JOIN advertising_type on advertising_type.id = advertising_publication.type_id;

-- get phone and email of manager that works on applcation (5)
SELECT employee.name, employee.surname,
       employee.email, employee.contact_phone,
       job_position.title as job_position
FROM employee
JOIN job_position on job_position.id = employee.job_position_id
WHERE employee.id = (SELECT manager_id FROM advertiser_application WHERE advertiser_application.id = 1);

-- get job role/position of the employee (6)
SELECT title as employee_job_position FROM job_position
WHERE job_position.id = (SELECT job_position_id FROM employee WHERE employee.id = 1);
