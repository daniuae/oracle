-- Summary
-- SCD Type 0 → No change
-- SCD Type 1 → Overwrite (no history)
-- SCD Type 2 → New row for each change (full history)
-- SCD Type 3 → Keep only previous + current value
-- SCD Type 4 → Separate history table
-- SCD Type 6 → Hybrid of 1, 2, and 3
--
-- Assume staging table has new customer data
MERGE INTO Customer_Dim AS target
USING Customer_Staging AS source
ON target.Cust_ID = source.Cust_ID
WHEN MATCHED AND target.City <> source.City
THEN
  -- Expire old record
  UPDATE SET target.End_Date = CURRENT_DATE, target.Is_Current = 'N'
  -- Insert new record
  INSERT (Cust_ID, Name, City, Start_Date, End_Date, Is_Current)
  VALUES (source.Cust_ID, source.Name, source.City, CURRENT_DATE, NULL, 'Y')
WHEN NOT MATCHED
THEN
  -- Insert new customer
  INSERT (Cust_ID, Name, City, Start_Date, End_Date, Is_Current)
  VALUES (source.Cust_ID, source.Name, source.City, CURRENT_DATE, NULL, 'Y');
