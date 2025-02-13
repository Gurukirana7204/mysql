# SQL Basics Assignment Questions

#1. Create a table called employees with the following structure?
#: emp_id (integer, should not be NULL and should be a primary key)Q
#: emp_name (text, should not be NULL)Q
#: age (integer, should have a check constraint to ensure the age is at least 18)Q
#: email (text, should be unique for each employee)Q
#: salary (decimal, with a default value of 30,000).

#Write the SQL query to create the above table with all constraints.

create database company;
use company;
create table employees
(emp_id int primary key,
emp_name varchar(40) not null,
age int check(age >=18),
email varchar(50),
salary decimal (10, 2) default 30000);

select* from employees;

#2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.

#Constraints in a database are rules that you define on your tables and columns to ensure that the data entered into the database meets certain criteria.  They are crucial for maintaining data integrity, which means ensuring that the data is accurate, consistent, and reliable.  Without constraints, databases could easily become filled with incorrect or inconsistent information, making them useless for decision-making or any other purpose.

#Here's a breakdown of the purpose and how they help, followed by examples:

#Purpose of Constraints:

#Data Integrity: Constraints prevent invalid data from being entered into the database. They act as gatekeepers, ensuring that only data that conforms to the defined rules is accepted.
#Consistency: They maintain consistency across the database. For example, a constraint can ensure that a foreign key always references a valid primary key in another table, preventing orphaned records.
#Accuracy: By enforcing rules about data types, ranges, and formats, constraints help ensure the accuracy of the data.
#Reliability: A database with well-defined constraints is more reliable because you can trust the data it contains.
#Simplified Application Development: Constraints offload data validation from the application code to the database itself. This simplifies application development and ensures that data integrity is enforced regardless of how the data is accessed or modified.

#Common Types of Constraints:

#NOT NULL: Ensures that a column cannot contain NULL values. This forces a value to be provided for the column. Example: emp_name TEXT NOT NULL (as in the previous example).
#UNIQUE: Ensures that all values in a column (or a combination of columns) are unique. This prevents duplicate values. Example: email TEXT UNIQUE.
#PRIMARY KEY: Uniquely identifies each row in a table. It's a combination of NOT NULL and UNIQUE. A table can have only one primary key. Example: emp_id INT PRIMARY KEY.
#FOREIGN KEY: Establishes a link between two tables. It ensures that the values in a column of one table (the foreign key) must match the values in a column (usually the primary key) of another table. This maintains referential integrity. Example: If you had a departments table with a dept_id and an employees table, you could have a foreign key in employees referencing the dept_id in departments.
#CHECK: Allows you to specify a boolean expression that must be true for all rows in the table. This allows for more complex validation rules. Example: age INT CHECK (age >= 18).
#DEFAULT: Specifies a default value for a column. If no value is provided during insertion, the default value is used. Example: salary DECIMAL DEFAULT 30000.

# 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

#Mandatory Information: Some data fields are simply required for the record to be meaningful. For example, in an employees table, the emp_name is likely a mandatory field. You wouldn't want to have employee records without a name.
#Data Integrity: NOT NULL constraints help maintain data integrity by preventing incomplete or missing data. This is crucial for accurate reporting, analysis, and overall data reliability.
#Business Rules: Often, business rules dictate that certain fields must have values. For instance, in an e-commerce platform, the order_date for an order might be mandatory.
#Preventing Errors: By ensuring that critical columns always have values, you can prevent potential errors in applications that rely on that data.

#Can a primary key contain NULL values?

#No, a primary key cannot contain NULL values. Here's why:

#Uniqueness: A primary key must uniquely identify each row in a table. If a primary key could be NULL, it would violate this uniqueness requirement because multiple rows could have a NULL primary key.
#Identification: The primary key is used to reference specific rows in the table. If it were NULL, it would be impossible to reliably identify a particular row.
#Implicit NOT NULL: By definition, a primary key constraint implicitly includes a NOT NULL constraint. This means that when you define a column as a primary key, the database automatically enforces that it cannot contain NULL values.

# 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.

# You can add or remove constraints on an existing table using the ALTER TABLE command

