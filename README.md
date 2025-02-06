# 📊 Data Driven Sales Analysis for a Pizza Restaurant Using SQL & Excel

## 🏆 Project Summary
This project aims to analyze sales data to extract key insights and trends. The goal is to leverage SQL Server Management Studio (SSMS) and Microsoft Excel to process, clean, analyze, and visualize the data. The analysis focuses on identifying top sellers, peak sales periods, and sales trends to provide valuable business insights.

---

# 📑 Table of Contents  

1. [🏆 Project Summary](#🏆-project-summary)  
2. [📂 Data Source](#📂-data-source)  
3. [🛠 Tools & Technologies Used](#🛠️-tools--technologies-used)  
4. [🔍 Data Analysis Breakdown](#🔍-data-analysis-breakdown)  
   - [🗄 SQL Analysis](#🗄-sql-analysis)  
     - [📌 Data Preparation](#📌-data-preparation)  
     - [📊 SQL Queries](#📊-sql-queries)  
       - [🔹 Key Performance Indicators (KPIs)](#🔹-key-performance-indicators-kpis)  
       - [🔹 Sales Trends](#🔹-sales-trends)  
       - [🔹 Percentages of Sales](#🔹-percentages-of-sales)  
       - [🔹 Best & Worst Sellers](#🔹-best--worst-sellers)  
   - [📊 Excel Analysis](#📊-excel-analysis)  
     - [🔹 Getting & Preparing Data](#🔹-getting--preparing-data)  
     - [🔹 Analyzing & Visualizing Data](#🔹-analyzing--visualizing-data)  
       - [🔹 Key Performance Indicators (KPIs)](#🔹-key-performance-indicators-kpis-1)  
       - [🔹 Sales Trends](#🔹-sales-trends-1)  
       - [🔹 Percentages of Sales](#🔹-percentages-of-sales-1)  
       - [🔹 Best & Worst Sellers](#🔹-best--worst-sellers-1)  
     - [🔹 Dashboard](#🔹-dashboard)  
5. [📉 Results](#📉-results)  
6. [📢 Recommendations](#📢-recommendations)  

---

## 📂 Data Source
- **Dataset:** Transactional sales records from a pizza restaurant. Obtained from Kaggle: [Dataset](https://www.kaggle.com/datasets/nextmillionaire/pizza-sales-dataset)
  

## 🛠️ Tools & Technologies Used
- **SQL Server Management Studio (SSMS)** for creating databse and data querying.
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


-- Total Revenue: the sum of The total price of all pizza orders
select SUM(total_price) as Total_revenue from Pizza_Restaurant_Sales
```
![image](https://github.com/user-attachments/assets/46f7c7c0-f731-452c-86a8-a248a24411cb)

```sql
-- Average Order Value: The avarage ampunt spent per order, calculated by dividing the total the total revenue by the total number of orders.
select (SUM(total_price)/count(distinct order_id)) as Average_Order_Value from Pizza_Restaurant_Sales
```
![image](https://github.com/user-attachments/assets/795819b8-d54e-4ce1-8967-07cb10179fe1)

```sql
-- Total Pizza Sold: The sum of the quantities of all pizzas sold.
select SUM(quantity) as Total_Pizza_Sold from Pizza_Restaurant_Sales
```
![image](https://github.com/user-attachments/assets/99101e39-d14c-4f2e-921d-f6e389bee891)

```sql
-- Total Orders: The total number of orders placed
select COUNT(distinct order_id) as Total_Orders from Pizza_Restaurant_Sales
```
![image](https://github.com/user-attachments/assets/6116a66d-e8e2-4489-9523-8591b7b1ba5d)

```sql
-- Average Pizza Per Order: The average number of pizzas sold per order, calculated by 
select (CAST(cast(SUM(quantity) AS decimal(10,2))/cast(COUNT(distinct order_id) AS decimal(10,2)) AS decimal(10,2))) AS Average_Pizza_Per_Order from Pizza_Restaurant_Sales
```
![image](https://github.com/user-attachments/assets/1785b8ab-43ff-48bb-963a-ad16e7ac909e)



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
round((sum(total_price)*100/(select sum(total_price) from Pizza_Restaurant_Sales)),2) as PCT
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



## 📊 Excel Analysis
### 🔹 Getting & Prepairing Data
- **Established a connection** to the database from the SQL server and imported the data.
- **standardized the data** for analyzing.

### 🔹 Analyizng & Visualizing Data
- **Pivot tables** were used to analyize the data.
- **Checked the results** obtained prevously from SQL.

  #### 🔹 Key Performance Indicators (KPIs)
![image](https://github.com/user-attachments/assets/2ba258c8-83ba-4456-9c83-34d054753bfb)

 #### 🔹 Sales Trends
![image](https://github.com/user-attachments/assets/c44871b7-bbb9-47b9-8ba1-6500e21d0807)

 #### 🔹 Percentages of Sales 
![image](https://github.com/user-attachments/assets/2f35e4ff-8c31-402c-a1bc-f6747e8f2a60)


 #### 🔹 Best & Worst Sellers
![image](https://github.com/user-attachments/assets/7bb91f45-eedf-45a6-aaa4-e5fc9e1b1ed4)


### 🔹 Dashboard
![image](https://github.com/user-attachments/assets/ba2e4601-c6c2-4bd4-a629-8b3ab0a52a23)

---
## 📉 Resluts
- **Sales peak toward** the latter part of the week, with the highest number of transactions occurring on Fridays.

- **The most active hours** for customer purchases are during midday and evening meal times.

- **The most popular category** of pizza generates the highest sales figures across all order sizes.

- **Larger-sized pizzas** contribute significantly to revenue compared to other size variations.

## 📢 Recommendations
- Increase promotional efforts and staffing levels on peak sales days to enhance customer service and efficiency.

- Optimize inventory and kitchen operations during the busiest meal hours to meet customer demand smoothly.

- Focus marketing campaigns on best-selling pizza categories to further drive revenue growth.

- Consider offering incentives or deals on larger-sized pizzas to capitalize on their strong sales performance.

- Reevaluate the less popular pizza options to determine whether adjustments or menu changes are necessary to improve their appeal.

