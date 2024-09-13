select sales_date, quantity, ds.unit_price as unit_price_at_sale, unit_sale_price as actual_sale_price,
product_line, product_type, brand, product_name, color, unit_cost, p.unit_price as original_unit_price, 
retailer_name, retailer_type, country, 
method_type, ds.product_id, ds.retailer_id, ds.method_id
from `gooutside.daily_sales` ds join `gooutside.products` p using(product_id)
join `gooutside.retailers` using(retailer_id) join `gooutside.methods` using(method_id)
where extract(year from sales_date) = 2015;

select sales_date, quantity, ds.unit_price as unit_price_at_sale, unit_sale_price as actual_sale_price,
product_line, product_type, brand, product_name, color, unit_cost, p.unit_price as original_unit_price, 
retailer_name, retailer_type, country, 
method_type, ds.product_id, ds.retailer_id, ds.method_id
from `gooutside.daily_sales` ds join `gooutside.products` p using(product_id)
join `gooutside.retailers` using(retailer_id) join `gooutside.methods` using(method_id)
where extract(year from sales_date) = 2016;

select sales_date, quantity, ds.unit_price as unit_price_at_sale, unit_sale_price as actual_sale_price,
product_line, product_type, brand, product_name, color, unit_cost, p.unit_price as original_unit_price, 
retailer_name, retailer_type, country, 
method_type, ds.product_id, ds.retailer_id, ds.method_id
from `gooutside.daily_sales` ds join `gooutside.products` p using(product_id)
join `gooutside.retailers` using(retailer_id) join `gooutside.methods` using(method_id)
where extract(year from sales_date) = 2017;

select sales_date, quantity, ds.unit_price as unit_price_at_sale, unit_sale_price as actual_sale_price,
product_line, product_type, brand, product_name, color, unit_cost, p.unit_price as original_unit_price, 
retailer_name, retailer_type, country, 
method_type, ds.product_id, ds.retailer_id, ds.method_id
from `gooutside.daily_sales` ds join `gooutside.products` p using(product_id)
join `gooutside.retailers` using(retailer_id) join `gooutside.methods` using(method_id)
where extract(year from sales_date) = 2018;