#Adding a Constraint:

#ALTER TABLE (table_name)
#ADD CONSTRAINT (constraint_name constraint_definition);

#Example: Adding a CHECK constraint

#Let's say you have an employees table, and you want to add a check constraint to ensure that the salary is always positive:

#ALTER TABLE employees
#ADD CONSTRAINT chk_salary_positive CHECK (salary > 0);

# 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint

#Attempting to insert, update, or delete data in a way that violates a constraint will result in an error. The database management system (DBMS) will reject the operation and prevent the data modification from happening.  This is a crucial mechanism for maintaining data integrity.

#Here's a breakdown of the consequences and an example error message:

#Consequences of Violating Constraints:

#Data Rejection: The most immediate consequence is that the data modification (insert, update, or delete) will fail. The database will not apply the changes.

#Error Message: The DBMS will issue an error message explaining why the operation failed. This message will typically specify the violated constraint and the data that caused the violation.

#Transaction Rollback (if applicable): If the data modification is part of a larger transaction, the entire transaction might be rolled back. This means that all changes made within the transaction, including the attempted violation, will be undone to maintain consistency.

#Application Error: The application that's interacting with the database will receive the error.  The application developer needs to handle these errors gracefully, typically by displaying an informative message to the user or taking other corrective actions.

#No Data Corruption:  The positive consequence is that the database remains consistent.  The constraint violation prevents bad data from entering the database, so the existing data is not corrupted.

# 6. You created a products table without constraints as follows:
CREATE TABLE products (
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));
#Now, you realise that?
#: The product_id should be a primary keyQ
#: The price should have a default value of 50.00

CREATE TABLE products (
product_id INT primary key,
product_name VARCHAR(50),
price DECIMAL(10, 2) default 50.00);


#7. You have two tables:
#Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

select student_id, student_name, class_name from 
students inner join classes on 
students.class_id = classes.class_id;

#8. Consider the following three tables:
#Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
#listed even if they are not associated with an order 
#Hint: (use INNER JOIN and LEFT JOIN)5

SELECT
p.product_name,
o.order_id,
c.customer_name FROM Products p
LEFT JOIN
Orders o ON p.product_id = o.order_id
LEFT JOIN
Customers c ON o.customer_id = c.customer_id
ORDER BY p.product_name;

#9 Given the following tables:
#Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

select product_name, sum(amount) as total_sales
from product inner join sales on 
product.product_id =sales.product_id
group by product_name;

#10. You are given three tables:
#Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.

SELECT
    o.order_id,
    c.customer_name,
    SUM(od.quantity) AS total_quantity_ordered
FROM
    Orders o
INNER JOIN
    Customers c ON o.customer_id = c.customer_id
INNER JOIN
    Order_Details od ON o.order_id = od.order_id
GROUP BY
    o.order_id, c.customer_name
ORDER BY
    o.order_id;
    
    
    
    #SQL Commands

#1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences


Primary Keys:

Primary keys uniquely identify each row in a table.  They cannot be null and are often auto-incrementing integers.   

actor: actor_id
actor_award: actor_award_id
address: address_id
advisor: advisor_id
category: category_id
city: city_id
country: country_id
customer: customer_id
film: film_id
film_text: film_id
inventory: inventory_id
investor: investor_id
language: language_id
payment: payment_id
rental: rental_id
staff: staff_id
store: store_id
Foreign Keys:

Foreign keys establish relationships between tables. They reference the primary key of another table.   

actor_award: actor_id (references actor)
address: city_id (references city)
city: country_id (references country)
customer:
store_id (references store)
address_id (references address)
film:
language_id (references language)
original_language_id (references language)
film_actor:
actor_id (references actor)
film_id (references film)
film_category:
film_id (references film)
category_id (references category)
inventory:
film_id (references film)
store_id (references store)
payment:
customer_id (references customer)
staff_id (references staff)
rental_id (references rental)
rental:
inventory_id (references inventory)
customer_id (references customer)
staff_id (references staff)
staff:
address_id (references address)
store_id (references store)
store:
manager_staff_id (references staff)
address_id (references address)


