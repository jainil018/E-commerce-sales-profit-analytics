CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

USE ecommerce_analytics;

SELECT *
FROM global_ecommerce_sales
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM global_ecommerce_sales;

SELECT count(distinct Order_ID) as unique_orders
FROM global_ecommerce_sales;

/*Q1 Find the total sales.*/
SELECT round(sum(Total_Sales),2) as total_sales
from global_ecommerce_sales;

/*Q2 Find the total profit.*/
SELECT round(sum(Profit),2) as total_profit
from global_ecommerce_sales;

/*Q3 Find the total quantity sold.*/
SELECT round(sum(Quantity),2) as total_quantity
from global_ecommerce_sales;

/*Q4 Find the average order sales.*/
SELECT round(avg(Total_Sales),2) as avg_sales
from global_ecommerce_sales;

/*Q5 Find the maximum order sales.*/
SELECT max(Total_Sales) as max_sales
from global_ecommerce_sales;

/*Q6 Find the minimum profit.*/
SELECT min(Profit) as min_profit
from global_ecommerce_sales;

/*Q7 Find the total sales by region.*/
SELECT Region,round(sum(Total_Sales),2) as Total_sales
from global_ecommerce_sales
group by region;

/*Q8 Find the total profit by product category.*/
SELECT Product_Category,round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Product_Category;

/*Q9 Find the top 10 products by total sales.*/
SELECT Product_Name,round(sum(Total_Sales),2) as Total_Sales
from global_ecommerce_sales
group by Product_Name
order by round(sum(Total_Sales),2) desc
limit 10;

/*Q10 Find the loss-making orders.*/
select Order_ID,Product_Name,Total_Sales,Profit
from global_ecommerce_sales
where profit < 0 ;

/*Q11 — Top 10 Products by Sales*/
SELECT
    Product_Name,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM global_ecommerce_sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

/*QQ12 — Bottom 10 Products by Sales*/
SELECT
    Product_Name,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM global_ecommerce_sales
GROUP BY Product_Name
ORDER BY Total_Sales ASC
LIMIT 10;

/*Q13 — Sales by Country*/
select Country,round(sum(Total_Sales),2) as Total_Sales,round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Country
order by round(sum(Total_Sales),2) desc;

/*Q14 — Profit by Region*/
select Region,round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Region
order by round(sum(Profit),2) desc;

/*Q15 — Average Discount by Category*/
select Product_Category,round(avg(Discount_Percent),2) as Average_Discount
from global_ecommerce_sales
group by Product_Category;

/*Q16 — Loss-Making Orders*/
select Order_ID,Product_Name,Product_Category,Total_Sales,Profit
from global_ecommerce_sales
where Profit < 0;

/*Q17 — Loss-Making Product Count*/
select count(*) as Loss_making_Product
from global_ecommerce_sales
where Profit < 0;

/*Q18 — Payment Method Analysis*/
select Payment_Method,
	   count(Order_ID) as Total_Orders,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Payment_Method
order by round(sum(Total_Sales),2) desc;

/*Q19 — Customer Segment Analysis*/
select Customer_Segment,
	   count(Order_ID) as Total_Orders,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Customer_Segment;

/*Q20 — Profit Margin by Category*/
select Product_Category,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit,
       round((round(sum(Profit),2)/round(sum(Total_Sales),2)) * 100,2) as Profit_Margin
from global_ecommerce_sales
group by Product_Category;

/*Q21 — Classify Orders by Profit*/
select Order_ID,
	   Product_Name,
       Profit,
       case
		     when Profit >= 500 then "High Profit" 
             when Profit <= 499.99 and Profit >= 100 then "Medium Profit" 
             when Profit <= 99.99 and Profit >= 0 then "Low Profit"
             else "Loss"
		end as Profit_Category
from global_ecommerce_sales;

/*Q22 — Count Orders by Profit Category*/
select Profit_Category,
	   count(Profit_Category) as Number_of_Orders
