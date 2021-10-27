use wonka_test;
SET SQL_SAFE_UPDATES = 0;

DROP procedure if exists Promote_Pizza;
DELIMITER //

CREATE PROCEDURE Promote_Pizza(IN pizza_index INT)
BEGIN

DECLARE pizza_before VARCHAR(30) DEFAULT 'pizza';
DECLARE pizza_after VARCHAR(30) DEFAULT 'pizza';
DECLARE new_pizza_id Int DEFAULT 10000;
DROP TEMPORARY TABLE IF EXISTS temp_table;
CREATE TEMPORARY TABLE temp_table(
namelet varchar(30)
)
;

INSERT INTO temp_table(namelet)
	select
	namelet_cheese.detail as namelet
	from namelet_cheese 
	join cheese_allocations on cheese_allocations.cheese_id = namelet_cheese.cheese_id
	join development_pizza on development_pizza.id = cheese_allocations.pizza_id
	where namelet_cheese.location = 'Before'
	and
	development_pizza.id = pizza_index;

INSERT INTO temp_table(namelet)
	select
	namelet_meat.detail as namelet
	from namelet_meat 
	join meat_allocations on meat_allocations.meat_id = namelet_meat.meat_id
	join development_pizza on development_pizza.id = meat_allocations.pizza_id
	where namelet_meat.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
INSERT INTO temp_table(namelet)
	select
	namelet_vegetable.detail as namelet
	from namelet_vegetable 
	join vegetable_allocations on vegetable_allocations.vegetable_id = namelet_vegetable.vegetable_id
	join development_pizza on development_pizza.id = vegetable_allocations.pizza_id
	where namelet_vegetable.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
INSERT INTO temp_table(namelet)
	select
	namelet_sauce.detail as namelet
	from namelet_sauce 
	join sauce_allocations on sauce_allocations.sauce_id = namelet_sauce.sauce_id
	join development_pizza on development_pizza.id = sauce_allocations.pizza_id
	where namelet_sauce.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
INSERT INTO temp_table(namelet)
	select
	namelet_base.detail as namelet
	from namelet_base 
	join development_pizza on development_pizza.base_id = namelet_base.base_id
	where namelet_base.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
select 
namelet into @pizza_before
from temp_table
order by RAND()
LIMIT 1;

# After

DROP TEMPORARY TABLE IF EXISTS temp_table_after;
CREATE TEMPORARY TABLE temp_table_after(
namelet_after varchar(30)
);

INSERT INTO temp_table_after(namelet_after)
	select
	namelet_cheese.detail as namelet
	from namelet_cheese 
	join cheese_allocations on cheese_allocations.cheese_id = namelet_cheese.cheese_id
	join development_pizza on development_pizza.id = cheese_allocations.pizza_id
	where namelet_cheese.location = 'After'
	and
	development_pizza.id = pizza_index;

INSERT INTO temp_table_after(namelet_after)
	select
	namelet_meat.detail as namelet
	from namelet_meat 
	join meat_allocations on meat_allocations.meat_id = namelet_meat.meat_id
	join development_pizza on development_pizza.id = meat_allocations.pizza_id
	where namelet_meat.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
INSERT INTO temp_table_after(namelet_after)
	select
	namelet_vegetable.detail as namelet
	from namelet_vegetable 
	join vegetable_allocations on vegetable_allocations.vegetable_id = namelet_vegetable.vegetable_id
	join development_pizza on development_pizza.id = vegetable_allocations.pizza_id
	where namelet_vegetable.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
INSERT INTO temp_table_after(namelet_after)
	select
	namelet_sauce.detail as namelet
	from namelet_sauce 
	join sauce_allocations on sauce_allocations.sauce_id = namelet_sauce.sauce_id
	join development_pizza on development_pizza.id = sauce_allocations.pizza_id
	where namelet_sauce.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
INSERT INTO temp_table_after(namelet_after)
	select
	namelet_base.detail as namelet
	from namelet_base 
	join development_pizza on development_pizza.base_id = namelet_base.base_id
	where namelet_base.location = 'Before'
	and
	development_pizza.id = pizza_index;
    
select 
namelet_after into @pizza_after
from temp_table_after
order by RAND()
LIMIT 1;

INSERT INTO production_pizza(detail, base_id) values
(
(select CONCAT(@pizza_before,' ',@pizza_after)),
(select development_pizza.base_id from development_pizza where development_pizza.id = pizza_index)
);

select id into @new_pizza_id from production_pizza
order by id desc
limit 1;

UPDATE cheese_allocations
set pizza_id = @new_pizza_id where pizza_id = pizza_index;

UPDATE meat_allocations
set pizza_id = @new_pizza_id where pizza_id = pizza_index;

UPDATE sauce_allocations
set pizza_id = @new_pizza_id where pizza_id = pizza_index;

UPDATE vegetable_allocations
set pizza_id = @new_pizza_id where pizza_id = pizza_index;

UPDATE beverage_recommendation
set pizza_id = @new_pizza_id where pizza_id = pizza_index;

DELETE from development_pizza where id = pizza_index;

END //
DELIMITER ;

#CALL Promote_Pizza(1002);