SET search_path TO 'advertising_agency';

INSERT INTO advertising_type (title) VALUES
('Print'),
('Webiste ad'),
('TV'),
('Radio'),
('Outdoor');

INSERT INTO application_status (title) VALUES
('Complete'),
('Frozen'),
('Cancelled'),
('Pending');

INSERT INTO job_position (title) VALUES
('Web programmer'),
('Marketing Specialist'),
('Graphic Designer'),
('Copywriter'),
('Advert Specialist'),
('Manager');

INSERT INTO task_status (title) VALUES
('Pending'),
('In Progress'),
('Completed'),
('Cancelled'),
('On Hold');

INSERT INTO advertiser (full_name, contact_phone, email) VALUES
('John Smith', '+07579788642', 'john@example.com'),
('Emma Johnson', '+07935207251', 'emma@example.com'),
('Michael Brown', '+07963831013', 'michael@example.com'),
('Sophia Davis', '+07524855807', 'sophia@example.com'),
('Daniel Wilson', '+07366656086', 'daniel@example.com'),
('Olivia Thompson', '+07985216438', 'olivia@example.com');

INSERT INTO advertiser_review (text, advertiser_id, grade) VALUES
('Great experience with this advertiser', 3, 5),
('Would highly recommend', 1, 4),
('Excellent communication and results', 2, 5);

INSERT INTO advertising_publication (name, type_id, price) VALUES
('Washington post', 1, 500.00),
('Google ads', 2, 1000.00),
('BBC TV', 3, 2000.00),
('Radio Europe', 4, 800.00),
('Billboard International', 5, 1500.00);

INSERT INTO team DEFAULT VALUES;
INSERT INTO team DEFAULT VALUES;
INSERT INTO team DEFAULT VALUES;

-- team 1
INSERT INTO employee (name, surname, hire_date, job_position_id, salary, team_id, contact_phone, email, living_address)
VALUES
('John', 'Doe', '2020-01-01', 1, 5000.00, 1, '1234567890', 'john.doe@example.com', '123 Main St'),
('Jane', 'Smith', '2019-06-15', 2, 4500.00, 1, '0987654321', 'jane.smith@example.com', '456 Elm St'),
('Michael', 'Johnson', '2021-03-10', 3, 5500.00, 1, '9876543210', 'michael.johnson@example.com', '789 Oak St'),
('Alex', 'Davis', '2020-09-25', 4, 6000.00, 1, '0123456789', 'alex.davis@example.com', '321 Pine St'),
('Sarah', 'Taylor', '2018-12-01', 5, 4800.00, 1, '9876543210', 'sarah.taylor@example.com', '456 Maple St'),

('David', 'Anderson', '2017-05-20', 1, 5200.00, 2, '1234567890', 'david.anderson@example.com', '789 Oak St'),
('Emily', 'Moore', '2019-10-15', 2, 4600.00, 2, '0987654321', 'emily.moore@example.com', '123 Main St'),
('Matthew', 'Walker', '2021-01-05', 3, 5100.00, 2, '0123456789', 'matthew.walker@example.com', '321 Pine St'),
('Olivia', 'Clark', '2020-08-10', 4, 5500.00, 2, '9876543210', 'olivia.clark@example.com', '456 Elm St'),
('Daniel', 'Allen', '2016-04-27', 5, 5900.00, 2, '1234567890', 'daniel.allen@example.com', '789 Oak St'),

('Sophia', 'Young', '2019-09-12', 1, 4700.00, 3, '0987654321', 'sophia.young@example.com', '123 Main St'),
('Joseph', 'Hall', '2018-11-30', 2, 4900.00, 3, '0123456789', 'joseph.hall@example.com', '321 Pine St'),
('Mia', 'Lewis', '2017-06-22', 3, 5300.00, 3, '9876543210', 'mia.lewis@example.com', '456 Elm St'),
('James', 'Brown', '2021-02-15', 4, 5200.00, 3, '1234567890', 'james.brown@example.com', '789 Oak St'),
('Emma', 'Miller', '2020-07-20', 5, 4800.00, 3, '0987654321', 'emma.miller@example.com', '123 Main St'),

