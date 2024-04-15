SET search_path TO 'advertising_agency';

DROP TABLE IF EXISTS advertising_publication CASCADE;
DROP TABLE IF EXISTS advertising_type CASCADE;
DROP TABLE IF EXISTS advertiser CASCADE;
DROP TABLE IF EXISTS advertiser_review CASCADE;
DROP TABLE IF EXISTS advertiser_application CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS job_position CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS advertising_publication_application CASCADE;
DROP TABLE IF EXISTS payment_note CASCADE;
DROP TABLE IF EXISTS employee_task CASCADE;
DROP TABLE IF EXISTS task_status CASCADE;
DROP TABLE IF EXISTS application_status CASCADE;

 
-- Create Advertising Type table
CREATE TABLE advertising_type (
    id serial PRIMARY KEY,
    title VARCHAR(255)
);

-- Create Job Position table
CREATE TABLE job_position (
    id serial PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Create Task Status table
CREATE TABLE task_status (
    id serial PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

-- Create Payment Note table
CREATE TABLE payment_note (
    id serial PRIMARY KEY,
    is_paid BOOLEAN NOT NULL,
    creation_date DATE NOT NULL,
    text VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0)
);

CREATE TABLE application_status (
    id serial PRIMARY key,
    title VARCHAR(50)
);

-- Create Advertiser table
CREATE TABLE advertiser (
    id serial PRIMARY KEY,
    full_name VARCHAR(255),
    contact_phone VARCHAR(15),
    email VARCHAR(30)
);

-- Create Advertiser Review table
CREATE TABLE advertiser_review (
    id serial PRIMARY KEY,
    text text NOT NULL,
    advertiser_id INT,
    grade INT CHECK (grade > 0 AND grade <= 5),
    FOREIGN KEY (advertiser_id) REFERENCES advertiser(id)
);

-- Create Advertising Publication table
CREATE TABLE advertising_publication (
    id serial PRIMARY KEY,
    name VARCHAR(50),
    type_id INT,
    price DECIMAL(10, 2) CHECK (price > 0) NOT NULL,
    FOREIGN KEY (type_id) REFERENCES advertising_type(id)
);

-- Create Team table
CREATE TABLE team (
    id serial PRIMARY KEY
);

-- Create Employee table
CREATE TABLE employee (
    id serial PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    job_position_id INT,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    team_id INT,
    contact_phone VARCHAR(15) NOT NULL,
    email VARCHAR(30) NOT NULL,
    living_address VARCHAR(50) NOT NULL,
    FOREIGN KEY (job_position_id) REFERENCES job_position(id),
    FOREIGN KEY (team_id) REFERENCES team(id)
);

ALTER TABLE team ADD leader_employee_id int;
ALTER TABLE team ADD CONSTRAINT cs_leader_employee_id FOREIGN KEY (leader_employee_id) REFERENCES employee(id);

-- Create Advertiser Application table
CREATE TABLE advertiser_application (
    id serial PRIMARY KEY,
    technical_task text NOT NULL,
    cost DECIMAL(10, 2) NOT NULL CHECK (cost > 0),
    remaining_budget DECIMAL(10, 2) NOT NULL CHECK (remaining_budget > 0),
    advertiser_id INT,
    team_id INT,
    manager_id INT,
    status_id INT DEFAULT 4,
    start_date date NOT NULL,
    FOREIGN KEY (advertiser_id) REFERENCES advertiser(id),
    FOREIGN KEY (team_id) REFERENCES team(id),
    FOREIGN KEY (manager_id) REFERENCES employee(id),
    FOREIGN KEY (status_id) REFERENCES application_status(id)
);

-- Create Employee Task table
CREATE TABLE employee_task (
    id serial PRIMARY KEY,
    application_id INT NOT NULL,
    employee_id INT NOT NULL,
    task_title VARCHAR(100) NOT NULL,
    task_description text NOT NULL,
    task_status_id INT NOT NULL,
    deadline DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (task_status_id) REFERENCES task_status(id),
    FOREIGN KEY (application_id) REFERENCES advertiser_application(id)
);

-- Create Advertising Publication Application table
CREATE TABLE advertising_publication_application (
    id serial PRIMARY KEY,
    application_id INT,
    content text NOT NULL,
    advertising_publication_id INT NOT NULL,
    release_date DATE,
    payment_note_id INT,
    FOREIGN KEY (application_id) REFERENCES advertiser_application(id),
    FOREIGN KEY (advertising_publication_id) REFERENCES advertising_publication(id),
    FOREIGN KEY (payment_note_id) REFERENCES payment_note(id)
);