Differences Between Primary and Foreign Keys:

Feature	          Primary Key	                             Foreign Key

Purpose        	Uniquely identifies a record.	       Establishes a link between records in tables.
Uniqueness   	Must be unique within the table.	   Can have duplicate values.
Nullability 	Cannot be null.	                       Can be null (depending on the relationship).
Number      	One per table (can be composite).	   Multiple per table allowed.
Referenced  	Not referenced by other keys (usually).	References a primary key in another table.
Auto-Increment 	Often, but not always.	                Never auto-incrementing.


2- List all details of actors

SELECT *
FROM actor;

This SQL query will retrieve all columns and rows from the actor table, effectively giving you all the details of every actor in the database.  The * is a wildcard that selects all columns.  If you wanted only specific details, you would list the column names instead of the *.  For example:

SELECT actor_id, first_name, last_name
FROM actor;

3 -List all customer information from DB.

SELECT *
FROM customer;
This query will select all columns (*) from the customer table, giving you a complete list of all customer information stored in the database.

If you want to see the specific columns available in the customer table, you can run the following query

4 -List different countries.

SELECT DISTINCT country
FROM country;
The DISTINCT keyword is crucial here. It ensures that only unique country names are returned. Without it, you would get a list of all countries, but if any country appears multiple times in the database (perhaps associated with different cities), it would be listed multiple times in your results.  DISTINCT filters out these duplicates.


5 -Display all active customers.

SELECT *
FROM customer
WHERE active = 1;  -- Or WHERE active = TRUE;

This query selects all columns (*) from the customer table but filters the results using the WHERE clause.  It only includes customers where the active column is equal to 1 (or TRUE, depending on how "active" is represented in your database).  This effectively shows you all the active customers

6 -List of all rental IDs for customer with ID 1.

SELECT rental_id
FROM rental
WHERE customer_id = 1;
This SQL query selects the rental_id from the rental table where the customer_id is equal to 1.  This will give you a list of all the rental IDs associated with customer number 1.

7 - Display all the films whose rental duration is greater than 5 .

use mavenmovies;
SELECT *  
FROM film
WHERE rental_duration > 5;
This query selects all columns (you can replace * with specific column names if you prefer) from the film table. The WHERE clause filters the results, only including films where the rental_duration is greater than 5

8 - List the total number of films whose replacement cost is greater than $15 and less than $20.

SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

9 - Display the count of unique first names of actors.

SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

10- Display the first 10 records from the customer table .

SELECT *
FROM customer
LIMIT 10;

11 - Display the first 3 records from the customer table whose first name starts with ‘b’.

SELECT *
FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

12 -Display the names of the first 5 movies which are rated as ‘G’.

SELECT title FROM film
WHERE rating = 'G'
LIMIT 5;

13-Find all customers whose first name starts with "a".

SELECT *  -- Or specify the columns you want to see (e.g., customer_id, first_name, last_name)
FROM customer
WHERE first_name LIKE 'a%';

14- Find all customers whose first name ends with "a".

SELECT *  -- Or specify the columns you want to see
FROM customer
WHERE first_name LIKE '%a';

15- Display the list of first 4 cities which start and end with ‘a’ .

SELECT city FROM city
WHERE city LIKE 'a%a'
LIMIT 4;

16- Find all customers whose first name have "NI" in any position.

SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE '%ni%';

17- Find all customers whose first name have "r" in the second position .

SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE '_r%';

18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

19- Find all customers whose first name starts with "a" and ends with "o".

SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE 'a%o';

20 - Get the films with pg and pg-13 rating using IN operator.

SELECT *  -- Or specify the columns you want (e.g., film_id, title, rating)
FROM film
WHERE rating IN ('PG', 'PG-13');

21 - Get the films with length between 50 to 100 using between operator.

SELECT *  -- Or specify the columns you want (e.g., film_id, title, length)
FROM film
WHERE length BETWEEN 50 AND 100;

22 - Get the top 50 actors using limit operator.

SELECT *  -- Or specify the columns you want (e.g., actor_id, first_name, last_name)
FROM actor
LIMIT 50;

