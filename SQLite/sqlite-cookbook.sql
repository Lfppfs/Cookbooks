-- these are notes from random sites and from Allesina and Wilmes (2019) Computing Skills for Biologists
-- tables that are not created within this script are available from the book site: http://computingskillsforbiologists.com/
 -- useful commands
-- .databases (list attached databases)
-- .exit
-- .header on|off (turn header on|off)
-- .help
-- .import (import data from file into table)
-- .mode (Set output mode to one of csv, column, line or others)
-- .output <filename> (send output to file)
-- .output stdout (send output to screen)
-- .schema (show the create statements)
-- .shell <command> (run terminal command)
-- .separator <string> (change separator used by output mode an .import)
-- .show (show the current status of settings)
-- .tables ?PATTERN? (list names of tables, optionally matching a LIKE pattern)
-- .width <num> <num> (set column width for column mode)
-- .timer on|off (display timer of queries)
-- line below is intended for better visualization
.mode column .header on .width 5 5 5 4 4 4 4
-- if we run ".mode line", queries will show fields one after the other (a newline is used for each field) instead of printing them next to each other. that is the opposite of .mode column
 -- storage classes in SQLite are NULL, INTEGER, REAL, TEXT and BLOB. each storage class may contain different data types. Dates and time must be stored as integer, real or text
 -- creating a new database <testDB.db>, when initializing sqlite in terminal
-- sqlite3 testDB.db
-- The above command will create a file testDB.db in the current directory.
 -- Consider a case when you have multiple databases available and you want to use any one of them at a time. SQLite ATTACH DATABASE statement is used to select a particular database, and after this command, all SQLite statements will be executed under the attached database.
 -- ATTACH DATABASE 'DatabaseName' As 'Alias-Name';
 -- The above command will also create a database in case the database is already not created
ATTACH DATABASE 'comte.db' AS 'comte2';

.databases
-- The database names main and temp are reserved for the primary database and database to hold temporary tables and other temporary data objects. Both of these database names exist for every database connection and should not be used for attachment
 -- use DETACH DATABASE to detach and dissociate a named database from a database connection which was previously attached using ATTACH statement.
 -- arithmetic, comparison, logical and bitwise operators can be found at https://www.tutorialspoint.com/sqlite/sqlite_operators.htm
 -- see https://code.mteixeira.dev/SublimeText-SQLTools/ for useful sublime package SQLTools commands
-- see also https://sqlite.org/docs.html for sqlite docs
-- see also https://www.sqlite.org/lang_select.html for a diagram containing
-- which operations and order of operations is allowed
-- the lines below run sqlite, then load a
-- csv file and save it as a database
-- sqlite3
-- .mode csv
-- .import ../data/Lohr2015_data.csv lohr
-- .save lohr.db
-- opening a database
.open lohr.db
-- alternatively, loading the database directly when initiating sqlite
-- sqlite3 lohr.db
 -- various clauses:
-- select first 4 rows

SELECT *
FROM lohr
LIMIT 4;

SELECT *
FROM lohr
LIMIT 4;

SELECT SIZE,
       pop
FROM lohr
LIMIT 5;

SELECT DISTINCT SIZE,
                pop
FROM lohr;

SELECT DISTINCT pop
FROM lohr
ORDER BY pop;

SELECT DISTINCT pop
FROM lohr
ORDER BY pop DESC;

-- get 3 values after skipping 4 values
SELECT DISTINCT pop
FROM lohr
LIMIT 3
OFFSET 4;

-- since the data only has TEXT fields, the ordering
-- does not work well when dealing with numbers:
SELECT DISTINCT ro
FROM lohr
ORDER BY ro
LIMIT 3
OFFSET 10;
-- the ordering above is done alphabetically,
-- not numerically. This is corrected by casting:
SELECT DISTINCT ro
FROM lohr
ORDER BY CAST(ro AS INTEGER) DESC
LIMIT 3;

SELECT MIN(afr)
FROM lohr;

SELECT clone,
       pop,
       SIZE
FROM lohr
WHERE SIZE = "Large"
LIMIT 5;

SELECT ro
FROM lohr
WHERE CAST(ro AS INTEGER) > 140
    AND CAST(ro AS INTEGER) < 142;

SELECT cast(ro AS INTEGER) AS ro_numerical
FROM lohr
WHERE CAST(ro AS INTEGER) > 140
    AND CAST(ro AS INTEGER) < 142;

