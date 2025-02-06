# 📊 Analysis of Sales for a Pizza Resturant

## 🏆 Project Summary
This project aims to analyze sales data to extract key insights and trends. The goal is to leverage SQL Server Management Studio (SSMS) and Microsoft Excel to process, clean, analyze, and visualize the data. The analysis focuses on identifying top sellers, peak sales periods, and sales trends to provide valuable business insights.


## 📂 Data Source
- **Dataset:** Transactional sales records from a pizza restaurant. Obtained from Kaggle: [Dataset](https://www.kaggle.com/datasets/nextmillionaire/pizza-sales-dataset)
  

## 🛠️ Tools & Technologies Used
- **SQL Server Management Studio (SSMS)** for creating Databse, data extraction, transformation, and analysis.
- **Microsoft Excel** for data visualization and dashboard creation.


---

# 🔍 Data Analysis Breakdown
## 🗄 SQL Analysis
### 📌 Data Preparation

- Created a database on SQL Server and imported the data from the CSV file obtained from Kaggle. ![image](https://github.com/user-attachments/assets/2d702d9d-bdb2-41c3-8b0d-eaf809b172a2)
![image](https://github.com/user-attachments/assets/518a34e5-c51e-4d5d-bf40-46a0919250bf)



### 📊 SQL Queries
#### 🔹 Key Performance Indicators (KPIs)
```sql
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
```
![image](https://github.com/user-attachments/assets/59c14ec8-89c0-4e22-834a-660ac05e32c1)


#### 🔹 Sales Trends
```sql
--Daily Trend for Total Orders:
select DATEPART(weekday,order_date) as Order_Day_id,DATENAME(dw,order_date) as Order_Day, COUNT(distinct order_id) as Total_Orders
from Pizza_Restaurant_Sales
group by DATEPART(weekday,order_date),DATENAME(dw,order_date)
order by DATEPART(weekday,order_date)
```
![image](https://github.com/user-attachments/assets/d6a4eb3e-b750-422c-9f76-7aba20111913)

```sql
-- Hourly Trend for Total Orders:
select DATEPART(HOUR,order_time) as Order_Hour,COUNT(distinct order_id) as Total_Orders
from Pizza_Restaurant_Sales
group by  DATEPART(HOUR,order_time)
order by  DATEPART(HOUR,order_time)

```
![image](https://github.com/user-attachments/assets/17d412f7-4077-400e-a8ff-d9a1af695749)

#### 🔹 Percentages of Sales 

```sql
-- Total pizzas sold by pizza Category:
select pizza_category,SUM(quantity) as Total_pizzas_sold
from Pizza_Restaurant_Sales
group by pizza_category
order by Total_pizzas_sold desc

```
![image](https://github.com/user-attachments/assets/1df1f624-14e8-47b6-8020-6aeb3578fb03)

```sql
-- Percentage of Sales By Pizza Category:
select pizza_category, 
round(SUM(total_price),2) as Total_sales,
round((sum(total_price)*100/(select sum(total_price) from Pizza_Restaurant_Sales --where MONTH(order_date)=1
)),2) as PCT
from Pizza_Restaurant_Sales
group by pizza_category
ORDER BY PCT DESC
```
![image](https://github.com/user-attachments/assets/8060d83e-e140-4cf3-8180-63f2c186dad0)

```sql
-- Percentage of Sales By Pizza Size:
select pizza_size, 
round(SUM(total_price),2) as Total_sales,
round((sum(total_price)*100/(select sum(total_price) from Pizza_Restaurant_Sales)),2) as PCT
from Pizza_Restaurant_Sales
group by pizza_size
ORDER BY PCT DESC

```
![image](https://github.com/user-attachments/assets/25ad7571-d34b-4d2b-8c27-cde16853c9e6)


#### 🔹 Best & Worst Sellers
```sql
-- Top 5 Best-Selling Pizzas
select TOP 5 pizza_name, SUM(quantity) as Total_pizzas_sold
from Pizza_Restaurant_Sales
group by pizza_name
order by Total_pizzas_sold desc
```
![image](https://github.com/user-attachments/assets/ac07ecce-9cee-45f9-864b-26bec3d741d7)

```sql
-- Bottom 5 Worst-Selling Pizzas
select TOP 5 pizza_name, SUM(quantity) as Total_pizzas_sold
from Pizza_Restaurant_Sales
group by pizza_name
order by Total_pizzas_sold asc
```
![image](https://github.com/user-attachments/assets/c5864c56-bce1-44ad-8de5-2d7985ede3e3)

---

## 📊 Excel Analysis
### 🔹 Getting & Prepairing Data
- **Established a connection** to the database from the sql server and imported the data.
- **standardized the data ** for analyzing it.

### 🔹 Analyizng The Data
- ** Pivot tables** were used to analyize the data.
-  **checked the results** obtained prevously from sql.

  #### 🔹 Key Performance Indicators (KPIs)
![image](https://github.com/user-attachments/assets/2ba258c8-83ba-4456-9c83-34d054753bfb)

#### 🔹 Sales Trends
### 🔹 Key Insights from Excel
- **Revenue Concentration:** Top-selling pizzas contribute to a majority of sales.
- **Order Distribution:** Evening hours and weekends drive the highest sales.
- **Category Performance:** Chicken-based pizzas are the most popular.

---

## 📢 Recommendations
1. **Increase promotions on peak sales days (Sunday).**
2. **Expand menu variations of top-selling pizzas.**
3. **Optimize pricing strategy to improve average order value.**

## ⚠️ Limitations
- The dataset does not account for external factors like **seasonal trends** or **marketing campaigns**.
- It assumes all recorded sales transactions are accurate.

## 📚 References
- Data obtained from a YouTube tutorial: [Project Link](https://www.youtube.com/watch?v=3Acmk-rqn6c&list=PLDkpn29pvEyW5S-DjxJ2IMrksB_MobFYA)

