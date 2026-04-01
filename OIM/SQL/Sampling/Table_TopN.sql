-- Purpose : Quick TOP-N row sample of any OIM table
-- Tables  : <replace TableName>
-- Notes   : Safe read-only. Replace TableName and row count as needed.
-- Source  : Standard pattern

SELECT TOP 100 * FROM <TableName> WITH (NOLOCK) ORDER BY (SELECT NULL);
