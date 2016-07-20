-- 1. Create a new postgres user named `indexed_cars_user`
DROP user IF EXISTS indexed_cars_user;
CREATE USER indexed_cars_user;

-- 1. Create a new database named `indexed_cars` owned by `indexed_cars_user`
DROP DATABASE IF EXISTS indexed_cars;
CREATE DATABASE "indexed_cars" OWNER "indexed_car_user";

-- 1. Run the provided `scripts/car_models.sql` script on the `indexed_cars` database   /*read from csv file*/
-- 1. Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times**
\timing

\connect indexed_cars;
\i scripts/car_models.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
\i scripts/car_model_data.sql
--    _there should be **223380** rows in `car_models`_
-- ## Timing Select Statements

CREATE INDEX make_title ON car_models (make_title);
CREATE INDEX model_title ON car_models (model_title);
CREATE INDEX make_code ON car_models (make_code, model_code, model_title);

-- Enable timing queries in Postgres by toggling the `\timing` command in the psql shell.

-- 1. Run a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)

-- SELECT make_title
--   FROM car_models
--   WHERE make_code = 'LAM'
--   LIMIT 1;
-- 2.749

-- 1. Run a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)

-- SELECT make_title
--   FROM car_models
--   WHERE make_code = 'NISSAN' AND make_code = 'GT-R'
--   LIMIT 1;
-- 0.855

-- 1. Run a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)

-- SELECT make_code, model_code, model_title, year
--   FROM car_models
--   WHERE make_code = 'LAM';
-- 49.217

-- 1. Run a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
-- SELECT *
--   FROM car_models
--   WHERE year > '2010'
--   AND year < '2015';
-- --  53.00

-- 1. Run a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
-- SELECT *
--   FROM car_models
--   WHERE year = '2010';
  --  32.49

  ----------------------------------------------------------------
  ----------------------------------------------------------------
  ----------------------------------------------------------------
  ----------------------------------------------------------------
-- ## Indexing
-- Given the current query requirements, "should get all make_titles", "should get a list of all model_titles by the make_code", etc.
-- Create indexes on the columns that would improve query performance.
-- To add an index:
-- ```
-- CREATE INDEX [index name]
--   ON [table name] ([column name(s) index]);
-- ```
-- \timing
-- Record your index statements in `indexing.sql`
-- Write the following statements in `indexing.sql`

-- 1. Create a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
-- SELECT make_title
--   FROM car_models
--   WHERE make_code = 'LAM'
--   LIMIT 1;

--   -- 2.869  >  2.051 > 1.772  >  2.265  > 0.883


-- 1. Create a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)
-- SELECT make_title
--   FROM car_models
--   WHERE make_code = 'NISSAN' AND make_code = 'GT-R'
--   LIMIT 1;

-- 0.855 > 0.948 > 1.001 > 1.548


-- 1. Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)
-- SELECT make_code, model_code, model_title, year
--   FROM car_models
--   WHERE make_code = 'LAM';

-- 49.217 > 22.227 > 26.07 > 1.765


-- 1. Create a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
-- SELECT *
--   FROM car_models
--   WHERE year > '2010'
--   AND year < '2015';

-- --  53.00  > 52.566 > 54.522 > 45.792

-- 1. Create a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
-- SELECT *
-- FROM car_models WHERE year = '2010';

-- 32.49 > 31.473 > 28.307

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
-- DROP INDEX make_title;
-- DROP INDEX model_title;
-- DROP INDEX make_code;


-- Compare the times of the queries before and after the table has been indexes.

-- Why are queries #4 and #5 not running faster?

-- ## Indexing on table create

-- 1. Add your recorded indexing statements to the `scripts/car_models.sql`
-- 1. Delete the `car_models` table
-- 1. Run the provided `scripts/car_models.sql` script on the `indexed_cars` database
-- 1. Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times**
--    _there should be **223380** rows in `car_models`_

DROP TABLE car_models;
\i scripts/car_models.sql;

\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;

\timing
-- end
\c user;