('Benjamin', 'Wilson', '2019-08-02', 6, 6000.00, null, '0123456789', 'benjamin.wilson@example.com', '321 Pine St'),
('Dmitriy', 'Shamov', '2019-02-08', 6, 10000.00, null, '07654681023', 'dmitriy@gmail.com', 'Avenue 111 St'),
('Vasiliy', 'Antonov', '2018-02-09', 6, 15000, null, '095321543', 'vasiliy@gmail.com', 'Kap 123 St');

-- set leaders
UPDATE team SET leader_employee_id = 5 WHERE id = 1;
UPDATE team SET leader_employee_id = 10 WHERE id = 2;
UPDATE team SET leader_employee_id = 15 WHERE id = 3;

INSERT INTO advertiser_application
(technical_task, cost, advertiser_id, start_date) VALUES
('Create banner ad for website', 10000.00, 1, '2021-10-01'),
('Design flyer for print advertisement', 50000.00, 1, '2021-09-15'),
('Produce TV commercial', 50000.00, 3, '2021-11-01'),
('Record radio ad', 10000.00, 3, '2021-10-15'),
('Design billboard advertisement', 20000.00, 2, '2021-10-01'),
('Create banner ad for website', 10000.00, 2, '2021-09-15'),
('Design flyer for print advertisement', 50000.00, 4, '2021-10-01'),
('Produce TV commercial', 500000.00, 5, '2021-11-01'),
('Record radio ad', 100000.00,6, '2021-10-15'),
('Design billboard advertisement', 200000.00, 6, '2021-10-01');

INSERT INTO advertising_publication_application (application_id, content, advertising_publication_id, release_date) VALUES
(1, 'Homepage design layout and interactive features', 2, '2022-07-01'),
(2, 'Mobile app wireframes and user interface design', 2, '2022-07-15'),
(3, 'Logo options and brand identity guidelines', 4, '2022-07-06'),
(4, 'Advertising campaign concept and media plan', 3, '2022-09-01'),
(5, 'Graphic design services for marketing materials', 5, '2022-01-01');


INSERT INTO employee_task (application_id, employee_id, task_status_id, task_title, task_description, deadline) VALUES
(1, 1, 1, 'create animation logo', 'create animation logo', '2021-10-15'),
(1, 2, 1, 'Create marketing strategy', 'Create marketing strategy', '2021-10-29'),
(1, 3, 1, 'draw logo', 'draw logo', '2021-10-29'),
(1, 4, 1, 'create description for product', 'create description for product', '2021-10-29'),

(2, 6, 1, 'create server report', 'create server report', '2021-10-29'),
(2, 7, 1, 'analys existed marketing', 'analys existed marketing', '2021-10-29'),
(2, 8, 1, 'create a landing', 'create a landing', '2021-10-29'),
(2, 9, 1, 'create description for the site', 'create description for the site', '2021-10-29'),

(3, 11, 1, 'create server report', 'create server report', '2021-10-29'),
(3, 12, 1, 'analys existed marketing', 'analys existed marketing', '2021-10-29'),
(3, 13, 1, 'create a landing', 'create a landing', '2021-10-29'),
(3, 14, 1, 'create description for the site', 'create description for the site', '2021-10-29');

INSERT INTO employee_task (application_id, employee_id, task_status_id, task_title, task_description, deadline) VALUES
(11, 6, 1, 'create server report', 'create server report', '2021-10-29'),
(11, 7, 1, 'analys existed marketing', 'analys existed marketing', '2021-10-29'),
(11, 8, 1, 'create a landing', 'create a landing', '2021-10-29'),
(11, 9, 1, 'create description for the site', 'create description for the site', '2021-10-29');
