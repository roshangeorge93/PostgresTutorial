-- creating table brand
CREATE TABLE Brand(
  brand_id VARCHAR ,
  brand_name VARCHAR,
  PRIMARY KEY(brand_id)
  
);
----------------------------------------------------------------------------------------------------------------
-- creating table category
CREATE TABLE Category(
category_id varchar,
category_name VARCHAR,
parent_category_id VARCHAR,
PRIMARY KEY(category_id)
);
----------------------------------------------------------------------------------------------------------------
-- creating table products
CREATE TABLE Products(
product_id VARCHAR,
product_name VARCHAR,
product_price REAL,
product_rating SMALLINT,
PRIMARY KEY(product_id),
brand_id VARCHAR,
category_id VARCHAR,
FOREIGN key (brand_id) REFERENCES Brand (brand_id),
FOREIGN key (category_id) REFERENCES Category (category_id)
);
----------------------------------------------------------------------------------------------------------------


SELECT
	products.product_id,
	products.product_name,
	products.product_price,
	products.product_rating,
	brand.brand_name,
	brand.brand_id,
	category.category_name
FROM
	products
	JOIN brand ON products.brand_id = brand.brand_id
	JOIN category ON category.category_id = products.category_id;
 
 ----------------------------------------------------------------------------------------------------------------
 
ALTER TABLE category
    ADD CONSTRAINT fk_par_id FOREIGN KEY (parent_category_id) REFERENCES category (parent_category_id);

----------------------------------------------------------------------------------------------------------------
SELECT
	category.category_id,products.product_name
FROM
	category
	LEFT JOIN products ON category.category_id = products.category_id;


----------------------------------------------------------------------------------------------------------------



SELECT category.category_id,products.product_name
  FROM category
  left join 
  products on category.category_id = products.category_id
 WHERE category.category_id = 'c_id1';

select products.category_id,products.product_name
from products ;

select products.product_name,category.category_id
from products join category on category.category_id = products.category_id;


SELECT category.category_id,products.product_name
  FROM category
  left join 
  products on category.category_id = products.category_id
 WHERE category.category_name = 'c_name1';

----------------------------------------------------------------------------------------------------------------
-- list all products
select * from products;

----------------------------------------------------------------------------------------------------------------
-- given a category_id ,list the products
select * from products left join category on products.category_id=category.category_id  where category.category_id='c_id1';
----------------------------------------------------------------------------------------------------------------
-- list all products and filter based on cat_name
select * from products left join category on products.category_id=category.category_id where category.category_name='c_name1';
----------------------------------------------------------------------------------------------------------------
-- list all categories and their products
select * from category left join products on products.category_id=category.category_id;
----------------------------------------------------------------------------------------------------------------
-- list all products and print their brand name
SELECT * from products left join brand on brand.brand_id=products.brand_id;
----------------------------------------------------------------------------------------------------------------

insert into category(category_id,category_name,parent_category_id) values ('c_id5','c_name5','pc_id5');


insert into products(product_id,product_name,product_price,product_rating,brand_id,category_id) values ('product_id5','product_name5',600,3,'b3','c_id4');


insert into category(category_id,category_name,parent_category_id) values ('c_id6','c_name6','pc_id5');

-- list all sub_categories under a category(based on cat_id)

select * from category where category.parent_category_id='pc_id5';

-- list all sub_categories under a list of categories(based on id)
SELECT * FROM category
WHERE category.parent_category_id IN ('pc_id1','pc_id5','pc_id2');



ALTER TABLE category DROP COLUMN parent_category_id;

alter table category
add column parent_category_id varchar;  

alter table category
add CONSTRAINT fk 
FOREIGN KEY (parent_category_id)
REFERENCES category (category_id);

update category set parent_category_id='c_id2'  where category_id='c_id1';

update category set parent_category_id='c_id2'  where category_id='c_id2';

update category set parent_category_id='c_id3'  where category_id='c_id3';
update category set parent_category_id='c_id4'  where category_id='c_id4';
update category set parent_category_id='c_id5'  where category_id='c_id5';
update category set parent_category_id='c_id1'  where category_id='c_id6';

-- list all sub_category under a category(based on name):using self join

select  c.category_id as sub_categories from category c  join category p on c.parent_category_id=p.category_id where p.category_name='c_name2';



-- list all categories and their parent categories name
select c.category_id,p.category_id as parent_category_id ,p.category_name as parent_name from category c left join category p on c.parent_category_id=p.category_id;










