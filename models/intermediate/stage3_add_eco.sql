with stage3_add_eco as (
    select * from {{ ref('stage2_filtered_mod_cols') }}
) ,
chess_openings_eco as (
    select * from {{ ref('chess_openings_eco') }}
)   
select 
    * except (Opening_Moves, ECO_Code_, start_time, end_date, end_time)
from stage3_add_eco as st1
left join chess_openings_eco as ecotable
on st1.eco_code = ecotable.ECO_Code_
