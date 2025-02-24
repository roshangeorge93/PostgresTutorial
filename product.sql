-- Product table 
CREATE TABLE product(
	pr_id  varchar(100),
	pr_name char(100),
	price REAL,
	ratings REAL,
	br_id VARCHAR(100),
	cat_id VARCHAR(100),
	PRIMARY KEY(pr_id),
	FOREIGN KEY(br_id) REFERENCES brand(br_id),
	FOREIGN KEY(cat_id) REFERENCES category(cat_id)
); 

-- List all products
SELECT * FROM product;

-- list all products and filter based on cat_id
SELECT * FROM product WHERE cat_id='cid5';


-- given a categoryid list the products
SELECT * FROM product WHERE cat_id='cid3';

-- list all products based on the category name
SELECT * FROM product LEFT JOIN category ON product.cat_id = category.cat_id WHERE category.cat_name='cname8';

-- list all categories and their products
 SELECT*,product.pr_name FROM category LEFT JOIN product ON category.cat_id=product.cat_id;

-- list all sub-categories under a category
SELECT par_cat_id, cat_id, cat_name FROM category where par_cat_id='parCat4';

-- list all sub categories  under a list of categories
SELECT par_cat_id, cat_id, cat_name FROM category where par_cat_id IN('parCat4','parCat1'); 

-- list all sub_category under a category(based on name):using self join
select  c.cat_id as sub_categories from category c  join category p on c.parent_cat_id=p.cat_id where p.cat_name='cname1';

-- list all categories and their parent categories name
select c.cat_id,p.cat_id as parent_category_id ,p.cat_name as parent_name from category c left join category p on c.parent_cat_id=p.cat_id;