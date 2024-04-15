SET search_path TO 'advertising_agency';

-- show reviews from another advertisers (1)
select advertiser.full_name as advertiser_name, advertiser_review.grade, advertiser_review.text as review
from advertiser_review
JOIN advertiser on advertiser_review.advertiser_id = advertiser.id;

-- get manager contact phone (2)
select employee.name, employee.surname, employee.contact_phone, employee.email from advertiser_application
JOIN employee on advertiser_application.manager_id = employee.id
WHERE advertiser_application.id = 1;

-- get payment notes for advertising publications services (4)
SELECT payment_note.* from payment_note
WHERE payment_note.id IN (SELECT payment_note_id FROM advertising_publication_application WHERE application_id = 1);

-- get remaining_budget (3)
SELECT remaining_budget from advertiser_application WHERE id = 1;

-- increase budget (5)
UPDATE advertiser_application SET cost = cost + 100 WHERE id = 1;
