{% macro extract_pgn(column_name, tag) %}
    regexp_extract({{ column_name }}, '\\[{{ tag }} "(.*?)"\\]', 1)
{% endmacro %}