from (
select Order_ID,
	   Product_Name,
       Profit,
       case
		     when Profit >= 500 then "High Profit" 
             when Profit <= 499.99 and Profit >= 100 then "Medium Profit" 
             when Profit <= 99.99 and Profit >= 0 then "Low Profit"
             else "Loss"
		end as Profit_Category
from global_ecommerce_sales ) t
group by Profit_Category
order by count(Profit_Category) desc;

/*Q23 — Categories With High Profit*/
select Product_Category,
	   round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Product_Category
having round(sum(Profit),2) > 30000;

/*Q24 — Countries With Sales Above Average*/
with Country_by_total as (
	select Country,
		   round(sum(Total_Sales),2) as Country_Sales
	from global_ecommerce_sales
	group by Country
)
select Country,
	   Country_Sales as Total_Sales
from Country_by_total
where Country_Sales > (select avg(Country_Sales) from Country_by_total);
				
/*Q25 — Top 5 Customers by Revenue*/
select Customer_Name,
       count(Order_ID) as Total_Orders,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Customer_Name
order by round(sum(Total_Sales),2) desc
limit 5;

/*Q26 — Customer Profitability*/
select Customer_Name,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by Customer_Name
having round(sum(Profit),2) > 1000;

/*Q27 — Product Profit Margin*/
select Product_Name,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit,
       round((round(sum(Profit),2)/round(sum(Total_Sales),2)) * 100 ,2) as Profit_Margin
from global_ecommerce_sales
group by Product_Name
order by round((round(sum(Profit),2)/round(sum(Total_Sales),2)) * 100 ,2) desc;

/*Q28 — High-Sales but Low-Margin Products*/
select Product_Name,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit,
       round((round(sum(Profit),2)/round(sum(Total_Sales),2)) * 100 ,2) as Profit_Margin
from global_ecommerce_sales
group by Product_Name
having round(sum(Total_Sales),2) > 10000 and round((round(sum(Profit),2)/round(sum(Total_Sales),2)) * 100 ,2) < 20;

/*Q29 — Rank Products by Sales*/
select Product_Name,
	   round(sum(Total_Sales),2) as Total_Sales,
       rank() over(order by round(sum(Total_Sales),2) desc) as Sales_Rank
from global_ecommerce_sales
group by Product_Name ;

/*Q30 — Rank Categories by Profit*/
select Product_Category,
	   round(sum(Profit),2) as Total_Profit,
       rank() over(order by round(sum(Profit),2) desc) as Profit_Rank
from global_ecommerce_sales
group by Product_Category ;

/*Q31 — Sales by Year*/
select year(STR_TO_DATE(Order_Date, '%d-%m-%Y')) as order_year,
	   count(Order_ID) as Total_Orders,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
WHERE Order_Date IS NOT NULL AND Order_Date != ''
group by year(STR_TO_DATE(Order_Date, '%d-%m-%Y'))
order by order_year asc;

/*Q32 — Monthly Sales*/
select year(STR_TO_DATE(Order_Date, '%d-%m-%Y')) as order_year,
	   month(STR_TO_DATE(Order_Date, '%d-%m-%Y')) as order_month,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit
from global_ecommerce_sales
group by year(STR_TO_DATE(Order_Date, '%d-%m-%Y')) ,
	     month(STR_TO_DATE(Order_Date, '%d-%m-%Y'))
order by order_year asc, order_month asc;

/*Q33 — Best Month by Sales*/
select year(STR_TO_DATE(Order_Date, '%d-%m-%Y')) as order_year,
	   month(STR_TO_DATE(Order_Date, '%d-%m-%Y')) as order_month,
       round(sum(Total_Sales),2) as Total_Sales
from global_ecommerce_sales
group by year(STR_TO_DATE(Order_Date, '%d-%m-%Y')) ,
	     month(STR_TO_DATE(Order_Date, '%d-%m-%Y'))
order by round(sum(Total_Sales),2) desc
limit 1;

