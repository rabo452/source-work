SET search_path TO 'advertising_agency';

DROP FUNCTION IF EXISTS add_application_event CASCADE;
DROP FUNCTION IF EXISTS add_advertising_publication_application_event CASCADE;
DROP FUNCTION IF EXISTS change_application_budget_event CASCADE;
DROP FUNCTION IF EXISTS complete_application_event CASCADE;
DROP FUNCTION IF EXISTS change_budget_event CASCADE;

-- функция которая автоматически определяет команду с найменьшей нагрузкой на созданную задачу
-- функция автоматически определить менеджера с найменьшей нагрузкой на созданную задачу
CREATE OR REPLACE FUNCTION add_application_event()
RETURNS TRIGGER AS $$
BEGIN
  NEW.team_id = get_least_loaded_team_id();
  NEW.manager_id = get_least_loaded_manager_id();
  NEW.remaining_budget = NEW.cost;
  NEW.status_id = 4;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- функция создаёт автоматически счёт об оплате
CREATE OR REPLACE FUNCTION add_advertising_publication_application_event()
RETURNS TRIGGER AS $$
DECLARE
  price DECIMAL(10, 2);
  payment_note_id INTEGER;
  title VARCHAR(50);
BEGIN
  SELECT name, advertising_publication.price INTO title, price FROM advertising_publication WHERE id = NEW.advertising_publication_id;
  WITH note as (
    INSERT INTO payment_note(is_paid, creation_date, text, price) VALUES(false, now(), CONCAT('payment for services ',title), price)
    RETURNING id
  )
  SELECT id INTO payment_note_id from note;
  NEW.payment_note_id = payment_note_id;
  NEW.release_date = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- функция которая после платежа автоматически меняет оставшийся бюджет заявки
CREATE OR REPLACE FUNCTION change_application_budget_event()
RETURNS TRIGGER AS $$
DECLARE
  advertiser_application_id INTEGER;
BEGIN
  IF OLD.is_paid = NEW.is_paid THEN
    RETURN NEW;
  END IF;

  IF OLD.is_paid = false and NEW.is_paid = true THEN
    advertiser_application_id = get_application_id_by_payment_note_id(NEW.id);
    UPDATE advertiser_application set remaining_budget = remaining_budget - NEW.price WHERE advertiser_application.id = advertiser_application_id;
  END IF;

  IF OLD.is_paid = true and NEW.is_paid = false THEN
    advertiser_application_id = get_application_id_by_payment_note_id(NEW.id);
    UPDATE advertiser_application set remaining_budget = remaining_budget + NEW.price WHERE advertiser_application.id = advertiser_application_id;
  END IF;

  RETURN NEW;
END
$$ LANGUAGE plpgsql;

-- функция которая добавляет бюджет к существующей заявке и высчитывает общую стоимость и оставшийся бюджет
CREATE OR REPLACE FUNCTION change_budget_event()
RETURNS TRIGGER AS $$
BEGIN

  IF OLD.status_id = 1 THEN
    RAISE NOTICE 'you cannot change somehow application once its done';
    RETURN NEW;
  END IF;

  IF NEW.cost > OLD.cost AND NEW.remaining_budget = OLD.remaining_budget THEN
    NEW.remaining_budget = new.remaining_budget + (NEW.cost - OLD.cost);
  END IF;

  IF OLD.cost > NEW.cost THEN
    RAISE EXCEPTION 'you cannot decrease budget from existed application';
  END IF;

  RETURN NEW;
END
$$ LANGUAGE plpgsql;

-- функция которая заканчивает все задачи для определённого проекта когда проект закончен
CREATE OR REPLACE FUNCTION complete_application_event()
RETURNS TRIGGER AS $$
BEGIN
  RAISE NOTICE 'Old application status id: % NEW application status id %', OLD.status_id, NEW.status_id;
  -- if application is complete, complete all employee tasks related with application
  IF OLD.status_id = 4 AND NEW.status_id = 1 THEN
    UPDATE employee_task SET task_status_id = 3 WHERE application_id = NEW.id;
  END IF;
  RETURN NEW;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER new_application_trigger
BEFORE INSERT on advertiser_application
FOR ROW
EXECUTE FUNCTION add_application_event();

CREATE OR REPLACE TRIGGER new_advertising_publication_application_triger
BEFORE INSERT on advertising_publication_application
FOR ROW
EXECUTE FUNCTION add_advertising_publication_application_event();

CREATE OR REPLACE TRIGGER payment_note_paid_trigger
BEFORE UPDATE on payment_note
FOR ROW
EXECUTE FUNCTION change_application_budget_event();

CREATE OR REPLACE TRIGGER change_budget_trigger
BEFORE UPDATE on advertiser_application
FOR ROW
EXECUTE FUNCTION change_budget_event();

CREATE OR REPLACE TRIGGER complete_application_trigger
BEFORE UPDATE ON advertiser_application
FOR ROW
EXECUTE FUNCTION complete_application_event();
