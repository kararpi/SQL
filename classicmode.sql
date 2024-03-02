use classicmodels;
select * from productlines;
select * from products;
select * from customers;
select * from orders;
select * from payments;
select * from offices;
select * from orderdetails;
select * from employees;
select top 1 firstname,
len(firstName) from employees
order by firstName;

select distinct firstname from employees
where firstName
like '[aeiou]%';

select  firstname,
len(firstName) from employees
order by len(firstName)desc, firstName asc;
select count(*) as total_productlines from productlines; 
select count(*) as total_products from products; 
select count(*) as total_customers from customers; 
select count(*) as total_orders from orders; 
select count(*) as total_employees from employees; 
select count(*) as total_payments from payments; 
select count(*) as total_offices from offices;
select count(*) as total_orderdetails from orderdetails;


select 'productlines' as 'table'
,count(*) as total_productlines from productlines
union
select 'products' as 'tables',count(*) as total_products from products
union
select 'customers' as 'table',count(*) as total_customers from customers
union
select 'orders' as 'table',count(*) as total_orders from orders
union
select 'employees' as 'table', count(*) as total_employees from employees
union
select 'payments' as 'table',count(*) as total_payments from payments
union
select 'offices' as 'table',count(*) as total_offices from offices
union
select 'orderdetails' as 'table',count(*) as total_orderdetails from orderdetails;

/*3. What is the total number of orders placed by each customer*/
select c.customernumber,c.customerName,count(
o.ordernumber) as totalorder
from customers c
left join orders o on
c.customernumber = o.customernumber
group by c.customernumber, c.customername
order by totalorder desc
;


SELECT
    c.customerNumber,
    c.customerName,
    COUNT(o.orderNumber) AS totalOrders
FROM
    customers c
LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
GROUP BY
    c.customerNumber, c.customerName
ORDER BY
    totalOrders DESC;

	/*4. What is the total amount spent by each customer? 
*/

select * from customers;
select * from payments;

select c.customernumber, sum(p.amount) as totalamount
from customers c
left join payments p on c.customerNumber = p.customerNumber
group by c.customerNumber
order by totalamount desc
;


select c.customerNumber, sum(p.amount) as TotalAmount

from customers c

join payments p on c.customerNumber = p.customerNumber
group by c.customerNumber
order by totalAmount desc;

/*5. List the top 5 highest spending customers. 
*/

select top 5
c.customerNumber, sum(p.amount) as TotalAmount

from customers c

join payments p on c.customerNumber = p.customerNumber
group by c.customerNumber
order by totalAmount desc;
/*6. How many customers each sales employee deals with? 
*/
select * from employees;
select * from customers;
select e.employeenumber, count(customernumber) as totalcustomer
from employees e
left
join customers c on c.salesRepEmployeeNumber = e.employeeNumber
group by employeeNumber
order by totalcustomer desc;

/*7. List the top 5 employees with the highest total sales volumes. 
*/
select top 5
e.employeenumber, count(customernumber) as totalcustomer 
from employees e

join customers c on c.salesRepEmployeeNumber = e.employeeNumber
group by employeeNumber
order by totalcustomer desc;

/*Which month has the most orders in every year? */

select * from orders;
select * from orderdetails;

SELECT  year(o.orderdate) as years,
MONTH(o.orderDate) as months,
        SUM(quantityOrdered) AS TotalQuantityOrdered
FROM    (
            SELECT  o.orderNumber,
                    o.orderDate,
                    od.quantityOrdered
            FROM    orders o
                    JOIN orderdetails od on  o.orderNumber = od.orderNumber
        ) AS o
GROUP BY    year(o.orderdate),MONTH(o.orderDate) 
ORDER BY  TotalQuantityOrdered DESC;

/*9. Which product is the most ordered one? 
*/

select top 1 p.productCode, sum(quantityordered) as total_quantity
from orderdetails o
join products p on o.productCode=p.productCode
group by p.productCode
order by total_quantity desc
;