SELECT cast(ro AS INTEGER) AS ro_numerical
FROM lohr
WHERE CAST(ro AS INTEGER) > 140
    OR CAST(ro AS INTEGER) < 142;

-- wildcards using regex
-- % matches one or more characters
-- _ (underscore) matches one character
SELECT DISTINCT pop
FROM lohr
WHERE pop LIKE "%T";

SELECT DISTINCT pop
FROM lohr
WHERE pop LIKE "B%";

SELECT DISTINCT pop
FROM lohr
WHERE pop LIKE "A___";

-- the clause GLOB works as LIKE, but is case
-- sensitive and uses the wildcards from Unix
SELECT DISTINCT pop
FROM lohr
WHERE pop GLOB "K*";

SELECT DISTINCT pop
FROM lohr
WHERE pop GLOB "?1?";

SELECT SIZE,
       AVG(CAST(ad AS INTEGER)) AS avglifespan
FROM lohr
GROUP BY SIZE;

-- count the number of individual from each pop
SELECT pop,
       COUNT(pop) AS n
FROM lohr
GROUP BY pop;

-- HAVING vs WHERE
-- The WHERE clause places conditions on the selected fields, whereas the HAVING clause places conditions on groups created by GROUP BY clause.
-- the HAVING clause must follow the GROUP BY clause and must also precede the ORDER BY clause
SELECT pop,
       COUNT(pop) AS n
FROM lohr
GROUP BY pop
HAVING n > 200
ORDER BY n DESC;

SELECT pop,
       AVG(afr)
FROM lohr
GROUP BY pop;

SELECT pop,
       COUNT(pop)
FROM lohr
GROUP BY pop
HAVING ad < 55;

-- the line below should stay commented unless it has to be run, as for some reason the sqltool package formatting (Ctrl E + Ctrl B) changes data to DATA and breaks the path
.open ../data/Comte2016.db
.schema
.tables
.databases
-- IN operator
-- query values filtering with a given vector
SELECT *
FROM lohr
LIMIT 2;

SELECT *
FROM lohr
WHERE clone IN (1,
                13);

SELECT *
FROM lohr
WHERE clone NOT IN (1,
                    13);

-- BETWEEN
SELECT *
FROM lohr
WHERE ro BETWEEN 200 AND 236;

-- subqueries
-- A subquery is a SELECT statement nested in another statement. It can be used to query records from a table based on the records from another table.
-- For example, the following statement queries the value of Basin from the table site in which SiteID has the same value as in the record in which anguilla has the value "persisted" in the table trans
SELECT Basin
FROM site
WHERE SiteID =
        (SELECT SiteID
         FROM trans
         WHERE anguilla = "persisted");

-- same as above, but querying field CoordX instead of Basin
SELECT CoordX
FROM site
WHERE SiteID =
        (SELECT SiteID
         FROM trans
         WHERE anguilla = "persisted");
-- we can check that this is correct by looking at the two queries below
SELECT *
FROM site
LIMIT 1;

SELECT *
FROM trans
LIMIT 1;

-- the subqueries above return only the first value queried, but if the query should return multiple values, the IN operator allows returning all of them
SELECT Basin
FROM site
WHERE SiteID IN
        (SELECT SiteID
         FROM trans
         WHERE anguilla = "persisted");

SELECT Count(Basin)
FROM site
WHERE SiteID IN
        (SELECT SiteID
         FROM trans
         WHERE anguilla = "persisted");

-- a subquery can also be used to concatenate different operations
-- the line below performs a sum of Urban, grouped by Basin; this sum is stored
-- in an alias sum_alias.sum_result, and then the outer query takes the average
-- of this alias
SELECT AVG(sum_alias.sum_result) FROM
    ( SELECT SUM(Urban) sum_result
     FROM site
     GROUP BY (Basin)) AS sum_alias;

-- CASE
-- the CASE clause evaluates a list of conditions and returns an expression based on the result of the evaluation.
SELECT *,
       CASE anguilla
           WHEN 'persisted' THEN 'P'
           WHEN 'unoccupied' THEN 'U'
           ELSE 'other'
       END
FROM trans;

--  if the ELSE clause is omitted, NULL is returned
 -- EXISTS
