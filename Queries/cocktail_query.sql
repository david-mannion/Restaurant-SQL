
select

Cocktail.id as Cocktail_ID,
Cocktail.detail as Cocktail_Name,
Liquid.detail as Liquid_Name,
Liquid_Allocations.size_ml as Liquid_Amount,
Garnish.detail as Garnish_Type,
Garnish_Allocations.serving as Garnish_serving,
Ice.detail as Ice_type,
Glass.detail as Glass_type

from Cocktail

join Ice on  Ice.id = cocktail.ice_id
join Glass on  Glass.id = cocktail.glass_id

join Liquid_Allocations on Liquid_Allocations.Cocktail_id = Cocktail.id
join Liquid on Liquid.id = liquid_allocations.liquid_id

join Garnish_Allocations on Garnish_Allocations.Cocktail_id = Cocktail.id
join Garnish on Garnish.id = garnish_allocations.garnish_id
order by Cocktail_ID asc
;