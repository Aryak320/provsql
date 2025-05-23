\set ECHO none
\pset format unaligned
SET search_path TO provsql_test, provsql;

CREATE TABLE union_all_result AS
SELECT *,sr_formula(provenance(),'personnel_name') AS formula FROM (
  SELECT classification FROM personnel WHERE city='Paris'
  UNION ALL
  SELECT classification FROM personnel
) t;

SELECT remove_provenance('union_all_result');
SELECT * FROM union_all_result ORDER BY classification;
DROP TABLE union_all_result;

CREATE TABLE union_all_result AS
  SELECT * FROM personnel
  UNION ALL
  SELECT * FROM personnel;

SELECT remove_provenance('union_all_result');
SELECT * FROM union_all_result ORDER BY id;
DROP TABLE union_all_result;