-- The EXISTS operator is used to search for the presence of a row in a specified table that meets certain criteria.
-- it must be used with a subquery
-- note that the exists operator returns ALL records if at least one record is true
-- the following statement queries ALL records from the field clone
-- if at least one line from ro == 200
SELECT CLONE
FROM lohr
WHERE EXISTS
        (SELECT 1
         FROM lohr
         WHERE ro == 200);
-- we can check that it returned all records from the field clone by
-- counting the query and comparing it to the count of all rows
-- from the table:
SELECT COUNT(clone)
FROM lohr
WHERE EXISTS
        (SELECT 1
         FROM lohr
         WHERE ro == 200);

SELECT COUNT(*)
FROM lohr;

-- note that the subquery contains 'SELECT 1', and thus will return 1 if a record has ro == 200:
SELECT 1
FROM lohr
WHERE ro = 200;

SELECT anguilla,
       COUNT(anguilla) AS num
FROM trans
WHERE Per1 = "P1"
    AND Per2 = "P2"
GROUP BY anguilla;

SELECT Basin,
       anguilla,
       COUNT(anguilla)
FROM site
INNER JOIN trans ON site.SiteID = trans.SiteID
WHERE Per1 = "P1"
    AND Per2 = "P2"
GROUP BY Basin,
         anguilla;

-- views
-- a view is a virtual table that can be queried like a proper table but does not occupy space on disk
-- A view can contain all or only some rows of a table, and can be created from one or many tables
-- views allow users to: structure data in an intuitive way; restrict access to the data, such that a user can only see limited data instead of a complete table; summarize data from various tables, and this can be used to generate reports.
-- views are read-only and thus you may not be able to execute a DELETE, INSERT or UPDATE statement on a view. However, you can create a trigger on a view that fires on an attempt to DELETE, INSERT, or UPDATE a view and do what you need in the body of the trigger.
CREATE VIEW both_tables AS
SELECT *
FROM site
INNER JOIN trans ON site.SiteID = trans.SiteID;

.tables
.schema
SELECT Basin,
       AVG(Urban)
FROM site
GROUP BY Basin;

SELECT DISTINCT Basin
FROM both_tables
WHERE Per1 = "P3"
    AND Per2 = "P4"
    AND anguilla = "extirpated"
    AND lucius = "extirpated";
-- views can be dropped using DROP VIEW <view_name>;

-- .dump command exports d database to a text file
-- USING SHELL COMMANDS
-- sqlite3 <database.db> .dump > <filename.sql>
-- this converts <database.db> database into SQLite statements and dumps it into an ASCII text file <filename.sql>. the .sql ending is arbitrary. the file can then be restored as a database, as such:
-- sqlite3 <database.db> < <filename.sql>
-- USING SQLITE PROMPT
-- .output <filename.sql>
-- .dump
-- the file has sql statements to rebuild the database
-- .shell head <filename.sql>
-- .shell head -n 50 <filename.sql>
-- .exit
-- restoring the database:
-- sqlite3
-- .read <filename.sql>
 
 -- CREATE TABLE creates a table in a database by naming its fields and datatypes
-- this is an example which creates a COMPANY table with ID as the primary key and NOT NULL as constraints (i.e., these fields cannot be NULL while creating records in this table)
CREATE TABLE some_random_table( ID INT PRIMARY KEY NOT NULL,
       NAME TEXT NOT NULL,
       AGE INT NOT NULL,
       ADDRESS CHAR(50),
       SALARY REAL);

.tables
-- CREATE TABLE can also be used to copy one table to another
CREATE TABLE site_copy AS
SELECT *
FROM site;

-- DROP TABLE is used to remove a table definition and all data associated to it. Once a table is deleted then all the information available in the table is lost
-- DROP TABLE database_name.table_name;

-- insert values by hand
-- values defined along with the insert command
-- insert in all fields
INSERT INTO site_copy
VALUES (1,
        2,
        3,
        4,
        5,
        6);

-- insert in a specific field
INSERT INTO site_copy (SiteID)
VALUES (1000);

-- predefined values from other table
INSERT INTO site_copy
SELECT *
FROM site;

SELECT *
FROM site_copy
WHERE SiteID = 1;

-- update records
-- changing all "persisted" from anguilla to "PERSISTED"
UPDATE trans
SET anguilla = "PERSISTED"
WHERE anguilla = "persisted";

SELECT COUNT(anguilla)
FROM trans
WHERE anguilla = "persisted";

