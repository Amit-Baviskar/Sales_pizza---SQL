CREATE DATABASE pizzahut;
USE pizzahut;

CREATE TABLE Orders(
Order_id INT NOT NULL,
PRIMARY KEY (Order_id),
Order_date date NOT NULL,
Order_time time NOT NULL
);



## Retrieve the total number of orders placed.

SELECT COUNT(*) As Total_number_of_order_placed
 FROM Orders;


## Calculate the total revenue generated from pizza sales.

SELECT round(SUM(order_details.quantity*pizzas.price),2) AS TOTAL_REVENUE
  FROM order_details 
      JOIN pizzas
  ON order_details.pizza_id=pizzas.pizza_id;
 

## Identify the highest-priced pizza.

SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

## Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(od.order_details_id) AS COUNT_Details_id
FROM
    pizzas p
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY COUNT_Details_id DESC;


## List the top 5 most ordered pizza types along with their quantities.

SELECT 
    order_details.pizza_id,
    pizza_types.name,
    SUM(order_details.quantity) AS Total_quantity_sold,
    pizzas.size
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY order_details.pizza_id , pizza_types.name , pizzas.size
ORDER BY Total_quantity_sold DESC
LIMIT 5;
 
 
## Join the necessary tables to find the total quantity of each pizza category ordered.
 
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS Total_quantity_sold
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_quantity_sold DESC
LIMIT 5; 
 

## Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(Order_time) AS HOUR, COUNT(order_id)
FROM
    orders
GROUP BY HOUR
ORDER BY HOUR ASC; 

## Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Total_quantity_sold
FROM
    pizza_types
        JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_quantity_sold DESC;
  
   
## Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
      orders.Order_date, round(AVG(order_id),2) AS AVERAGE
FROM
    orders
GROUP BY DATE(Order_date) 
ORDER BY AVERAGE ASC;



