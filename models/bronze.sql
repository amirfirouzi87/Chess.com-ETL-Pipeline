select 
        pgn,
        time_class, 
        white, 
        black,
        REPLACE(eco,'-',' ' ) AS
        eco,
        username
 from dbt_demo.chess_games
 where pgn is not null