/*10. Which office location has the highest sales? */
select * from offices;
select * from employees;
select * from customers;

select o.country
,count(c.customernumber) AS TOTAL_sales
from offices o
join employees e on o.officeCode = e.officeCode
join customers c on e.employeeNumber = c.salesRepEmployeeNumber
group by o.country
order by TOTAL_sales desc
;

select * from customers
where country='USA';

SELECT top 1
o.officeCode, o.city, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders odr ON c.customerNumber = odr.customerNumber
JOIN orderdetails od ON odr.orderNumber = od.orderNumber
GROUP BY o.officeCode, o.city
ORDER BY totalSales DESC
;
select * from productlines;
select * from products;

/*Identify the product lines of the company.*/
select productline from productlines;
select distinct productline from products;
/*Case 2: Identify the most expensive product line.*/


select top 1
productline, max(buyprice) as cost
from products
group by productLine
order by cost desc
;

/*Case 3: Identify the 10 most ordered products.*/
select * from orderdetails;
select * from products;

select top 10
productline, productname,
o.productcode, quantityOrdered
from orderdetails o
join products p on o.productCode = p.productCode
order by quantityOrdered desc
;

/*Identify the 10 least ordered products.*/
select top 10
productline, productname,
o.productcode, quantityOrdered
from orderdetails o
join products p on o.productCode = p.productCode
order by quantityOrdered
;


select top 10 
productName, count(quantityordered) as total_quantity
from orderdetails o
join products p on o.productcode = p.productcode
group by productName
order by total_quantity ;


select top 10 
productName, count(quantityordered) as total_quantity
from orderdetails o
join products p on o.productcode = p.productcode
group by productName
order by total_quantity ;

/*Case 5: Show the order status of products.
*/
select * from orderdetails;
select * from orders;
select * from products;

select productName, o.status
from orders o
join orderdetails ord on o.orderNumber = ord.orderNumber
join products p on ord.productCode = p.productCode
;

select productName, ord.quantityOrdered, ord.priceEach,
o.status
from orders o
join orderdetails ord on o.orderNumber = ord.orderNumber
join products p on ord.productCode = p.productCode
order by quantityOrdered
;
/*
Case 6: Identify 10 products with the highest sales.*/
SELECT top 10
  p.productCode,
  p.productName,
  SUM(s.quantityOrdered * s.priceEach) AS totalSales
FROM
  products p
JOIN
  orderdetails s ON p.productCode = s.productCode
GROUP BY
  p.productCode, p.productName
ORDER BY
  totalSales DESC
;

select * from payments;
select * from orderdetails;
select * from orders;
select * from products;


/*Case 7: Identify 10 products with the least sales.
*/
select top 10
p.productCode, p.productName, sum (ord.priceEach* ord.quantityOrdered)
 as totalsale
from orderdetails ord
join products p on ord.productCode = p.productCode
group by p.productCode, p.productName
order by totalsale asc;

/*Case 8: Identify 10 countries with the highest sales of products.
*/
select * from customers;

select city,country, sum(amount) as totalsale
from customers c
join payments p on p.customerNumber = c.customerName
group by city
order by totalsale;

/*Identify 10 countries with the least sales of products.
*/
select top 10
city,
country, sum(amount) as total
from customers c
join payments p on p.customerNumber = c.customerNumber
group by city, country
order by total;
/*Identify the bottom 10 customers by their total amount of purchased products.*/

 select *
 from  payments;

 select top 10
 customerName, c.customerNumber, sum(amount) as total
 from customers c
 join payments p on c.customerNumber =p.customerNumber
 group by customerName,c.customerNumber
 order by total desc;
 /*
Identify the bottom 10 customers by their total amount of purchased products.*/

 select top 10
 customerName, c.customerNumber, sum(amount) as total
 from customers c
 join payments p on c.customerNumber =p.customerNumber
 group by customerName,c.customerNumber
 order by total ;


