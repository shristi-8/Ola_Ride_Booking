CREATE DATABASE ride_booking_analysis;
USE ride_booking_analysis;

-- 1. Total Records Check
SELECT COUNT(*) AS Total_Records
FROM ridebookings;

-- 2. Duplicate Booking IDs Check
SELECT `Booking ID`, COUNT(*)
FROM ridebookings
GROUP BY `Booking ID`
HAVING COUNT(*) > 1;

-- 3. Missing Values Check
SELECT
SUM(`Booking Value` IS NULL) AS Missing_Booking_Value,
SUM(`Ride Distance` IS NULL) AS Missing_Ride_Distance,
SUM(`Driver Ratings` IS NULL) AS Missing_Driver_Ratings,
SUM(`Customer Rating` IS NULL) AS Missing_Customer_Rating,
SUM(`Payment Method` IS NULL) AS Missing_Payment_Method;

-- 4. Booking Status Check
SELECT DISTINCT `Booking Status`
FROM ridebookings;

-- 5. Vehicle Types Check
SELECT DISTINCT `Vehicle Type`
FROM ridebookings;

-- 6. Payment Methods Check
SELECT DISTINCT `Payment Method`
FROM ridebookings;

-- 7. Date Format Check
SELECT MIN(`Date`) AS First_Date,
       MAX(`Date`) AS Last_Date
FROM ridebookings;

DESCRIBE ridebookings;

SHOW COLUMNS FROM ridebookings;

ALTER TABLE ridebookings
MODIFY COLUMN `Date` DATE,
MODIFY COLUMN `Time` TIME,
MODIFY COLUMN `Avg VTAT` DECIMAL(10,2),
MODIFY COLUMN `Avg CTAT` DECIMAL(10,2),
MODIFY COLUMN `Cancelled Rides by Customer` INT,
MODIFY COLUMN `Cancelled Rides by Driver` INT,
MODIFY COLUMN `Incomplete Rides` INT,
MODIFY COLUMN `Booking Value` DECIMAL(10,2),
MODIFY COLUMN `Ride Distance` DECIMAL(10,2),
MODIFY COLUMN `Driver Ratings` DECIMAL(3,2),
MODIFY COLUMN `Customer Rating` DECIMAL(3,2);

-- QUESTIONS:-

-- Q1. Total Number of Bookings
SELECT COUNT(*) AS Total_Bookings
FROM ridebookings;

-- Q2. Booking Status Distribution
SELECT `Booking Status`,
COUNT(*) AS Total_Bookings
FROM ridebookings
GROUP BY `Booking Status`
ORDER BY Total_Bookings DESC;

-- Q3. Total Revenue
SELECT ROUND(SUM(`Booking Value`),2) AS Total_Revenue
FROM ridebookings;

-- Q4. Average Booking Value
SELECT ROUND(AVG(`Booking Value`),2) AS Average_Booking_Value
FROM ridebookings;

-- Q5. Revenue by Vehicle Type
SELECT `Vehicle Type`,
ROUND(SUM(`Booking Value`),2) AS Revenue
FROM ridebookings
GROUP BY `Vehicle Type`
ORDER BY Revenue DESC;

-- Q6. Which vehicle type has the highest number of bookings?
SELECT `Vehicle Type`,
COUNT(*) AS Total_Bookings
FROM ridebookings
GROUP BY `Vehicle Type`
ORDER BY Total_Bookings DESC;

-- Q7. What is the average ride distance for each vehicle type?
SELECT `Vehicle Type`,
ROUND(AVG(`Ride Distance`),2) AS Avg_Ride_Distance
FROM ridebookings
GROUP BY `Vehicle Type`
ORDER BY Avg_Ride_Distance DESC;

-- Q8. Which payment method is used the most?
SELECT `Payment Method`,
COUNT(*) AS Total_Transactions
FROM ridebookings
GROUP BY `Payment Method`
ORDER BY Total_Transactions DESC;

-- Q9. What is the average customer rating for each vehicle type?
SELECT `Vehicle Type`,
ROUND(AVG(`Customer Rating`),2) AS Avg_Customer_Rating
FROM ridebookings
GROUP BY `Vehicle Type`
ORDER BY Avg_Customer_Rating DESC;

-- Q10. What is the average driver rating for each vehicle type?
SELECT `Vehicle Type`,
ROUND(AVG(`Driver Ratings`),2) AS Avg_Driver_Rating
FROM ridebookings
GROUP BY `Vehicle Type`
ORDER BY Avg_Driver_Rating DESC;

-- Q11. Top 10 Pickup Locations
SELECT
`Pickup Location`,
COUNT(*) AS Total_Bookings
FROM ridebookings
GROUP BY `Pickup Location`
ORDER BY Total_Bookings DESC
LIMIT 10;

-- Q12. Top 10 Drop Locations
SELECT
`Drop Location`,
COUNT(*) AS Total_Bookings
FROM ridebookings
GROUP BY `Drop Location`
ORDER BY Total_Bookings DESC
LIMIT 10;

-- Q13. Peak Booking Hours
SELECT
HOUR(`Time`) AS Booking_Hour,
COUNT(*) AS Total_Bookings
FROM ridebookings
GROUP BY Booking_Hour
ORDER BY Total_Bookings DESC;

-- Q14. Daily Revenue Trend
SELECT
`Date`,
ROUND(SUM(`Booking Value`),2) AS Revenue
FROM ridebookings
GROUP BY `Date`
ORDER BY `Date`;

-- Q15. Vehicle Types with Above Average Revenue (HAVING)
SELECT
`Vehicle Type`,
ROUND(SUM(`Booking Value`),2) AS Revenue
FROM ridebookings
GROUP BY `Vehicle Type`
HAVING Revenue >
(
SELECT AVG(vehicle_revenue)
FROM
(
SELECT SUM(`Booking Value`) AS vehicle_revenue
FROM ridebookings
GROUP BY `Vehicle Type`
) AS avg_table
);

-- Q16. Top 5 Customers by Total Spending
SELECT
`Customer ID`,
ROUND(SUM(`Booking Value`),2) AS Total_Spending
FROM ridebookings
GROUP BY `Customer ID`
ORDER BY Total_Spending DESC
LIMIT 5;

-- Q17. Average Revenue by Booking Status
SELECT
`Booking Status`,
ROUND(AVG(`Booking Value`),2) AS Avg_Revenue
FROM ridebookings
GROUP BY `Booking Status`;

-- Q18. Highest Rated Vehicle Type
SELECT
`Vehicle Type`,
ROUND(AVG(`Customer Rating`),2) AS Avg_Rating
FROM ridebookings
GROUP BY `Vehicle Type`
ORDER BY Avg_Rating DESC;

-- Q19. Vehicle Type Contribution to Revenue (%)
SELECT
`Vehicle Type`,
ROUND(SUM(`Booking Value`),2) AS Revenue,

ROUND(
SUM(`Booking Value`) * 100 /
(SELECT SUM(`Booking Value`) FROM ridebookings),
2
) AS Revenue_Percentage

FROM ridebookings

GROUP BY `Vehicle Type`

ORDER BY Revenue DESC;

-- Q20. Monthly Revenue Trend
SELECT

MONTH(`Date`) AS Month,

ROUND(SUM(`Booking Value`),2) AS Revenue

FROM ridebookings

GROUP BY Month

ORDER BY Month;










