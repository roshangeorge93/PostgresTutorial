
-- product , category and brand DATABASE


create table Brand(
b_id  SERIAL PRIMARY KEY,
b_name varchar
);

CREATE TABLE category (
    cat_id SERIAL PRIMARY KEY,
    cat_name VARCHAR,
    
  	
);


CREATE TABLE Product (
    p_id SERIAL PRIMARY KEY,
    p_name VARCHAR(100),
   	cat_id int,
    b_id int,
    CONSTRAINT fk_category FOREIGN KEY (cat_id)
	REFERENCES category(cat_id),
    CONSTRAINT fk_brand FOREIGN KEY (b_id)
    REFERENCES brand(b_id)
);

alter table category add parent_id int;
alter table category
add constraint fk_category
foreign key (cat_id) references category(cat_id)


-- simple query to check whether its is working or not!

SELECT 
product.p_id,product.p_name,category.cat_name,category.cat_id,category.parent_id,brand.b_name,brand.b_id
 FRom product INNER JOIN category 
 on category.cat_id=product.cat_id 
 INNER JOIN brand on brand.b_id=product.b_id;


-- 1.list all products
select * from product;


--2. list all products And filter based on cat_id

select p_name,cat_id from product where cat_id=20;

-- 3.given a catgeory id ,list all the products
select cat_id,p_name from product where cat_id=30;


-- 4.lista all products and filtrer based on cat_name

-- select product.p_name ,category.cat_name from category inner join  product on product.cat_id=category.cat_id where category.cat_name='android';

select product.p_name ,category.cat_name from product left join  category on product.cat_id=category.cat_id where category.cat_name='android';

-- 5.list all category and their products
-- select category.cat_name,product.p_name from product right join category on product.cat_id=category.cat_id;
select category.cat_name,product.p_name from category left join product on product.cat_id=category.cat_id;


--6.list all products and print brand name
select product.p_name,brand.b_name from product left join brand on product.b_id=brand.b_id;

-- level-2
--1.list all sub categories under a category  based on cat_id
select  cat_name as sub_cat,parent_id,cat_id from category where parent_id='40'

--2.list all sub catagories under a list of categories based on id
select  cat_id,cat_name  as sub_cat from category where parent_id='10'

---3.list all categories and sub_categories name
-- SELECT p.cat_name AS parent_cat,c.cat_name AS sub_cat 
-- FROM category c,category p 
-- WHERE c.parent_id=p.cat_id

select p.cat_name as parent_cat,c.cat_name 
from category c inner join category p 
on c.parent_id=p.cat_id;





--4.list all sub cat under a category based on cat_name
SELECT p.cat_name AS parent_cat,c.cat_name AS sub_cat 
FROM category c inner join category p 
on c.parent_id=p.cat_id and p.cat_name='electronics';


