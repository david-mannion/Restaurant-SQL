use wonka_test;
SET SQL_SAFE_UPDATES = 0;

DROP procedure if exists New_Cocktail;
DELIMITER //

CREATE PROCEDURE New_Cocktail(
IN liquid1_id INT,
IN liquid2_id INT,

IN liquid1_size_ml INT,
IN liquid2_size_ml INT,

IN garnish1_id INT,

IN garnish1_serving varchar(30),

IN new_ice_id INT,
IN new_glass_id INT

)

BEGIN
DECLARE new_cocktail_id Int DEFAULT 10000;
DECLARE cocktail_before VARCHAR(30) DEFAULT 'cocktail';
DECLARE cocktail_after VARCHAR(30) DEFAULT 'cocktail';

INSERT INTO cocktail(detail, ice_id, glass_id)
values
('new_cocktail', new_ice_id, new_glass_id);

select id into @new_cocktail_id from cocktail
order by id desc
limit 1;

INSERT INTO liquid_allocations(cocktail_id, liquid_id, size_ml)
values
(@new_cocktail_id, liquid1_id, liquid1_size_ml),
(@new_cocktail_id, liquid2_id, liquid2_size_ml)
;

INSERT INTO garnish_allocations(cocktail_id, garnish_id, serving)
values
(@new_cocktail_id, garnish1_id, garnish1_serving)
;


DROP TEMPORARY TABLE IF EXISTS temp_table_before;
CREATE TEMPORARY TABLE temp_table_before(
namelet_before varchar(30)
)
;

INSERT INTO temp_table_before(namelet_before)
	select
	namelet_liquid.detail as namelet
	from namelet_liquid
	join liquid_allocations on liquid_allocations.liquid_id = namelet_liquid.liquid_id
	join cocktail on cocktail.id = liquid_allocations.cocktail_id
	where namelet_liquid.location = 'Before'
	and
	cocktail.id = @new_cocktail_id;
    
INSERT INTO temp_table_before(namelet_before)
	select
	namelet_garnish.detail as namelet
	from namelet_garnish
	join garnish_allocations on garnish_allocations.garnish_id = namelet_garnish.garnish_id
	join cocktail on cocktail.id = garnish_allocations.cocktail_id
	where namelet_garnish.location = 'Before'
	and
	cocktail.id = @new_cocktail_id;

INSERT INTO temp_table_before(namelet_before)
	select
	namelet_ice.detail as namelet
	from namelet_ice 
	join cocktail on cocktail.ice_id = namelet_ice.ice_id
	where namelet_ice.location = 'Before'
	and
	cocktail.id = @new_cocktail_id;
    
    
select 
namelet_before into @cocktail_before
from temp_table_before
order by RAND()
LIMIT 1;

# After

DROP TEMPORARY TABLE IF EXISTS temp_table_after;
CREATE TEMPORARY TABLE temp_table_after(
namelet_after varchar(30)
);

INSERT INTO temp_table_after(namelet_after)
	select
	namelet_liquid.detail as namelet_after
	from namelet_liquid
	join liquid_allocations on liquid_allocations.liquid_id = namelet_liquid.liquid_id
	join cocktail on cocktail.id = liquid_allocations.cocktail_id
	where namelet_liquid.location = 'After'
	and
	cocktail.id = @new_cocktail_id;
    
INSERT INTO temp_table_after(namelet_after)
	select
	namelet_garnish.detail as namelet
	from namelet_garnish
	join garnish_allocations on garnish_allocations.garnish_id = namelet_garnish.garnish_id
	join cocktail on cocktail.id = garnish_allocations.cocktail_id
	where namelet_garnish.location = 'After'
	and
	cocktail.id = @new_cocktail_id;

INSERT INTO temp_table_after(namelet_after)
	select
	namelet_ice.detail as namelet
	from namelet_ice 
	join cocktail on cocktail.ice_id = namelet_ice.ice_id
	where namelet_ice.location = 'After'
	and
	cocktail.id = @new_cocktail_id;


select 
namelet_after into @cocktail_after
from temp_table_after
order by RAND()
LIMIT 1;

update cocktail set detail = CONCAT(@cocktail_before,' ',@cocktail_after) where id = @new_cocktail_id;

END //
DELIMITER ;


CALL New_Cocktail(
1, # liquid1_id
2, # liquid2_id
30, # liquid1_size_ml
40, # liquid2_size_ml
1, # garnish1_id
'slice', # garnish1_serving
1, # new_ice_id
1 # new_glass_id
);

select * from cocktail order by id desc;

