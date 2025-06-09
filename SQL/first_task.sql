SELECT * FROM task.customers;
use task;


#list all customers and there cites
SELECT 
    CONCAT(first_name, ' ', last_name) AS customer_name, city
FROM
    customers;

#Display each order with customer full name, product name, and total price (qauntity*price)

SELECT 
   concat( customers.first_name,' ',customers.last_name) as full_name,
    products.product_name,
    (quantity * price) AS `total price`
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
        JOIN
    products ON orders.product_id = products.product_id;


#show all order placed in march
SELECT 
    *
FROM
    orders
WHERE
    MONTH(order_date) = 3;

#count how many times each product orders
SELECT 
    products.product_name, COUNT(orders.order_id) AS Total_order
FROM
    products
        JOIN
    orders ON products.product_id = orders.product_id
GROUP BY product_name;

#calculate total revenue genrated from each products
SELECT 
    products.product_name,
    SUM(orders.quantity * products.price) AS total_revenue
FROM
    orders
        JOIN
    products ON products.product_id = orders.product_id
GROUP BY products.product_name;



#Identify the customer who spent the most

SELECT 
    CONCAT(customers.first_name,
            ' ',
            customers.last_name) AS customer_name,
    SUM(orders.quantity * products.price) AS total_spent
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
        JOIN
    products ON products.product_id = orders.product_id
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 1;


# which city has highest average spending per customer

SELECT 
    customers.city,
    AVG(customer_spending.total_spent) AS avg_spending_per_customer
FROM customers
JOIN (
    SELECT 
        orders.customer_id,
        SUM(orders.quantity * products.price) AS total_spent
    FROM orders
    JOIN products ON orders.product_id = products.product_id
    GROUP BY orders.customer_id
) AS customer_spending ON customers.customer_id = customer_spending.customer_id
GROUP BY customers.city
ORDER BY avg_spending_per_customer DESC
LIMIT 1;






