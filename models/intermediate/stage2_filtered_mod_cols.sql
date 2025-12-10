with stage2_filtered_mod_cols as (
    select * from {{ ref('stage1_extracted_cols') }}
)
select
    time_class,
    username,
    white_username,
    black_username,
concat(
        -- Calculate Minutes (floor division)
        floor(
            timestampdiff(SECOND, 
                to_timestamp(concat(start_date, ' ', start_time), 'yyyy.MM.dd HH:mm:ss'), 
                to_timestamp(concat(end_date,   ' ', end_time),   'yyyy.MM.dd HH:mm:ss')
            ) / 60
        ), 
        'm ', 
        -- Calculate Remaining Seconds (modulo) and pad with zero (e.g., 5 becomes 05)
        lpad(
            timestampdiff(SECOND, 
                to_timestamp(concat(start_date, ' ', start_time), 'yyyy.MM.dd HH:mm:ss'), 
                to_timestamp(concat(end_date,   ' ', end_time),   'yyyy.MM.dd HH:mm:ss')
            ) % 60, 
        2, '0'), 
        's'
    ) as duration_formatted,
    timestampdiff(
        SECOND, 
        to_timestamp(concat(start_date, ' ', start_time), 'yyyy.MM.dd HH:mm:ss'), 
        to_timestamp(concat(end_date,   ' ', end_time),   'yyyy.MM.dd HH:mm:ss')
    ) as duration_seconds,
    start_date,
    end_date,
    start_time,
    end_time,
    CASE
    WHEN white_result = 'win' THEN 'Win'
    WHEN white_result IN (
        'agreed', 
        'repetition', 
        'stalemate', 
        'insufficient', 
        '50move', 
        'timevsinsufficient'
    ) THEN 'Draw'
    ELSE 'Loss'
    END AS game_result_of_white,
    CASE
    WHEN black_result = 'win' THEN 'Win'
    WHEN black_result IN (
        'agreed', 
        'repetition', 
        'stalemate', 
        'insufficient', 
        '50move', 
        'timevsinsufficient'
    ) THEN 'Draw'
    ELSE 'Loss'
    END AS game_result_of_black,
    eco_code


from stage2_filtered_mod_cols