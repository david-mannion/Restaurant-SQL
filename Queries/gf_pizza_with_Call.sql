SELECT 
    development_pizza.id,
    development_pizza.detail AS 'development Pizza',
    base.detail AS 'Base'
FROM
    development_pizza
        JOIN
    base ON base.id = development_pizza.base_id
WHERE
    base.detail = 'Gluten-Free Crust';
    
CALL Promote_Pizza(1005);