23 - Get the distinct film ids from inventory table.

SELECT DISTINCT film_id
FROM inventory;


Functions
Basic Aggregate Functions:


Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.

select count(*) as total_rantal_count from rental;

Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.

SELECT AVG(rental_duration) AS average_rental_duration
FROM film;


String Functions:

Question 3:
Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.

select upper(first name) as Upper_first_name , upper(last name) as Upper_last_name from customer;

Question 4:
Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.

SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;


GROUP BY:


Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;


Question 6:
Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.;

use mavenmovies; 
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN store AS s ON i.store_id = s.store_id
GROUP BY s.store_id;

Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY

SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM film AS f
JOIN language AS l ON f.language_id = l.language_id
GROUP BY l.name;

Joins

Questions 9 -
Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.

SELECT f.title AS movie_title, c.first_name AS customer_first_name, c.last_name AS customer_last_name
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN customer AS c ON r.customer_id = c.customer_id;

Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.

SELECT a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
WHERE f.title = "Gone with the Wind";

Question 11:
Retrieve the customer names along with the total amount they ve spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.;

SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
JOIN rental AS r ON p.rental_id = r.rental_id  -- Connect via rentals for accurate amounts
GROUP BY c.first_name, c.last_name;

Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

SELECT c.first_name, c.last_name, f.title AS movie_title
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS cy ON a.city_id = cy.city_id
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE cy.city = 'London'  -- Replace 'London' with the desired city
ORDER BY c.last_name, c.first_name, f.title; -- Optional: Order the results


Advanced Joins and GROUP BY:

Question 13:
Display the top 5 rented movies along with the number of times they ve been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.;

SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;


Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY

SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)  -- Customers who rented from either store
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2; -- Must have rented from BOTH stores (count of distinct stores = 2)

Windows Function:

1. Rank the customers based on the total amount they ve spent on rentals.

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC; -- Optional: Order by total spent

2. Calculate the cumulative revenue generated by each film over time.

SELECT f.title AS film_title,
       p.payment_date,
       SUM(p.amount) OVER (PARTITION BY f.title ORDER BY p.payment_date) AS cumulative_revenue
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
ORDER BY f.title, p.payment_date;

3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT f.title AS film_title,
       f.length,
       AVG(f.rental_duration) OVER (PARTITION BY f.length) AS avg_rental_duration_by_length
FROM film AS f
ORDER BY f.length, f.title;  -- Optional: Order for better readability

4. Identify the top 3 films in each category based on their rental counts.

WITH FilmRentalCounts AS (
    SELECT f.title AS film_title,
           c.name AS category_name,
           COUNT(r.rental_id) AS rental_count
    FROM film AS f
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON fc.category_id = c.category_id
    JOIN inventory AS i ON f.film_id = i.film_id
    JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY f.title, c.name
),
RankedFilms AS (
    SELECT film_title,
           category_name,
           rental_count,
           ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY rental_count DESC) AS film_rank
    FROM FilmRentalCounts
)
SELECT film_title, category_name, rental_count
FROM RankedFilms
WHERE film_rank <= 3
ORDER BY category_name, film_rank;


5. Calculate the difference in rental counts between each customers total rentals and the average rentals across all customers.

