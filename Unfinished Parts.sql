-- return parts haven't finished yet
SELECT distinct part FROM parts_assembly
WHERE finish_date is NULL