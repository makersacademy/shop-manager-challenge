class Order
  attr_accessor :id, :customer_name, :date_placed, :items_in_order 
  def initialize
    @items_in_order = []
  end

  def load_items_into_order_object
    sql = 'SELECT orders.id AS order_id, orders.customer_name, orders.date_placed, shop_items.id AS shop_item_id, shop_items.name, shop_items.unit_price, shop_items.quantity
          FROM orders
          JOIN shop_items_orders ON orders.id = shop_items_orders.order_id
          JOIN shop_items ON shop_items.id = shop_items_orders.shop_item_id
          WHERE orders.id = $1;'
    sql_params = [@id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    result_set.each do |record|
      @items_in_order << record_to_item_object(record)
    end
  end

  private 

  def record_to_item_object(record)
    item = ShopItem.new 
    item.id = record['shop_item_id']
    item.name = record['name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']

    return item
  end
end