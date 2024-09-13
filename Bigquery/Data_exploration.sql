-- time covered
select  min(sales_date) as min_date, max(sales_date) as max_date from `gooutside.daily_sales`;

-- how many products
select count(*) as product_count from `gooutside.products`;

-- how many retailers, in how many countries
select count(*) as retailer_count, count(distinct country) as country_count from `gooutside.retailers`;

-- number of retailers per country
select country, count(*) AS retailer_count from `gooutside.retailers` group by country order by retailer_count DESC;

-- popularity of various lines by country
select country, product_line, sum(quantity) AS items_sold
from `gooutside.daily_sales` ds join `gooutside.retailers` r on ds.retailer_id = r.retailer_id join `gooutside.products` p on ds.product_id = p.product_id
group by country, product_line
order by country, items_sold DESC;
-- Golf is popular in asia, mountaineering in northern europe

-- quantities and sales by quarter
select extract(year from sales_date) AS year, extract(month FROM sales_date) AS month, 
sum(quantity) AS items_sold, sum(quantity*unit_sale_price)/pow(10,6) AS total_sales_millions
from `gooutside.daily_sales`
group by extract(year from sales_date), extract(month FROM sales_date)
order by year, month;
-- would be better to see as graph

-- yearly profits
select extract(year from sales_date) AS year, sum(quantity*(unit_sale_price-unit_cost)/pow(10,6)) AS sales_profit_millions
from `gooutside.daily_sales` ds
inner join `gooutside.products` p on ds.product_id = p.product_id
group by extract(year from sales_date)
order by year;

-- identify 5 top-selling brands. 5 worst-selling as well
select brand, round(sum(quantity * unit_sale_price),2) AS total_sales
from `gooutside.daily_sales` ds
inner join `gooutside.products` p on ds.product_id = p.product_id
group by brand
order by total_sales 
-- DESC -- uncomment for worst selling
limit 5;

-- explore the use of sales methods over the years. 
select extract(year FROM sales_date) AS sales_year, min(method_type) AS method, count(*) AS times_used
from `gooutside.daily_sales` ds
join `gooutside.methods` m on ds.method_id = m.method_id
group by m.method_id, extract(year FROM sales_date)
order by sales_year, times_used DESC;
-- over countries as well
select country, min(method_type) AS method, count(*) AS times_used
from `gooutside.daily_sales` ds
join `gooutside.methods` m on m.method_id = ds.method_id join `gooutside.retailers` r on r.retailer_id = ds.retailer_id
group by m.method_id, country
order by country, times_used DESC;

-- just how much of our business is by web? can we cut other methods?
select min(method_type) AS sales_method, 
sum(quantity*unit_sale_price)*100/(SELECT sum(quantity*unit_sale_price) from `gooutside.daily_sales`) AS perc_of_sales, 
sum(quantity*unit_sale_price)/pow(10,6)/(select count(distinct extract(year from sales_date)) from `gooutside.daily_sales`) AS total_sales_millions_yearly
from `gooutside.daily_sales` ds join `gooutside.methods` m on ds.method_id = m.method_id
group by m.method_id
order by perc_of_sales DESC;

-- what are the average discount rates across countries? express as a percentage
-- discount is difference between unit_price and unit_sale_price
select country, AVG((unit_price - unit_sale_price)/unit_price*100) avg_perc_discount
from `gooutside.daily_sales` ds
join `gooutside.retailers` r on ds.retailer_id = r.retailer_id
group by country;

-- compare the sales of different lines of products. display the total in millions of euro
select product_line, sum(quantity * unit_sale_price)/pow(10, 6) AS total_sales_millions
from `gooutside.daily_sales` ds
join `gooutside.products` p on ds.product_id = p.product_id
group by product_line
order by total_sales_millions DESC;

-- have all products been sold?
select p.* from `gooutside.products` p
left join `gooutside.daily_sales` ds on ds.product_id = p.product_id
where quantity is null;

-- what type of product has been ordered the most?
SELECT product_type, sum(quantity)
from `gooutside.daily_sales` ds
join `gooutside.products` p on ds.product_id = p.product_id
group by product_type
order by sum(quantity) DESC;
-- considering cost as well, how much profit does it produce?
SELECT sum(quantity*(unit_sale_price-unit_cost)/pow(10,6)) AS total_profit_millions
from `gooutside.daily_sales` ds
join `gooutside.products` p on ds.product_id = p.product_id
where product_type = 'Eyewear';

-- what is this nonsense of unit_price not matching across tables? 
select min(product_name) as product_name, min(brand) as brand, min(sales_date) as min_date, max(sales_date) as max_date, 
min(p.unit_price-ds.unit_price) as most_negative_diff, max(p.unit_price-ds.unit_price) as most_positive_diff, 
avg(p.unit_price-ds.unit_price) as avg_diff 
from `gooutside.products` p
join `gooutside.daily_sales` ds on ds.product_id = p.product_id
where p.unit_price != ds.unit_price
group by p.product_id;
-- Does not effect only older orders, many run the entire timespan; all differences range positive to negative values, though mostly small.
-- Affects only 80 of 274 products 