SELECT COUNT(anguilla)
FROM trans
WHERE anguilla = "PERSISTED";

-- changing back
UPDATE trans
SET anguilla = "persisted"
WHERE anguilla = "PERSISTED";

SELECT COUNT(anguilla)
FROM trans
WHERE anguilla = "persisted";

SELECT COUNT(anguilla)
FROM trans
WHERE anguilla = "PERSISTED";

-- deleting records
SELECT *
FROM site_copy
LIMIT 1;

DELETE
FROM site_copy
WHERE SiteID = "27900";

SELECT *
FROM site_copy
LIMIT 1;

-- deleting tables and views
-- DROP TABLE <TABLE>;
-- DROP VIEW <VIEW>;
.help
-- sending output to file instead of terminal
.separator ,
.output test.csv

SELECT DISTINCT Basin,
                SiteID
FROM site;

.shell head test.csv
-- running .output again resets the output to the terminal
.output

-- UPDATE
-- UPDATE is used to modify the existing records in a table. best used with the WHERE clause, to update only selected rows
SELECT *
FROM lohr
WHERE ro == 236
    AND ad == 87;

UPDATE lohr
SET ro = 100,
    ad = 100
WHERE ro == 236
    AND ad == 87;

SELECT *
FROM lohr
WHERE ro == 100
    AND ad == 100;

SELECT *
FROM lohr
WHERE ro == 236
    AND ad == 87;

-- DELETE
DELETE
FROM lohr
WHERE ro == 236;

SELECT *
FROM lohr
WHERE ro == 236;

-- PRAGMA
-- The PRAGMA statement is an SQL extension specific to SQLite and used to modify the operation of the SQLite library or to query the SQLite library for internal (non-table) data. see https://www.sqlite.org/pragma.html

-- Constraints
-- constraints are used to limit the type of data that can go into a table
-- the following statement creates a table called company with the following constraints:
-- id and name cannot have null values
-- name can only have unique values (different rows cannot have the same value)
-- salary has a default value, so a value of 50000 is inserted in a row if an INSERT INTO statement does not provide a specific value
-- id is a PRIMARY KEY. Primary keys are used to refer to table rows, and become foreign keys in other tables. primary keys must contain unique values
-- age is checked. the CHECK Constraint enables a condition to check the value being entered into a record. If the condition evaluates to false, the record violates the constraint and isn't entered into the table.
CREATE TABLE COMPANY(
       ID INT PRIMARY KEY NOT NULL,
       NAME TEXT NOT NULL UNIQUE,
       AGE INT CHECK (AGE > 18),
       ADDRESS CHAR(50),
       SALARY REAL DEFAULT 50000.00);

-- JOIN
-- the JOIN clause is used to combine records from two or more tables in a database
-- there are three types of JOIN: cross, inner and outer
-- let's populate the company table created above
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 
        'Paul', 
        32, 
        'California',
        20000.00);

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2,
        'Allen',
        25,
        'Texas',
        15000.00);

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3,
        'Teddy',
        23,
        'Norway',
        20000.00);

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4,
        'Mark',
        25,
        'Rich-Mond ',
        65000.00);

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5,
        'David',
        27,
        'Texas',
        85000.00);

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6,
        'Kim',
        22,
        'South-Hall',
        45000.00);

SELECT *
FROM COMPANY;

-- and create a new table
CREATE TABLE DEPARTMENT(
       ID INT PRIMARY KEY NOT NULL,
       DEPT CHAR(50) NOT NULL,
       EMP_ID INT NOT NULL);

INSERT INTO DEPARTMENT (ID, DEPT, EMP_ID)
VALUES (1,
        'IT Billing',
        1);

INSERT INTO DEPARTMENT (ID, DEPT, EMP_ID)
VALUES (2,
        'Engineering',
        2);

INSERT INTO DEPARTMENT (ID, DEPT, EMP_ID)
VALUES (3,
        'Finance',
        7);

SELECT *
FROM DEPARTMENT;

-- CROSS JOIN matches every row of the first table with every row of the second table
SELECT *
FROM COMPANY
CROSS JOIN DEPARTMENT;

-- proof:
SELECT COUNT(*)
FROM COMPANY;

SELECT COUNT(*)
FROM DEPARTMENT;

SELECT COUNT(*)
FROM COMPANY
CROSS JOIN DEPARTMENT;

