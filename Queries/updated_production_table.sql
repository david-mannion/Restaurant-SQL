CALL Promote_Pizza(1010);

select
production_pizza.id as Pizza_ID,
production_pizza.detail as Pizza_Name,
Cheese.detail as Cheese_Name,
Meat.detail as Meat_Type, 
Vegetable.detail as Veg_Type,
Sauce.detail as Sauce_Name,
Base.detail as Base_Name

from production_Pizza

join Base on production_Pizza.base_id = Base.id

join cheese_allocations on cheese_allocations.pizza_id = production_Pizza.id
join Cheese on Cheese.id = cheese_allocations.cheese_id

join meat_allocations on meat_allocations.pizza_id = production_Pizza.id
join Meat on Meat.id = meat_allocations.meat_id

join vegetable_allocations on vegetable_allocations.pizza_id = production_Pizza.id
join Vegetable on Vegetable.id = vegetable_allocations.vegetable_id

join sauce_allocations on sauce_allocations.pizza_id = production_Pizza.id
join Sauce on Sauce.id = sauce_allocations.sauce_id;



