class OrderRepository

  def initialize(io)
    @io = io
  end

  def all

    orders = []
    sql = 'SELECT id, customer_name, date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|

      order = Order.new

      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id']

      orders << order

    end

    orders_list = []

    orders.each do |order|
       orders_list << "#{order.id} - #{order.customer_name} - #{order.date} - #{order.item_id}"
    end

    orders_list.each do |order|
      @io.puts order
    end
  end

  def create(order)
    sql = 'INSERT INTO orders (id, customer_name, date, item_id) VALUES ($1, $2, $3, $4);'
    sql_params = [order.id, order.customer_name, order.date, order.item_id]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

end