-- INNER JOIN (alternatively, only JOIN) compares each row of table1 with each row of table2 and joins based on all pairs of rows that satisfy the join-predicate
SELECT EMP_ID,
       NAME,
       DEPT
FROM COMPANY
INNER JOIN DEPARTMENT ON COMPANY.ID = DEPARTMENT.ID;

-- alternatively, instead of using ON, using USING (both tables must have the same field specified to the USING statement):
SELECT EMP_ID,
       NAME,
       DEPT
FROM COMPANY
JOIN DEPARTMENT USING (ID);

-- LEFT OUTER JOIN does the same as the inner, but also appends any unjoined
-- rows
SELECT EMP_ID,
       NAME,
       DEPT
FROM COMPANY
LEFT OUTER JOIN DEPARTMENT USING (ID);

-- note that if we invert the order of tables, we get:
SELECT EMP_ID,
       NAME,
       DEPT
FROM DEPARTMENT
LEFT OUTER JOIN COMPANY USING (ID);

-- UNION
-- the UNION clause/operator is used to combine queries. To use UNION, each SELECT must have the same number of columns selected, the same number of column expressions, the same data type, and have them in the same order, but they do not have to be of the same length.
-- Both UNION and UNION ALL operators combine rows from result sets into a single result set. The UNION operator eliminate duplicate rows, whereas the UNION ALL operator does not.
INSERT INTO DEPARTMENT (ID, DEPT, EMP_ID)
VALUES (4,
        'IT Billing',
        10);

INSERT INTO DEPARTMENT (ID, DEPT, EMP_ID)
VALUES (5,
        'Engineering',
        11);

INSERT INTO DEPARTMENT (ID, DEPT, EMP_ID)
VALUES (6,
        'Finance',
        12);

SELECT ID,
       NAME
FROM COMPANY
UNION
SELECT EMP_ID,
       DEPT
FROM DEPARTMENT;

SELECT ID,
       NAME
FROM COMPANY
UNION ALL
SELECT EMP_ID,
       DEPT
FROM DEPARTMENT;

-- REPLACE
-- The REPLACE clause deletes a row and inserts a new row if a unique or primary key violation occurs
-- in the COMPANY table, the field NAME is unique, thus we get an error if
-- we try this:
INSERT INTO COMPANY (NAME, ID)
VALUES ("Paul",
        7);
-- but if we use replace, the previous record is deleted and a new one is added
SELECT *
FROM COMPANY;

REPLACE INTO COMPANY (NAME, ID)
VALUES ("Paul",
        7);

SELECT *
FROM COMPANY;

-- Note that the query above wouldn't work if it didn't include
-- a value to replace the ID field, since this field has a NOT NULL constraint.
-- thus, the query below returns an error:
REPLACE INTO COMPANY (NAME)
VALUES ("Paul");

-- TRIGGERS
-- Triggers are database callback functions that are automatically invoked when a DELETE, INSERT or UPDATE of a particular database table occurs
-- below we create a trigger that inserts a record in a table called audit
-- whenever a value is inserted in the table company
CREATE TABLE audit(
       ID INTEGER NOT NULL,
       ENTRY_DATE TEXT NOT NULL
);

SELECT *
FROM AUDIT;

CREATE TRIGGER audit_log AFTER
INSERT ON COMPANY BEGIN
INSERT INTO audit(ID, ENTRY_DATE)
VALUES (new.ID,
        datetime('now')); END;

INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (20,
        'Todd',
        32,
        'California',
        20000.00);


SELECT *
FROM AUDIT;

-- triggers are stored in sqlite_master, which holds the database schema
SELECT name
FROM sqlite_master
WHERE TYPE = 'trigger';

-- triggers can be dropped with DROP TRIGGER <TRIGGER_NAME>;

-- EXCEPT
-- the EXCEPT operator compares the result sets of two queries and returns distinct rows from the left query that are not output by the right query. it has two rules: the number of columns in the select lists of both queries must be the same; and the order of the columns and their types must be comparable
-- let's create two tables
CREATE TABLE t1( v1 INT);

INSERT INTO t1(v1)
VALUES(1),(2),(3);

CREATE TABLE t2( v2 INT);

INSERT INTO t2(v2)
VALUES(2),(3),(4);

-- now, if we run this:
SELECT v1
FROM t1
EXCEPT
SELECT v2
FROM t2;
-- the query returns 1
-- and if we run this:
SELECT v2
FROM t2
EXCEPT
SELECT v1
FROM t1;
-- the query returns 4

