select * from scm.`4_5_4_calendar csv`;
select count(*) from scm.`4_5_4_calendar csv`;
use scm;
select * from scm.`4_5_4_calendar csv` c join scm.`f_sales csv` s on date(c.date) = date(s.date);

-- KPI1
Select 
Product_Family,
sum(quantity*price) as Sales_Amount
from
scm.`plugs_electronics_hands_on_lab_data csv`;

SELECT  `Product Family`, Quantity ,Price , Quantity*Price as 'Sales Amount' FROM scm.`plugs_electronics_hands_on_lab_data csv`;
SELECT `Product Family` FROM scm.`plugs_electronics_hands_on_lab_data csv`;

select `product family`, `Sales Amount` from scm.`plugs_electronics_hands_on_lab_data csv`;

select * from scm.`plugs_electronics_hands_on_lab_data csv`;
alter table scm.`plugs_electronics_hands_on_lab_data csv`
add `Sales_Amount`int;
set sql_safe_updates=0;
UPDATE scm.`plugs_electronics_hands_on_lab_data csv`
SET Sales_Amount = Quantity * Price;
select* from scm.`plugs_electronics_hands_on_lab_data csv`;


-- KPI 1 MTD YTD QTD
-- YTD
SELECT 
    year(Date) AS Year,
    SUM(price * Quantity) AS "Total Sales"
FROM 
    scm.`plugs_electronics_hands_on_lab_data csv` 
GROUP BY 
    YEAR
ORDER BY 
    Year;
    
    SELECT 
    YEAR(Date) AS Year,
    SUM(Price * Quantity) AS Total_Sales
FROM 
    scm.`plugs_electronics_hands_on_lab_data csv`
WHERE
    Date >= DATE_FORMAT(CURDATE(), '%Y-01-01')
    AND Date <= CURDATE()
GROUP BY 
    Year
ORDER BY 
    Year;
select `order number`,Date,Sales_Amount, sum(`sales_amount`)  over (partition by year(date) order by Date) as YTD from scm.`plugs_electronics_hands_on_lab_data csv`;

-- MTD
SELECT 
    Date,
    SUM(Price * Quantity) AS Total_Sales,
    SUM(SUM(price * Quantity)) OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY Date) AS "MTD Total Sales"
FROM 
    scm.`plugs_electronics_hands_on_lab_data csv`
GROUP BY 
    Date
ORDER BY 
    Date;
-- QTD
Select
Date,
Sum(Price * Quantity) As Total_Sales,
sum(sum(Price*Quantity)) Over (partition by year(Date), quarter(Date) order by Date) As "QTD Total_Sales"
From 
scm.`plugs_electronics_hands_on_lab_data csv`
group by
Date
order by
Date;


-- KPi2 Product Wise sales
Select `product family`,sum(`sales_amount`) as `Total Sales` from scm.`plugs_electronics_hands_on_lab_data csv` group by `Product Family`;

-- KPIs 3 Daily Sales Trend
select Date , sum(Quantity) as Sales_trend from scm.`plugs_electronics_hands_on_lab_data csv` group by Date order by year(date);
SELECT DATE_FORMAT(date, '%Y-%m-%d') AS date, 
       DATE_FORMAT(Date, '%H:%i:%s') AS time
FROM scm.`plugs_electronics_hands_on_lab_data csv`;
   select time(Date) AS Time_Part
FROM 
    scm.`plugs_electronics_hands_on_lab_data csv`;
select
    date(`Date`) as sale_day,
    SUM(Sales_Amount) as daily_sales
FROM 
    scm.`plugs_electronics_hands_on_lab_data csv`
GROUP BY 
    sale_day
ORDER BY 
    sale_day;
Select * from scm.`f_point_of_sale csv`;
select * from scm.`f_sales csv`;
select * from scm.`f_point_of_sale csv` ps join sales s on scm.ps.`Order Number` = s.`Order Number`;

-- Kpi 4 State wise sale

select `store state` as State,sum(`sales_amount`)total_sales from scm.`plugs_electronics_hands_on_lab_data csv`
group by `Store State` ;

-- KPI 5 Top 5 Stores

Select `store name`, sum(`Sales_Amount`) as Sales from scm.`plugs_electronics_hands_on_lab_data csv`
group by `Store name`
order by `Sales` desc
Limit 5;

-- KPI 6 Region Wise Sales

Select `store region` as Region,sum(`sales_amount`)total_sales from scm.`plugs_electronics_hands_on_lab_data csv`
group by `Store Region`;


-- KPIs 7 Total INventory

Select sum(`Quantity on Hand`) from scm.`f_inventory_adjusted csv` as Total_inventory ;
select `product family`,sum(`Quantity on Hand`) as `total inventory` from scm.`f_inventory_adjusted csv` group by `product family`;
set global sql_mode=(select replace(@@sql_mode,'only_full_group_by',''));
select `Product Group`, `product line`,`product name`,sum(`quantity on hand`) as 'Quantity on hand' from scm.`f_inventory_adjusted csv` group by `Product Group`,`Product Line`,`Product Name`;

-- KPI 8 Inventory cost

select `Product Group`, `Product Family`, `quantity on hand` * `cost amount`  as Inventory_cost from scm.`f_inventory_adjusted csv` ;

-- KPI 9  Over stock, Under stock



-- Kpi 10 Purchase method wise Sales
select * from scm.`f_sales csv`;
select * from scm.`plugs_electronics_hands_on_lab_data csv`;

SELECT 
    PM.`Purchase Method`,PL.`Cust Key`,
    PL.Price , PL.Quantity
FROM 
    scm.`f_sales csv` PM
left join
    scm.`plugs_electronics_hands_on_lab_data csv` PL on PM.`Cust Key` = PL.`Cust Key`
    group by PL.`Cust Key`;

Select sum(Sales_Amount), SL.`Purchase Method`, from scm.`plugs_electronics_hands_on_lab_data csv` pl
left join 
scm.`f_sales csv` SL on SL.`Cust Key` = scm.pl.`Cust Key`
group by SL.`Purchase Method`;

select `cust key` from scm.`plugs_electronics_hands_on_lab_data csv`
group by `Cust Key` ; 

select `cust key` from  scm.`f_sales csv`
group by `Cust Key` ; 

select PL.`Cust Key`, Sl.`store key` from scm.`plugs_electronics_hands_on_lab_data csv` PL
left join
scm.`f_sales csv` SL on SL.`Order Number` = PL.`order number`;




