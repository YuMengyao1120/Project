--What is the average amount of payment  of the customer orders in the month of April 2020?
SELECT AVG(PmtAmt) AS 'Avg.PmtAmt in Nov.2019'FROM Payment p INNER JOIN CustOrder co ON p.OrderID = co.OrderID 
WHERE DATEPART(month,OrderDateTime) = '11' AND DATEPART(YEAR,OrderDateTime) = '2019';
--Which order is completed by delivery riders in 2020 based on delivery date time? Please list all the details of this order.
--,CustID,OutletID,RiderID,VoucherID,OrderStatus,DeliveryAddress,OrderDateTime,DeliveryDateTime
SELECT co.OrderID, CustID,OutletID,RiderID,VoucherID,OrderStatus,DeliveryAddress,OrderDateTime,DeliveryDateTime FROM CustOrder co INNER JOIN Delivery d ON co.OrderID = d.OrderID
WHERE DATEPART(YEAR,DeliveryDateTime) = '2020' AND OrderStatus = 'Completed';
--How many outlets serve the Western food for customers ?
SELECT COUNT(DISTINCT(OutletID)) AS 'No. of Western Food Outlet' FROM OutletCuisine oc INNER JOIN Cuisine c ON oc.CuisineID = c.CuisineID 
WHERE CuisineName = 'Western';
--SELECT * FROM Rider