WITH CustomerRentalCounts AS (
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           COUNT(r.rental_id) AS customer_rental_count
    FROM customer AS c
    JOIN rental AS r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
AverageRentalCount AS (
    SELECT AVG(customer_rental_count) AS avg_rental_count
    FROM CustomerRentalCounts
)
SELECT crc.customer_id,
       crc.first_name,
       crc.last_name,
       crc.customer_rental_count,
       arc.avg_rental_count,
       crc.customer_rental_count - arc.avg_rental_count AS rental_count_difference
FROM CustomerRentalCounts AS crc
CROSS JOIN AverageRentalCount AS arc  -- Use CROSS JOIN to combine with the average
ORDER BY rental_count_difference DESC; -- Optional: Order by difference

6. Find the monthly revenue trend for the entire rental store over time.

SELECT
    DATE_TRUNC('month', p.payment_date) AS rental_month,  -- Extract month and year
    SUM(p.amount) AS monthly_revenue
FROM
    payment AS p
GROUP BY
    rental_month
ORDER BY
    rental_month;
    
7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH CustomerSpending AS (
    SELECT c.customer_id,
           c.first_name,
           c.last_name,
           SUM(p.amount) AS total_spending
    FROM customer AS c
    JOIN payment AS p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
SpendingPercentile AS (
  SELECT
        PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY total_spending) as top_80_percent_spending
    FROM CustomerSpending
)
SELECT cs.customer_id, cs.first_name, cs.last_name, cs.total_spending
FROM CustomerSpending AS cs
CROSS JOIN SpendingPercentile sp
WHERE cs.total_spending >= sp.top_80_percent_spending  -- Customers in the top 20%
ORDER BY cs.total_spending DESC; -- Optional: Order by total spending

8. Calculate the running total of rentals per category, ordered by rental count.;

WITH CategoryRentalCounts AS (
    SELECT c.name AS category_name,
           COUNT(r.rental_id) AS rental_count
    FROM category AS c
    JOIN film_category AS fc ON c.category_id = fc.category_id
    JOIN film AS f ON fc.film_id = f.film_id
    JOIN inventory AS i ON f.film_id = i.film_id
    JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY c.name
),
RankedCategoryRentals AS (
    SELECT category_name,
           rental_count,
           ROW_NUMBER() OVER (ORDER BY rental_count DESC) AS category_rank
    FROM CategoryRentalCounts
)
SELECT category_name,
       rental_count,
       SUM(rental_count) OVER (ORDER BY category_rank) AS running_total
FROM RankedCategoryRentals
ORDER BY category_rank;


9. Find the films that have been rented less than the average rental count for their respective categories.

WITH FilmCategoryRentals AS (
    SELECT f.title AS film_title,
           c.name AS category_name,
           COUNT(r.rental_id) AS rental_count
    FROM film AS f
    JOIN film_category AS fc ON f.film_id = fc.film_id
    JOIN category AS c ON fc.category_id = c.category_id
    JOIN inventory AS i ON f.film_id = i.film_id
    JOIN rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY f.title, c.name
),
AverageCategoryRentals AS (
    SELECT category_name, AVG(rental_count) AS avg_rental_count
    FROM FilmCategoryRentals
    GROUP BY category_name
)
SELECT fcr.film_title, fcr.category_name, fcr.rental_count
FROM FilmCategoryRentals AS fcr
JOIN AverageCategoryRentals AS acr ON fcr.category_name = acr.category_name
WHERE fcr.rental_count < acr.avg_rental_count
ORDER BY fcr.category_name, fcr.film_title;


10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

WITH MonthlyRevenue AS (
    SELECT
        DATE_TRUNC('month', p.payment_date) AS sales_month,  -- Or equivalent for your DB
        SUM(p.amount) AS monthly_revenue
    FROM
        payment AS p
    GROUP BY
        sales_month
),
RankedMonthlyRevenue AS (
    SELECT
        sales_month,
        monthly_revenue,
        DENSE_RANK() OVER (ORDER BY monthly_revenue DESC) AS revenue_rank
    FROM
        MonthlyRevenue
)
SELECT
    sales_month,
    monthly_revenue
FROM
    RankedMonthlyRevenue
WHERE revenue_rank <= 5
ORDER BY sales_month DESC; -- Optional: Order by month

Normalisation & CTE

1. First Normal Form (1NF):
a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

A common violation of 1NF in the Sakila database (and many similar databases) can be found in the `film` table, specifically the `special_features` column.

**Violation:**

The `special_features` column is defined as a `SET` data type.  This means it can store multiple values within a single cell, separated by commas (e.g., "Trailers,Commentaries,Deleted Scenes").  This violates 1NF because 1NF requires that each attribute (column) of a relation (table) contain only atomic values.  A `SET` or multi-valued attribute is not atomic.

**Normalization to 1NF:**

To normalize the `film` table and achieve 1NF, you would create a new table to store the special features separately.  Here's how you might do it:

1.  **Create a new table:**

```sql
CREATE TABLE film_special_feature (
    film_id SMALLINT UNSIGNED NOT NULL,
    special_feature VARCHAR(50) NOT NULL,  -- Or ENUM if you have a fixed list
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE,
    PRIMARY KEY (film_id, special_feature)  -- Composite key
);
```

2.  **Populate the new table:**  You would need to write a script (or use a series of `INSERT` statements) to extract the individual special features from the `film.special_features` column and insert them as separate rows into the new `film_special_feature` table.  Here's a conceptual example of how you might do this (the exact syntax will depend on your database):

```sql
-- Example (conceptual - adapt to your DB syntax)
INSERT INTO film_special_feature (film_id, special_feature)
SELECT film_id,
       -- Function to split the special_features string and extract individual values
       extracted_feature  -- Placeholder for the extraction function
FROM film;
```

3.  **Remove the `special_features` column from the `film` table:**

```sql
ALTER TABLE film
DROP COLUMN special_features;
```

**Result:**

After normalization, the `film` table would no longer have the multi-valued `special_features` column.  Instead, you would have the `film_special_feature` table, where each row represents a single special feature for a specific film.  This makes the data atomic and satisfies 1NF.

**Benefits of 1NF:**

*   **Simpler queries:** It becomes easier to query for films with specific special features.  You can use simple `JOIN` operations instead of string manipulation functions.
*   **Data integrity:** It avoids redundancy and makes it easier to maintain data consistency.  You don't have to worry about inconsistencies in how special features are stored.
*   **Flexibility:** It's easier to add or remove special features without modifying the table structure.

This is a standard normalization process, and it significantly improves the design and usability of the database.



2. Second Normal Form (2NF):
a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

Let's consider the `film_actor` table in the Sakila database.

**Determining 2NF compliance:**

The `film_actor` table has a composite primary key consisting of `film_id` and `actor_id`.  To determine if it's in 2NF, we need to check if any non-prime attributes (attributes that are not part of the primary key) are dependent on *only part* of the composite key.

In this case, `film_actor` only has the `last_update` column as a non-prime attribute.  `last_update` represents the time when the record was last updated.  It depends on the *combination* of `film_id` and `actor_id` (the whole primary key), not just on `film_id` or `actor_id` individually.  A film might have a different `last_update` time with one actor than with another.

**Is it in 2NF?**

Because `last_update` depends on the entire primary key, and there are no other non-prime attributes, the `film_actor` table is already in 2NF.  There are no partial dependencies to remove.

**Example of a table that *would* violate 2NF (hypothetical):**

Imagine if the `film_actor` table also had a column called `actor_birthdate`.  This would be a problem.  `actor_birthdate` depends *only* on the `actor_id` part of the key, not on the `film_id`.  This is a partial dependency, violating 2NF.

**Normalization if 2NF was violated (hypothetical):**

If we had the `actor_birthdate` column in `film_actor`, we would normalize it like this:

1.  **Create a new table:**

```sql
CREATE TABLE actor_details (
    actor_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    birthdate DATE,
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);
```

2.  **Move the dependent attribute:** Move the `actor_birthdate` column from the `film_actor` table to the new `actor_details` table.

3.  **Populate the new table:** Insert the `actor_id` and `actor_birthdate` into the `actor_details` table.

4.  **Remove the partial dependency:** Remove the `actor_birthdate` column from the `film_actor` table.

**Result:**

After normalization, the `film_actor` table would only contain attributes that depend on the full composite key (`film_id` and `actor_id`).  The `actor_details` table would store information that depends only on the `actor_id`.  This eliminates the partial dependency and achieves 2NF.

**Key takeaway:**  2NF is primarily concerned with tables that have composite primary keys.  It ensures that non-prime attributes are fully dependent on the entire primary key, not just part of it.  The `film_actor` table, as it is designed in Sakila, is already in 2NF.





3. Third Normal Form (3NF):
a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.


A good example of a 3NF violation in the Sakila database is the `customer` table.

**Violation and Transitive Dependency:**

The `customer` table has the following relevant columns:

*   `customer_id` (Primary Key)
*   `address_id` (Foreign Key referencing the `address` table)
*   `city_id` (Foreign Key referencing the `city` table)
*   `city_name` (Name of the city)

The transitive dependency is as follows:

`customer_id` -> `address_id` -> `city_id` -> `city_name`

The `customer`'s address determines their city, and the city ID determines the city name.  However, the `customer` table directly stores the `city_name`, which is transitively dependent on the `customer_id` via `address_id` and `city_id`.

**Normalization to 3NF:**

To normalize the `customer` table to 3NF, we need to remove the transitive dependency by creating a new table for city details.

1.  **Create a new table:**

```sql
CREATE TABLE city_details (
    city_id SMALLINT UNSIGNED NOT NULL PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL
);
```

2.  **Move the transitively dependent attribute:** Move the `city_name` column from the `customer` table to the new `city_details` table.

3.  **Populate the new table:** Insert the `city_id` and `city_name` into the `city_details` table.  You would likely do this by selecting the distinct `city_id` and `city_name` combinations from the `customer` table before the next step.

4.  **Remove the transitive dependency:** Remove the `city_name` column from the `customer` table.

**Result:**

After normalization, the `customer` table no longer stores the `city_name`.  Instead, it only stores the `city_id` (which is a foreign key).  To get the `city_name`, you would now join the `customer` table with the `city_details` table using the `city_id`.

**Benefits of 3NF:**

*   **Reduced redundancy:** The city name is now stored only once in the `city_details` table, avoiding redundancy and potential inconsistencies if the same city name was stored multiple times in the `customer` table.
*   **Improved data integrity:** Changes to city names only need to be made in one place (the `city_details` table), ensuring consistency.
*   **Simplified updates:** Updating a city name is much simpler and more efficient.

**In summary:** 3NF eliminates transitive dependencies.  If an attribute depends on another non-key attribute, it should be moved to its own table.  This improves data integrity and reduces redundancy.




4. Normalization Process:
a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.

Let's take the `film` table in Sakila and walk through a simplified normalization process up to 2NF.  While the Sakila `film` table is *mostly* normalized, we'll introduce some hypothetical unnormalized elements for demonstration.

**1. Unnormalized Form (Hypothetical):**

Imagine the `film` table also stored genre information directly within the table, like this (this is a simplified example, and it is not how the Sakila database is actually structured):

| film_id | title             | length | rental_rate | genre(s)             |
| ------- | ----------------- | ------ | ----------- | -------------------- |
| 1       | Academy Dinosaur  | 80     | 4.99        | Action,Comedy        |
| 2       | Ace Gold          | 110    | 2.99        | Action,Drama         |
| 3       | Adaptation Holes  | 150    | 0.99        | Comedy,Sci-Fi        |
| 4       | Affair Prejudice  | 100    | 4.99        | Drama               |
| ...     | ...               | ...    | ...         | ...                  |

**Problems with Unnormalized Form:**

*   **1NF Violation:** The `genre(s)` column contains multiple values (comma-separated), violating 1NF.
*   **Redundancy:** Genre names are repeated for each film.
*   **Update Anomalies:** If a genre name changes, you have to update it in multiple rows.
*   **Insertion Anomalies:** Adding a new genre would require updating many rows, or potentially creating a placeholder film.
*   **Deletion Anomalies:** Deleting a film might accidentally delete a genre if it was the only film with that genre.

**2. First Normal Form (1NF):**

To achieve 1NF, we need to eliminate the multi-valued attribute.  We create a new table to store the film-genre relationships:

**film Table:**

| film_id | title             | length | rental_rate |
| ------- | ----------------- | ------ | ----------- |
| 1       | Academy Dinosaur  | 80     | 4.99        |
| 2       | Ace Gold          | 110    | 2.99        |
| 3       | Adaptation Holes  | 150    | 0.99        |
| 4       | Affair Prejudice  | 100    | 4.99        |
| ...     | ...               | ...    | ...         |

**film_genre Table:**

| film_id | genre_name |
| ------- | ---------- |
| 1       | Action     |
| 1       | Comedy     |
| 2       | Action     |
| 2       | Drama      |
| 3       | Comedy     |
| 3       | Sci-Fi     |
| 4       | Drama      |
| ...     | ...        |

**3. Second Normal Form (2NF):**

In this simplified example, the `film` table is already in 2NF because it has a single-attribute primary key (`film_id`). The `film_genre` table also satisfies 2NF because its composite primary key (`film_id`, `genre_name`) has non-key attributes that are dependent on the full key.  There are no partial dependencies.

**Important Note:** The actual Sakila database uses a `film_category` table which is structured similarly to our `film_genre` table example.  However, it uses `category_id` (a foreign key referencing the `category` table) instead of `genre_name` directly.  This is a better design because it avoids storing the genre name multiple times (it's stored only once in the `category` table), and it allows for easier management of genres (e.g., changing a genre name).  This is an example of good database design principles and is already in 2NF and 3NF.  Our simplified example was just to illustrate the normalization steps.




5. CTE Basics:
a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.

WITH ActorFilmCounts AS (
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor AS a
    JOIN
        film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
SELECT 
    first_name,
    last_name,
    film_count
FROM ActorFilmCounts
ORDER BY film_count DESC;

6. CTE with Joins:
a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate

WITH FilmLanguageInfo AS (
    SELECT
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id
)
SELECT
    film_title,
    language_name,
    rental_rate
FROM FilmLanguageInfo;

7. CTE for Aggregation:
a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.

WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer AS c
    JOIN
        payment AS p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_revenue
FROM CustomerRevenue
ORDER BY total_revenue DESC;  -- Optional: Order by revenue for better readability

8.CTE with Window Functions:
 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table
 
 
 WITH FilmRentalRank AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM
        film
)
SELECT
    film_id,
    title,
    rental_duration,
    rental_rank
FROM FilmRentalRank;


9. CTE and Filtering:
a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.

WITH HighRentalCustomers AS (
    SELECT
        customer_id
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(*) > 2
)
SELECT
    c.*  -- Select all columns from the customer table
FROM
    customer AS c
JOIN
    HighRentalCustomers AS hrc ON c.customer_id = hrc.customer_id;
    
10. CTE for Date Calculations:
a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table

WITH MonthlyRentalCounts AS (
    SELECT
        YEAR(rental_date) AS rental_year,
        MONTH(rental_date) AS rental_month,
        COUNT(*) AS rental_count
    FROM
        rental
    GROUP BY
        rental_year,
        rental_month
)
SELECT
    rental_year,
    rental_month,
    rental_count
FROM MonthlyRentalCounts
ORDER BY
    rental_year,
    rental_month;


11. CTE and Self-Join:
a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.

WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        a1.first_name AS actor1_first_name,
        a1.last_name AS actor1_last_name,
        fa2.actor_id AS actor2_id,
        a2.first_name AS actor2_first_name,
        a2.last_name AS actor2_last_name,
        f.title AS film_title
    FROM
        film_actor AS fa1
    JOIN
        film_actor AS fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id  -- Crucial self-join condition
    JOIN
        film AS f ON fa1.film_id = f.film_id
    JOIN
        actor AS a1 ON fa1.actor_id = a1.actor_id
    JOIN
        actor AS a2 ON fa2.actor_id = a2.actor_id
)
SELECT
    actor1_first_name,
    actor1_last_name,
    actor2_first_name,
    actor2_last_name,
    film_title
FROM
    ActorPairs
ORDER BY
    film_title;


12. CTE for Recursive Search:
a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT
        staff_id,
        first_name,
        last_name,
        reports_to,
        1 AS level  -- Initial level (for the manager themselves)
    FROM
        staff
    WHERE
        reports_to = 1  -- Replace 1 with the staff_id of the manager you want to search under

    UNION ALL

    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to,
        eh.level + 1  -- Increment the level for subordinates
    FROM
        staff AS s
    JOIN
        EmployeeHierarchy AS eh ON s.reports_to = eh.staff_id  -- Recursive join
)
SELECT
    staff_id,
    first_name,
    last_name,
    level
FROM
    EmployeeHierarchy
ORDER BY
    level;