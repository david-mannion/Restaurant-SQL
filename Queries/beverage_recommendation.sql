SELECT 
    pizza_id AS Pizza_ID,
    production_pizza.detail as 'Pizza Name',
    beverage.detail AS 'Beverage Recommendation',
    beverage.nationality as 'Nationality'
FROM
    beverage_recommendation
        JOIN
    production_pizza ON production_pizza.id = beverage_recommendation.pizza_id
        JOIN
    beverage ON beverage.id = beverage_recommendation.beverage_id
ORDER BY production_pizza.id ASC;
