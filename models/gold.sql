select
    username,
    COUNT(*) AS total_games

FROM {{ ref('stage3_add_eco') }}
GROUP BY username