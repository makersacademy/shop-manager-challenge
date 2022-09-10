# Improvement opportunities

10-Sep-2022 23:18:20
## Using item id in 'orders' table instead of item name (text)
- to allow for item id and order id to be linked (via join table) when an item is created
  - and then use a JOIN query to display item name where needed (e.g. when returning all orders)
- current OrderRepository#create_order method is very inefficient - a temporary fix!