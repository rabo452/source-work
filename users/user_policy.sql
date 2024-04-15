SET search_path TO 'advertising_agency';

-- policy for all roles/users in database
GRANT SELECT(text, grade, advertiser_id) ON advertiser_review TO PUBLIC;
GRANT INSERT ON advertiser TO PUBLIC;

-- advertiser policy
GRANT INSERT, SELECT ON advertiser_review TO advertiser;
GRANT SELECT(full_name, id) ON advertiser TO advertiser;
GRANT SELECT(id, name, surname, contact_phone, email) ON employee TO advertiser;
GRANT SELECT ON advertiser_application TO advertiser;
GRANT UPDATE(cost, technical_task) ON advertiser_application TO advertiser;
GRANT SELECT ON payment_note TO advertiser;
GRANT SELECT ON advertising_publication_application TO advertiser;
GRANT SELECT ON application_status TO advertiser;

-- employee policy
GRANT ALL ON employee_task TO employee;
GRANT SELECT ON team TO employee;
GRANT SELECT, INSERT ON job_position TO employee;
GRANT SELECT ON employee TO employee;
GRANT ALL ON advertising_type TO employee;
GRANT ALL ON advertising_publication TO employee;
GRANT SELECT ON advertiser_application TO employee;
GRANT UPDATE(remaining_budget) ON advertiser_application TO employee;
GRANT ALL ON advertising_publication_application TO employee;
GRANT SELECT ON task_status TO employee;
GRANT ALL ON payment_note TO employee;
GRANT SELECT ON application_status TO employee;
GRANT SELECT, INSERT ON advertiser TO employee;
GRANT ALL ON team_project TO employee;

GRANT UPDATE(name, surname, patronymic) ON customer TO customer;
GRANT SELECT, UPDATE ON selling TO employee WITH GRANT OPTION;
GRANT ALL ON ALL TABLES IN SCHEMA public TO admin;
REVOKE INSERT ON selling TO admin;