-- INTERSECT
-- the INTERSECT operator is similar to EXCEPT, but it returns distinct rows that are output by both queries. It also has two rules: the number and the order of the columns in all queries must be the same; and the data types must be comparable
SELECT v1
FROM t1 INTERSECT
SELECT v2
FROM t2;

-- transactions
-- A transaction is a set of SQL statements that execute together as a single SQL statement
-- SQLite usually is in auto-commit mode, that is, for each command, SQLite starts, processes, and commits the transaction automatically.
-- if we want to control these transactions to maintain data consistency and to handle database errors, we can disable auto-commit mode and explicitly start the transactions based on our requirements. if any errors occurr during execution, then the complete transaction will be rollbacked
-- a transaction consists of 3 clauses: BEGIN (starts the transaction), COMMIT (also END TRANSACTION, commits the transaction, ie, saves changes to the database) and ROLLBACK (rollbacks transactions that have not been saved to the database and ends the transaction)
CREATE TABLE dummy_table( variable1 INT, variable2 INT);

BEGIN;

INSERT INTO dummy_table (variable1, variable2)
VALUES(100,
       200);

SELECT *
FROM dummy_table;

COMMIT;

BEGIN;

INSERT INTO dummy_table (variable1, variable2)
VALUES(400,
       400);

SELECT *
FROM dummy_table;

ROLLBACK;

SELECT *
FROM dummy_table;

-- Indexes
-- indexes are used to improve the performance of data retrieval by quickly identifying the records in a separate table instead of searching each and every row of the database table
-- whenever we create an index on a table column it will rearrange the table records and will use extra storage space to maintain the index data structure
-- an index helps speed up SELECT queries and WHERE clauses, but slows down data input with UPDATE and INSERT statements
SELECT *
FROM COMPANY;
.schema COMPANY
-- single-column index
CREATE UNIQUE INDEX index_1 ON COMPANY (NAME);
-- (UNIQUE is optional)
-- composite index
CREATE UNIQUE INDEX index_2 ON COMPANY (NAME, AGE);
-- this function checks for existing indices
.indices COMPANY
-- the table name is optional
-- the two other indices apart from what we created above are implicit indexes. thse are automatically created by the database server when an object containing primary key constraints or unique constraints is created
-- an index can be dropped using DROP INDEX <index_name>;
-- we can use EXPLAIN QUERY PLAN clause to check if and what indices are being used in a query:
EXPLAIN QUERY PLAN
SELECT NAME
FROM COMPANY;

EXPLAIN QUERY PLAN
SELECT NAME,
       AGE
FROM COMPANY;

-- this link explains how EXPLAIN QUERY PLAN works: https://www.sqlite.org/eqp.html
-- we can use "INDEXED BY index-name" to specify that the named index must be used in a query, and the "NOT INDEXED" clause specifies that no index shall be used in a query
EXPLAIN QUERY PLAN
SELECT NAME,
       AGE
FROM COMPANY INDEXED BY index_2;

EXPLAIN QUERY PLAN
SELECT NAME,
       AGE
FROM COMPANY NOT INDEXED;

-- ALTER TABLE
-- ALTER TABLE modifies an existing table, renaming it or adding columns

CREATE TABLE company_copy AS
SELECT *
FROM COMPANY;

ALTER TABLE main.company_copy RENAME TO new_company;

.tables
ALTER TABLE main.new_company ADD COLUMN new_column int(1);

SELECT *
FROM new_company;

.schema new_company

-- access SQLite through python
-- #!/usr/bin/python
-- import sqlite3
-- must create a connection before querying
-- connection = sqlite3.connect('../data/Comte2016.db')
-- connection
-- cursor = connection.execute("SELECT DISTINCT Basin FROM site")
-- for row in cursor:
--     print("Basin ", row[0])
-- connection.close()
 -- access through R
-- if (!("RSQLite" %in% installed.packages())){
--     install.packages("RSQLite", character.only = TRUE)
-- }
-- library(RSQLite)
-- specify the type of database
-- sqlite <- dbDriver("SQLite")
-- must create a connection before querying
-- connection <- dbConnect(sqlite, "../data/Comte2016.db")
-- results <- dbGetQuery(connection, "SELECT DISTINCT Basin FROM site")
-- str(results)
-- dbDisconnect(connection)