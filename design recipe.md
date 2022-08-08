1. Design and create a table

shop items - name (text), unit price (int), quanitity (int), order_id (int), .create method

orders - customer_name(text), date_order_placed (date), shop_item_id (int), .create method


2. Create Test SQL seeds

Examples: 

TRUNCATE TABLE shopinventories, orders, shopinventories_orders RESTART IDENTITY;

INSERT INTO shopinventories (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);  --1
INSERT INTO shopinventories (name, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);  --2

INSERT INTO orders (customer_name, date_order_placed) VALUES ('John', '2022-07-01');  --1
INSERT INTO orders (customer_name, date_order_placed) VALUES ('Alice', '2022-07-30');  --2

INSERT INTO shopinventories_orders (shopinventory_id, order_id) VALUES (1, 1);


3. Define the class names

class ShopInventory

end

class Order

end

class ShopInventoryRepository

end

class OrderRepository

end


4. Implement the model classes

class ShopInventory

attr_accessor :id, :name, :unit_price, :quantity

end

class Order

attr_accessor :id, :customer_name, :date_order_placed

end



5. Define the repository interface

6. Write tests for them

7. Reload SQL seeds before each test runs

8. Test drive and implement the repository classes