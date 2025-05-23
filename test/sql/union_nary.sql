\set ECHO none
\pset format unaligned
SET search_path TO provsql_test, provsql;

CREATE TABLE nested_union_result AS
SELECT *,formula(provenance(),'personnel_name') AS formula FROM (
  SELECT city FROM personnel WHERE classification != 'unclassified'
  UNION
  SELECT city FROM personnel WHERE position != 'Janitor'
  UNION
  SELECT city FROM personnel WHERE name LIKE '%n'
  UNION
  SELECT city FROM personnel WHERE position LIKE '%agent'
) t;

SELECT remove_provenance('nested_union_result');
SELECT * FROM nested_union_result ORDER BY city;
DROP TABLE nested_union_result;
