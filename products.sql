create table Brand(
    brand_id VARCHAR, 
    brand_name VARCHAR,
    PRIMARY KEY(brand_id)
);

create table Category(
    category_id VARCHAR,
    Category_name VARCHAR, 
    Parent_category VARCHAR,
    PRIMARY KEY(category_id)
);

create table Product(
    product_id VARCHAR,
    product_name VARCHAR,
    product_ratings SMALLINT,
    product_price NUMERIC,
    brand_id VARCHAR,
    category_id VARCHAR,

    PRIMARY KEY(product_id),
    FOREIGN KEY (brand_id) REFERENCES Brand (brand_id),
    FOREIGN KEY (category_id) REFERENCES Category (category_id)
);


-- drop table product;


SELECT Category.category_id,Category.Category_name, Category.Parent_category  FROM Category INNER JOIN Product ON Category.category_id = product.category_id;


SELECT Category.category_id,Category.Category_name,Category.Parent_category,Product.product_id, product.product_name, product.brand_id, product.product_price, product.product_ratings FROM Category JOIN Product ON Category.category_id = product.category_id;


SELECT category.category_name, brand.brand_name, product.product_id, product.product_name 
FROM category 
INNER JOIN Product ON category.category_id = product.category_id 
INNER JOIN Brand ON brand.brand_id = product.brand_id;



-- 1st
SELECT * FROM product;

--2nd
SELECT * FROM product WHERE category_id = 'cat1'

--3rd
SELECT
	product.product_name 
FROM product
LEFT JOIN category ON product.category_id = category.category_id
WHERE category.category_id='cat1';


--4th
SELECT
	*
FROM product
LEFT JOIN category ON product.category_id = category.category_id
WHERE category.category_name='cat_name2';


--5th

SELECT
	*
FROM category
LEFT JOIN product ON product.category_id = category.category_id
-- WHERE category.category_name='cat_name2';



UPDATE product set product_name=NULL where product_id='p1';
UPDATE category set parent_category='parent1' where category_id='cat5';

--list all subcategories under a category
SELECT category_name from category where parent_category='parent1';

--list all subcategories under a list of category
SELECT category_name, category_id from category where parent_category  IN ('parent1','parent2','parent3');


--list all sub-categories under a category(based on name)
-- SELECT category.category_id FROM category as user JOIN category as parent ON 
-- JOIN 


ALTER TABLE category DROP COLUMN parent_category_id;

ALTER TABLE category
ADD COLUMN parent_category_id VARCHAR;

ALTER TABLE category 
ADD CONSTRAINT fk FOREIGN KEY(parent_category_id) 
REFERENCES category(category_id);

UPDATE category set parent_category_id='cat3' where category_id='cat5';


-- list all sub_category under a category(based on name):using self join
 
select  c.category_id as sub_categories from category c  join category p on c.parent_category_id=p.category_id where p.category_name='cat_name1';

-- list all categories and their parent categories name
select c.category_id,p.category_id as parent_category_id ,p.category_name as parent_name from category c left join category p on c.parent_category_id=p.category_id;