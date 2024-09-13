-- SELECT *
-- FROM gooutside.daily_sales

-- SELECT *
-- FROM gooutside.methods;

-- SELECT *
-- FROM gooutside.products;

-- SELECT *
-- FROM gooutside.retailers;

-- ALTER TABLE gooutside.methods
-- ADD PRIMARY KEY (method_id) NOT ENFORCED;

-- ALTER TABLE gooutside.retailers
-- ADD PRIMARY KEY (retailer_id) NOT ENFORCED;

-- ALTER TABLE gooutside.products
-- ADD PRIMARY KEY (product_id) NOT ENFORCED;

-- SELECT * FROM `gooutside.daily_sales`
-- WHERE method_id NOT IN (SELECT method_id from `gooutside.methods`);

-- ALTER TABLE gooutside.daily_sales
-- ADD FOREIGN KEY (method_id) REFERENCES gooutside.methods(method_id);
-- ALTER TABLE gooutside.daily_sales
-- ADD FOREIGN KEY (product_id) REFERENCES gooutside.products(product_id);
-- ALTER TABLE gooutside.daily_sales
-- ADD FOREIGN KEY (retailer_id) REFERENCES gooutside.retailers(retailer_id);
