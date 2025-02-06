-- Trends:

--Daily Trend for Total Orders:
select DATEPART(weekday,order_date) as Order_Day_id,DATENAME(dw,order_date) as Order_Day, COUNT(distinct order_id) as Total_Orders
from Pizza_Restaurant_Sales
group by DATEPART(weekday,order_date),DATENAME(dw,order_date)
order by DATEPART(weekday,order_date)
--> Orders reach their highest levels towards the end of the week.




-- Hourly Trend for Total Orders:
select DATEPART(HOUR,order_time) as Order_Hour,COUNT(distinct order_id) as Total_Orders
from Pizza_Restaurant_Sales
group by  DATEPART(HOUR,order_time)
order by  DATEPART(HOUR,order_time)
-->The busiest times are between 12:00 PM - 1:00 PM & 5:00 PM - 7:00 PM.




-- Percentage of Sales By Pizza Category:
select pizza_category, 
round(SUM(total_price),2) as Total_sales,
round((sum(total_price)*100/(select sum(total_price) from Pizza_Restaurant_Sales --where MONTH(order_date)=1
)),2) as PCT
from Pizza_Restaurant_Sales
--where MONTH(order_date)=1
group by pizza_category
ORDER BY PCT DESC
--> We can see the the Classic pizza has the highest percentage of sales generaly. also in january its classic(we use a filter with the "where" clause)



-- Percentage of Sales By Pizza Size:
select pizza_size, 
round(SUM(total_price),2) as Total_sales,
round((sum(total_price)*100/(select sum(total_price) from Pizza_Restaurant_Sales)),2) as PCT
from Pizza_Restaurant_Sales
group by pizza_size
ORDER BY PCT DESC
--> We can see the the Large pizza has the highest percentage of sales generaly. also you could filter this by month like above
--or by quarter like " where datepart(quarter,order_date)=1 " (must put it in the subquery as well)


-- Total pizzas sold by pizza Category:
select pizza_category,SUM(quantity) as Total_pizzas_sold
from Pizza_Restaurant_Sales
group by pizza_category
order by Total_pizzas_sold desc
--> highest pizza category sold is classic.


 --Best & Worst Sellers:

--Top 5 Best Sellers by Total Pizza Sold: 
select TOP 5 pizza_name, SUM(quantity) as Total_pizzas_sold
from Pizza_Restaurant_Sales
group by pizza_name
order by Total_pizzas_sold desc



-- Bottom 5 Worst Sellers by Total Pizza Sold:
select TOP 5 pizza_name, SUM(quantity) as Total_pizzas_sold
from Pizza_Restaurant_Sales
--where MONTH(order_date)=1 or datepart(quarter,order_date)=1 /to filter based on month or quarter
group by pizza_name
order by Total_pizzas_sold asc
