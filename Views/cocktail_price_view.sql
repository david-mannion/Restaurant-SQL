
drop view if exists CocktailCost;
create view CocktailCost as
select
liquid.id, 
cocktail.detail as 'Cocktail',
round(sum(liquid_allocations.size_ml*costs.cost_per_ml),2) as total_price
from liquid
join liquid_allocations on liquid_allocations.liquid_id = liquid.id
join costs on liquid.id = costs.liquid_id
join cocktail on cocktail.id = liquid_allocations.cocktail_id

group by cocktail_id
order by total_price desc;

select * from cocktailcost;

