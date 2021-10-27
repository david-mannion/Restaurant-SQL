drop view if exists beverage_recommendations;
create view beverage_recommendations as
select
production_pizza.detail as 'Pizza Name',
beverage.detail as 'Beverage Recommendation' from production_pizza
join Beverage_Recommendation on Beverage_Recommendation.pizza_id = production_pizza.id
join beverage on beverage.id = Beverage_Recommendation.beverage_id;  