/*Q34 — Monthly Profit Margin*/
select year(str_to_date(Order_Date, '%d-%m-%Y')) as Order_year,
	   month(str_to_date(Order_Date, '%d-%m-%Y')) as Order_Month,
       round(sum(Total_Sales),2) as Total_Sales,
       round(sum(Profit),2) as Total_Profit,
       round((round(sum(Profit),2) / round(sum(Total_Sales),2)) * 100, 2) as Profit_Margin
from global_ecommerce_sales
group by year(str_to_date(Order_Date, '%d-%m-%Y')),
	     month(str_to_date(Order_Date, '%d-%m-%Y'))
order by Profit_Margin asc;

/*Q35 — Month-over-Month Sales Growth*/
with monthly_sales as(
select year(str_to_date(Order_Date, '%d-%m-%Y')) as Order_Year,
	   month(str_to_date(Order_Date, '%d-%m-%Y')) as Order_Month,
       round(sum(Total_Sales),2) as Total_Sales
from global_ecommerce_sales
group by year(str_to_date(Order_Date, '%d-%m-%Y')),
	     month(str_to_date(Order_Date, '%d-%m-%Y'))
)
select Order_Year,
       Order_Month,
       Total_Sales,
       lag(Total_Sales) over(order by Order_Year, Order_Month) as Previous_Month_Sales,
       round(((Total_Sales - lag(Total_Sales) over(order by Order_Year, Order_Month))
       / lag(Total_Sales) over(order by Order_Year, Order_Month)) * 100,2) as Growth_Percentage
from monthly_sales;
         
/*Q36 — Running Total of Sales*/
with cte_Monthly_sales as(
select year(str_to_date(Order_Date, '%d-%m-%Y')) as Order_year,
	   month(str_to_date(Order_Date, '%d-%m-%Y')) as Order_Month,
       round(sum(Total_Sales),2) as Monthly_Sales
from global_ecommerce_sales
group by year(str_to_date(Order_Date, '%d-%m-%Y')),
	     month(str_to_date(Order_Date, '%d-%m-%Y'))
)
select Order_year,
	   Order_Month,
       Monthly_Sales,
       round(sum(Monthly_Sales) over(order by Order_Year,Order_Month rows between unbounded preceding and current row),2) as Running_Total_Sales
from cte_Monthly_sales;

/*Q37 — Rank Products Within Each Category*/
with cte_product_sales as(
select Product_Category,
	   Product_Name,
       round(sum(Total_Sales),2) as Total_Sales
from global_ecommerce_sales
group by Product_Category,Product_Name
)
select Product_Category,
	   Product_Name,
       Total_Sales,
       rank() over(partition by Product_Category order by Total_sales desc) Category_Rank
from cte_product_sales;

/*Q38 — Top Product in Each Category*/
select Product_Category,
	   Product_Name,
       Total_Sales
from (
		with cte_product_sales as(
		select Product_Category,
			   Product_Name,
			   round(sum(Total_Sales),2) as Total_Sales
		from global_ecommerce_sales
		group by Product_Category,Product_Name
		)
			select Product_Category,
				   Product_Name,
				   Total_Sales,
				   rank() over(partition by Product_Category order by Total_sales desc) Category_Rank
			from cte_product_sales) t	
where Category_Rank = 1;

/*Q39 — Customers Above Average Spending*/
with cte_by_customer_group as(
select Customer_Name,
	   round(sum(Total_Sales),2) as Total_Sales
from global_ecommerce_sales
group by Customer_Name
)
select Customer_Name,
	   Total_Sales
from cte_by_customer_group 
where Total_Sales > (select avg(Total_Sales) from cte_by_customer_group);

/*Q40 — Most Profitable Customer in Each Segment*/
with cte_profit_by_Customer as(
select Customer_Segment,
	   Customer_Name,
       round(sum(Profit),2) Total_Profit,
       rank() over(partition by Customer_Segment order by round(sum(Profit),2) desc) as rank_customer
from global_ecommerce_sales
group by Customer_Segment,Customer_Name
)
select Customer_Segment,
	   Customer_Name,
       Total_Profit
from cte_profit_by_Customer
where rank_customer = 1

