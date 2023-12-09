CREATE TABLE Customers (
    Customer_ID TEXT PRIMARY KEY,
    Name TEXT,
    Segment TEXT,
    City TEXT,
    State TEXT,
    Region TEXT
);
CREATE TABLE Orders (
    Order_ID INTEGER PRIMARY KEY NOT NULL,
    Order_Date DATE,
    Ship_Date DATE,
    Year_Order DATE,
    Ship_Mode TEXT,
    Customer_ID TEXT REFERENCES Customers(Customer_ID)
);
CREATE TABLE Sales (
    Product_ID TEXT,
    Category TEXT,
    Sub_Category TEXT,
    Product_Name TEXT,
    Sales_Value INTEGER,
    Quantity INTEGER,
    Discount DECIMAL(31),
    Profit INTEGER,
    Order_Code INTEGER REFERENCES Orders(Order_ID),
    Customer_ID TEXT REFERENCES Customers(Customer_ID)
);
SELECT * FROM Customers LIMIT 10;
SELECT * FROM Orders LIMIT 10;
SELECT * FROM Sales LIMIT 10;

-- Query to calculate the total sales
SELECT SUM(Sales_Value) AS Total_Sales FROM Sales;

-- Query to calculate total sales for each category
SELECT Category, SUM(Sales_Value) AS Total_Sales_By_Category
FROM Sales
GROUP BY Category;

-- Query to calculate the maximum and minimum Sales Value
SELECT MAX(Sales_Value) AS Maximum_Sales_Value, 
       MIN(Sales_Value) AS Minimum_Sales_Value 
FROM Sales;

-- Query to calculate the Total Profit for each category
SELECT Category, SUM(Profit) AS Total_Profit_By_Category
FROM Sales
GROUP BY Category;

-- Query to calculate the Average Discount for each Subcategory
SELECT Sub_Category, AVG(Discount) AS Average_Discount
FROM Sales
GROUP BY Sub_Category;

-- Query to list the top 3 Subcategories with the highest average discount values
SELECT Sub_Category, AVG(Discount) AS Average_Discount
FROM Sales
GROUP BY Sub_Category
ORDER BY Average_Discount DESC
LIMIT 3;

-- Query to show all regions and their total sales and determine which region has higher sales
SELECT c.Region, SUM(s.Sales_Value) AS Total_Sales_By_Region
FROM Sales s
INNER JOIN Customers c ON s.Customer_ID = c.Customer_ID
GROUP BY c.Region
ORDER BY Total_Sales_By_Region DESC;

-- Query to find the Category, Subcategory, and Product name for a specific Order_ID
SELECT s.Category, s.Sub_Category, s.Product_Name
FROM Sales s
JOIN Orders o ON s.Order_Code = o.Order_ID
WHERE o.Order_ID = 117121; -- Replace with the actual Order_ID you are interested in

-- Query to find the subcategory that sells the most
SELECT Sub_Category, SUM(Sales_Value) AS Total_Sales
FROM Sales
GROUP BY Sub_Category
ORDER BY Total_Sales DESC
LIMIT 1;



-- Query to calculate the total number of orders by year 
SELECT Year_Order AS Year, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Year_Order
ORDER BY Year_Order;

-- Query to list the top 10 customers who purchased more furniture
SELECT Sales.Customer_ID, Customers.State, SUM(Sales.Sales_Value) AS Total_Furniture_Sales
FROM Sales
JOIN Customers ON Sales.Customer_ID = Customers.Customer_ID
WHERE Sales.Category = 'Furniture'
GROUP BY Sales.Customer_ID, Customers.State
ORDER BY Total_Furniture_Sales DESC
LIMIT 10;




