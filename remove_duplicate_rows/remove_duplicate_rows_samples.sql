DROP TABLE IF EXISTS sales.contacts;

CREATE TABLE sales.contacts(
    contact_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL,
);

INSERT INTO sales.contacts
    (first_name,last_name,email) 
VALUES
    ('Syed','Abbas','syed.abbas@example.com'),
    ('Catherine','Abel','catherine.abel@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Pilar','Ackerman','pilar.ackerman@example.com');

--SELECT 
--	contact_id, 
--	first_name, 
--	last_name, 
--	email
--FROM 
--   sales.contacts;

with cte as
(
	select 
		first_name
		, last_name
		, email
		, ROW_NUMBER() OVER(PARTITION BY first_name, last_name, email order by first_name, last_name, email) row_num
	from sales.contacts
)
--select * from cte
delete from cte where row_num > 1

SELECT contact_id, 
       first_name, 
       last_name, 
       email
FROM sales.contacts
ORDER BY first_name, 
         last_name, 
         email;