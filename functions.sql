SET search_path TO 'advertising_agency';

DROP FUNCTION IF EXISTS get_least_loaded_team_id CASCADE;
DROP FUNCTION IF EXISTS get_least_loaded_manager_id CASCADE;
DROP FUNCTION IF EXISTS get_application_id_by_payment_note_id CASCADE;

CREATE OR REPLACE FUNCTION get_least_loaded_team_id()
RETURNS INTEGER AS $$
DECLARE
  _team_id INT;
BEGIN
  IF (SELECT COUNT(*) FROM team_project) = 0 THEN
  RAISE EXCEPTION 'There are not any team exist, cannot procced';
  END IF;

  SELECT team_id INTO _team_id from team_project
  WHERE application_count = (SELECT MIN(application_count) from team_project)
  LIMIT 1;

  RETURN _team_id;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_least_loaded_manager_id()
RETURNS INTEGER AS $$
DECLARE
  _manager_id INT;
BEGIN
  if (SELECT COUNT(*) FROM manager) = 0 THEN
  RAISE EXCEPTION 'There are 0 rows in manager table, cannot procced';
  END IF;

  SELECT manager.id INTO _manager_id FROM manager
  WHERE application_count = (SELECT MIN(application_count) from manager)
  LIMIT 1;

  RETURN _manager_id;
END
$$ LANGUAGE plpgsql;

/*
CREATE OR REPLACE FUNCTION get_manager_id_by_application_id(application_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
  _manager_id INT;
BEGIN
  IF (SELECT COUNT(*) FROM advertiser_application
      WHERE id = application_id AND manager_id is not null) = 0 THEN
      RAISE EXCEPTION 'there are not any row in advertiser_application by id = %, or there is manager = null', application_id;
  END IF;
  SELECT manager_id INTO _manager_id FROM advertiser_application
  WHERE id = application_id;

  RETURN _manager_id;
END
$$ LANGUAGE plpgsql;
*/

CREATE OR REPLACE FUNCTION get_application_id_by_payment_note_id(_payment_note_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
  advertiser_application_id INT;
BEGIN
  IF (SELECT COUNT(*) FROM advertising_publication_application WHERE advertising_publication_application.payment_note_id = _payment_note_id) = 0 THEN
    RAISE EXCEPTION 'unable to find advertising_publication_application row that has % payment note id', _payment_note_id;
  END IF;

  SELECT application_id INTO advertiser_application_id FROM advertising_publication_application WHERE advertising_publication_application.payment_note_id = _payment_note_id;

  RETURN advertiser_application_id;
END
$$ LANGUAGE plpgsql;
