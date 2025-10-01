SELECT TO_DATE('2023-10-01', 'YYYY-MM-DD') - TO_DATE('2023-09-25', 'YYYY-MM-DD') AS date_difference
FROM dual;

/* 
In Oracle SQL, date operations include 
adding, 
subtracting, 
comparing dates, and 
extracting parts of dates. Here are some common date operations with examples:

*/
* Get current date and time:  
  SELECT SYSDATE FROM dual; 
* Add days to a date (e.g., 7 days):  
  SELECT SYSDATE + 7 FROM dual; 
* Subtract two dates to get difference in days:  
  SELECT TO_DATE('2023-10-01', 'YYYY-MM-DD') - TO_DATE('2023-09-25', 'YYYY-MM-DD') AS diff_days FROM dual;  
* Get last day of the month for a date:  
  SELECT LAST_DAY(SYSDATE) FROM dual;  
* Get first day of the month:
  SELECT TRUNC(SYSDATE, 'MONTH') FROM dual;  
* Extract parts of the date (year, month, day): 
  
SELECT EXTRACT(YEAR FROM SYSDATE) AS year FROM dual;
SELECT EXTRACT(MONTH FROM SYSDATE) AS month FROM dual;
SELECT EXTRACT(DAY FROM SYSDATE) AS day FROM dual; 
* Add months to a date:  
SELECT ADD_MONTHS(SYSDATE, 3) FROM dual;
/*     
These operations allow flexible manipulation and querying of date and time data in Oracle SQL
*/
