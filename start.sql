-- \dn
-- \dt+
-- \dt table_name
-- \dt schema_name.*

-- database name variable
\set DATABASE_NAME 'advertising_agency'
\set SCHEMA_NAME 'advertising_agency'

DROP DATABASE IF EXISTS :DATABASE_NAME;
CREATE DATABASE :DATABASE_NAME;

DROP USER IF EXISTS advertiser;
DROP USER IF EXISTS admin;
DROP USER IF EXISTS employee;

CREATE USER advertiser WITH ENCRYPTED PASSWORD '12345';
CREATE USER admin WITH ENCRYPTED PASSWORD '12345';
CREATE USER employee WITH ENCRYPTED PASSWORD '12345';

REVOKE ALL ON DATABASE :DATABASE_NAME FROM PUBLIC;

-- give privileges for connection to database
GRANT CONNECT ON DATABASE :DATABASE_NAME TO advertiser, admin, employee;

\c :DATABASE_NAME postgres

DROP SCHEMA IF EXISTS :SCHEMA_NAME;
CREATE SCHEMA :SCHEMA_NAME;

-- give all privileges to use any tables in schema to admin
ALTER SCHEMA :SCHEMA_NAME OWNER TO admin;
GRANT ALL ON ALL TABLES IN SCHEMA :SCHEMA_NAME TO admin;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA :SCHEMA_NAME TO admin;

-- give privilages to use created schema
GRANT USAGE ON SCHEMA :SCHEMA_NAME TO PUBLIC;

\c :DATABASE_NAME admin

-- create tables, after that views, functions, triggers and insert data to tables
