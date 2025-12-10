with stage1_extracted_cols as (
    select * from {{ ref('bronze') }}
)
SELECT
    *,
    white.username AS white_username,
    white.result AS white_result,
    black.username AS black_username,
    black.result AS black_result,
    {{ extract_pgn('pgn', 'StartTime') }} AS start_time,
    {{ extract_pgn('pgn', 'EndTime') }} AS end_time,
    {{ extract_pgn('pgn', 'ECO')}} AS eco_code,
    {{ extract_pgn('pgn', 'Date') }} AS start_date,
    {{ extract_pgn('pgn', 'EndDate') }} AS end_date,
    regexp_extract(eco, 'openings/(.*[a-zA-Z]{5})', 1) as opening_name

FROM stage1_extracted_cols