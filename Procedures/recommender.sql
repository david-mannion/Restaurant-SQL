use wonka_test;
SET SQL_SAFE_UPDATES = 0;

DROP FUNCTION if exists Recommender;
DELIMITER //

CREATE FUNCTION Recommender(
search_pizza_id INT
)
Returns INT

deterministic

BEGIN
	DECLARE rec_beverage_id Int DEFAULT 10000;
    DECLARE save Int DEFAULT 0;
    
    DROP TEMPORARY TABLE IF EXISTS temp_table;
	CREATE TEMPORARY TABLE temp_table(
	beverage_id int
	);
    
    insert into temp_table(beverage_id)
		select beverage_pairing_cheese.beverage_id from beverage_pairing_cheese
		join cheese_allocations on cheese_allocations.cheese_id = beverage_pairing_cheese.cheese_id
		where cheese_allocations.pizza_id = search_pizza_id
		order by cheese_allocations.pizza_id asc;
        
    insert into temp_table(beverage_id)
		select beverage_pairing_meat.beverage_id from beverage_pairing_meat
		join meat_allocations on meat_allocations.meat_id = beverage_pairing_meat.meat_id
		where meat_allocations.pizza_id = search_pizza_id
		order by meat_allocations.pizza_id asc;
        
	insert into temp_table(beverage_id)
		select beverage_pairing_vegetable.beverage_id from beverage_pairing_vegetable
		join vegetable_allocations on vegetable_allocations.vegetable_id = beverage_pairing_vegetable.vegetable_id
		where vegetable_allocations.pizza_id = search_pizza_id
		order by vegetable_allocations.pizza_id asc;
        
	insert into temp_table(beverage_id)
		select beverage_pairing_sauce.beverage_id from beverage_pairing_sauce
		join sauce_allocations on sauce_allocations.sauce_id = beverage_pairing_sauce.sauce_id
		where sauce_allocations.pizza_id = search_pizza_id
		order by sauce_allocations.pizza_id asc;
        
        select beverage_id into @save from 
			(
			select beverage_id, count(beverage_id) as c from temp_table
			group by beverage_id
			order by c desc
			limit 1) as s
			;
            
		set rec_beverage_id = @save;
	
	Return (rec_beverage_id);
    
END //
DELIMITER ;


