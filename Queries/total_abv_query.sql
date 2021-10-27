SELECT 
    cocktail.detail AS 'Cocktail',
    ROUND(SUM(costs.cost_per_ml * 100 / (abv.abv)),
            3) AS Price_Per_ABV
FROM
    liquid
        JOIN
    liquid_allocations ON liquid_allocations.liquid_id = liquid.id
        JOIN
    costs ON liquid.id = costs.liquid_id
        JOIN
    abv ON liquid.id = abv.liquid_id
        JOIN
    cocktail ON cocktail.id = liquid_allocations.cocktail_id
GROUP BY cocktail_id
ORDER BY Price_Per_ABV ASC;

