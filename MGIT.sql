CREATE DATABASE BFSI;           -- create a new database


SHOW DATABASES;                 -- check all databses list


USE BFSI;                       -- choose database (BFSI) session


USE PRACTICE;					-- choose database (PRACTICE) session


CREATE TABLE EMPLOYEE (EMP_ID INT PRIMARY KEY, EMP_NAME VARCHAR(50), DEPT VARCHAR(20), SALARY INT);    -- create a table employee


INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, DEPT, SALARY)         -- insert values in table
			  VALUES (101, 'Smith', 'HR', 60000),
					 (102, 'John', 'IT', 55000),
                     (103, 'James', 'Finance', 62000),
                     (104, 'Alina', 'HR', 57500),
                     (105, 'Mark', 'Finance', 53000),
                     (106, 'Adam', 'IT', 61500);
                     
                     
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, DEPT, SALARY)
			  VALUES (107, 'Jacob', 'IT', 74500),
					 (108, 'Perry', 'HR', 69000);


DELETE FROM EMPLOYEE
WHERE EMP_ID = 108;                -- remove single row/record


TRUNCATE TABLE EMP_RECORD;         -- remove all the rows of a table but structure (columns) remain


DROP TABLE EMPLOYEE;               -- Remove the existance of table from database


RENAME TABLE EMP_RECORD TO EMPLOYEE;        -- Rename a table


ALTER TABLE EMP_RECORD CHANGE EMP_NAME E_NAME VARCHAR(50);       -- rename a column of a table


SELECT EMP_NAME, SALARY FROM EMPLOYEE;         -- show desired columns


SELECT * FROM EMPLOYEE
LIMIT 3;                                      -- Top 3 records


SELECT * FROM EMPLOYEE
LIMIT 4, 3;                                   -- show middle records


SELECT * FROM EMPLOYEE
ORDER BY SALARY ASC;                 -- Salary in ascending order


SELECT * FROM EMPLOYEE
ORDER BY SALARY;                     -- By default order is 'ASC - ascending'


SELECT * FROM EMPLOYEE
ORDER BY DEPT;                       -- Department in ascending order


SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC;                 -- Salary in descending order


SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC
LIMIT 3;                              -- top 3 highest salary holder employees


SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC
LIMIT 1,1;                            -- 2nd highest salary holder employee


SELECT * FROM EMPLOYEE
WHERE DEPT = 'HR';                    -- filter records from HR department


SELECT * FROM EMPLOYEE
WHERE DEPT IN('HR', 'IT');            -- filter records from HR & IT departments


SELECT * FROM EMPLOYEE
WHERE SALARY >= 60000;               -- records where salary >= 60000


SELECT * FROM EMPLOYEE;               -- to check all the records of a table


-- ------------ AGGREGATE FUNCTIONS ----------------
-- COUNT
-- SUM
-- MIN
-- MAX
-- AVERAGE


SELECT COUNT(EMP_NAME) AS EMP_COUNT
FROM EMPLOYEE;

SELECT COUNT(EMP_NAME) AS `EMP COUNT`
FROM EMPLOYEE;

SELECT COUNT(EMP_NAME) `EMP COUNT`
FROM EMPLOYEE;

SELECT COUNT(DEPT) AS DEPT_COUNT
FROM EMPLOYEE;

SELECT COUNT(DISTINCT(DEPT)) AS UNIQ_DEPT_COUNT
FROM EMPLOYEE;


SELECT DISTINCT(DEPT) AS UNIQ_DEPT
FROM EMPLOYEE;


SELECT MAX(SALARY) AS MAX_SAL
FROM EMPLOYEE;


SELECT MIN(SALARY) AS MIN_SAL
FROM EMPLOYEE;


SELECT SUM(SALARY) AS TOT_SAL
FROM EMPLOYEE;


SELECT DEPT, SUM(SALARY) AS TOT_SAL
FROM EMPLOYEE
GROUP BY DEPT;


SELECT DEPT, MAX(SALARY) AS MAX_SAL
FROM EMPLOYEE
GROUP BY DEPT;


SELECT DEPT, AVG(SALARY) AS AVERAGE_SAL
FROM EMPLOYEE
GROUP BY DEPT;


SELECT EMP_NAME, SALARY FROM EMPLOYEE
ORDER BY SALARY DESC
LIMIT 1, 1;


SELECT MAX(SALARY) AS SECOND_HIGHEST_SAL
FROM EMPLOYEE
WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE);


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    WHERE SALARY < (
        SELECT MAX(SALARY)
        FROM EMPLOYEE
    )
);


SELECT AVG(SALARY) AS AVERAGE_SAL
FROM EMPLOYEE;


SELECT ROUND(AVG(SALARY), 1) AS AVERAGE_SAL
FROM EMPLOYEE;


SELECT EMP_NAME, 'SAL' as Salary, SALARY FROM EMPLOYEE;


SELECT * FROM EMPLOYEE;               -- to check all the records of a table


-- --------------- ARITHMETIC OPERATIONS ----------------

SELECT 5 + 7 AS ADIITION;

SELECT 10 * 3 AS PRODUCT;

SELECT 23 % 10 AS REMAINDER;

SELECT * FROM SALES;

SELECT ORDER_ID, COUNTRY, TOTAL_AMOUNT FROM SALES;

-- 🔹 Q1: Find all orders shipped via 'Economy' mode with a total amount greater than ₹25,000.

SELECT * FROM SALES
WHERE Ship_Mode = 'Economy' AND Total_Amount > 25000;


SELECT Product_Name, Unit_Profit FROM Sales
ORDER BY Unit_Profit DESC
LIMIT 10;


-- Wildcards (%) --

SELECT COUNTRY FROM SALES
WHERE COUNTRY LIKE 'S%';




SELECT COUNTRY FROM SALES
WHERE COUNTRY LIKE 'AU%';

SELECT STATE FROM SALES
WHERE STATE LIKE '%N';


SELECT Order_ID, Product_Name FROM SALES
WHERE Product_Name LIKE '%Acco%';


SELECT CITY, SUM(TOTAL_AMOUNT) AS Total_Sales FROM SALES
GROUP BY CITY
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT CUSTOMER_NAME, TOTAL_AMOUNT FROM SALES
ORDER BY TOTAL_AMOUNT DESC
LIMIT 10 OFFSET 10;


SELECT CUSTOMER_NAME, TOTAL_AMOUNT FROM SALES
ORDER BY TOTAL_AMOUNT DESC
LIMIT 10, 10;

SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE ,
AVG(UNIT_COST) AS AVG_UNIT_COST, 
COUNT(ORDER_ID) AS ORDER_COUNT
FROM SALES;


select distinct(region) from sales;

select COUNT(distinct(region)) from sales;

SELECT CUSTOMER_NAME, COUNT(ORDER_ID) AS ORDER_COUNT FROM SALES
GROUP BY CUSTOMER_NAME
ORDER BY ORDER_COUNT DESC
LIMIT 5;


SELECT Product_Name, SUM(Total_Amount) AS Total_Sales,
       DENSE_RANK() OVER (ORDER BY SUM(Total_Amount) DESC) AS Sales_Rank
FROM Sales
GROUP BY Product_Name
limit 5;


WITH CHECK_RANK AS
(
SELECT Product_Name, SUM(Total_Amount) AS Total_Sales,
       DENSE_RANK() OVER (ORDER BY SUM(Total_Amount) DESC) AS Sales_Rank
FROM Sales
GROUP BY Product_Name
)
SELECT * FROM CHECK_RANK
WHERE Sales_Rank = 23;
