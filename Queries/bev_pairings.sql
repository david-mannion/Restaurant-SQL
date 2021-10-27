select * from beverage_pairing_cheese;

select * from production_pizza
join cheese_allocations on cheese_allocations.pizza_id = production_pizza.id
join beverage_pairing_cheese on beverage_pairing_cheese.cheese_id = cheese_allocations.cheese_id
order by production_pizza.id;