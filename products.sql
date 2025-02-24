CREATE TABLE Category (
    cat_id VARCHAR(15) PRIMARY KEY, 
    cat_name VARCHAR(20),
    pat_id VARCHAR(15)
);

CREATE TABLE Brand (
    b_id VARCHAR(5) PRIMARY KEY, 
    b_name VARCHAR(20) 
);


CREATE TABLE Products (
    P_id VARCHAR(5) PRIMARY KEY, 
    p_name VARCHAR(20), 
    cat_id VARCHAR(5) REFERENCES Category(cat_id) , 
    b_id VARCHAR(5)  REFERENCES Brand(b_id)  
);



INSERT INTO Brand (b_id, b_name) VALUES 
    ('B001', 'ASUS'),
    ('B002', 'SAMSUNG'),
    ('B003', 'APPLE'); 
    
INSERT INTO Category (cat_id, cat_name,pat_id) VALUES 
    ('C003', 'Electronics',''),
    ('C001', 'Laptops','C003'),
    ('C002', 'Mobiles','C003'); 

INSERT INTO Products (p_id, p_name,cat_id,b_id) VALUES 
    ('P001', 'Macbook','C001','B001'),
    ('P002', 'rog','C001','B001'),

    
    ('P003', 'iphone','C002','B003'), 
    ('P004', 's24','C002','B002'),
    ('P005', 'zenfone','C002','B001');     
       
SELECT c1.cat_name ,c1.cat_id
	 	FROM Category c1
	 	 WHERE c1.cat_id = 'C002';
	 	    
   
-- root to leaf
WITH RECURSIVE category_tree AS (
	 SELECT c1.cat_name ,c1.cat_id
	 	FROM Category c1
	 	 WHERE c1.cat_id = 'C003'

	UNION ALL
	
	SELECT c2.cat_name, c2.cat_id
	FROM Category c2
	JOIN category_tree   on category_tree.cat_id = c2.pat_id
)  SELECT * from category_tree;


--leaf to root
WITH RECURSIVE category_tree AS (
	 SELECT c1.cat_name ,c1.cat_id, c1.pat_id
	 	FROM Category c1
	 	 WHERE c1.cat_id = 'C002'

	UNION ALL
	
	SELECT c2.cat_name, c2.cat_id , c2.pat_id
	FROM Category c2
	JOIN category_tree   on category_tree.pat_id = c2.cat_id
)  SELECT * from category_tree;


SELECT p.p_name, c1.cat_name ,c1.cat_id, c1.pat_id
	 	FROM Category c1 ,Products p
	 	 WHERE c1.cat_id = 'C002';


--for a given p.P_id return pname ,cat_name_child-cat_name_parent-so on

WITH RECURSIVE category_hierarchy AS (
    SELECT c1.cat_name, c1.cat_id, c1.pat_id
    FROM Category c1
    WHERE c1.cat_id = 'C002' 

    UNION ALL

    SELECT c2.cat_name, c2.cat_id, c2.pat_id
    FROM Category c2
    JOIN category_hierarchy ch ON ch.pat_id = c2.cat_id
)
SELECT 'C002' as leaf_id , STRING_AGG(ch.cat_name, '-') AS category_hierarchy 
FROM  category_hierarchy ch ;

-- working but not as intdended

WITH RECURSIVE category_hierarchy AS (
    SELECT c1.cat_name, c1.cat_id, c1.pat_id
    FROM Category c1
    WHERE c1.cat_id = 'C002' 

    UNION ALL

    SELECT c2.cat_name, c2.cat_id, c2.pat_id
    FROM Category c2
    JOIN category_hierarchy ch ON ch.pat_id = c2.cat_id
)
SELECT p.p_name , STRING_AGG(ch.cat_name, '-' ORDER BY ch.cat_id ) AS category_hierarchy  
FROM products p 
JOIN category_hierarchy ch ON p.cat_id=ch.cat_id
GROUP BY p.p_name;



CREATE TEMP TABLE category_list AS
WITH RECURSIVE category_hierarchy AS (
    SELECT c1.cat_name, c1.cat_id, c1.pat_id
    FROM Category c1
    WHERE c1.cat_id = 'C002' 

    UNION ALL

    SELECT c2.cat_name, c2.cat_id, c2.pat_id
    FROM Category c2
    JOIN category_hierarchy ch ON ch.pat_id = c2.cat_id
)
SELECT 'C002' as leaf_id , STRING_AGG(ch.cat_name, '-') AS category_hierarchy 
FROM  category_hierarchy ch ;

SELECT p.p_name , c.category_hierarchy from products p, category_list c WHERE
p.cat_id= c.leaf_id 
-------------------------------------
-- p_name  | category_list          | 
-- zenfone |	Mobiles-Electronics |
-- s24     | 	Mobiles-Electronics |
-- iphone  |	Mobiles-Electronics |
-------------------------------------