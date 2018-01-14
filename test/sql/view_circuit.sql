\set ECHO none
SET search_path TO public, provsql;

CREATE TABLE vc_result AS
SELECT city, view_circuit(provenance(),'d') AS gates
FROM (
  SELECT DISTINCT city
  FROM personal
EXCEPT 
  SELECT p1.city
  FROM personal p1,personal p2
  WHERE p1.id<p2.id AND p1.city=p2.city
  GROUP BY p1.city
) t;

SELECT remove_provenance('vc_result');

SELECT city, gates FROM vc_result ORDER BY city;
DROP TABLE vc_result;
