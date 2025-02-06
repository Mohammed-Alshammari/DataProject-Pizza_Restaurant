--KPIs:

-- Total Revenue: the sum of The total price of all pizza orders
select SUM(total_price) as Total_revenue from Pizza_Restaurant_Sales;

-- Average Order Value: The avarage ampunt spent per order, calculated by dividing the total the total revenue by the total number of orders.
select (SUM(total_price)/count(distinct order_id)) as Average_Order_Value from Pizza_Restaurant_Sales;

-- Total Pizza Sold: The sum of the quantities of all pizzas sold.
select SUM(quantity) as Total_Pizza_Sold from Pizza_Restaurant_Sales

-- Total Orders: The total number of orders placed
select COUNT(distinct order_id) as Total_Orders from Pizza_Restaurant_Sales

-- Average Pizza Per Order: The average number of pizzas sold per order, calculated by 
select (CAST(cast(SUM(quantity) AS decimal(10,2))/cast(COUNT(distinct order_id) AS decimal(10,2)) AS decimal(10,2))) AS Average_Pizza_Per_Order from Pizza_Restaurant_Sales



