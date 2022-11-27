class ItemRepository

  def initialize(io)
    @io = io
  end

  def all

    items = []
    sql = 'SELECT id, name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|

      item = Item.new

      item.id = record['id']
      item.name = record['name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']

      items << item

    end

    items_list = []

    items.each do |item|
       items_list << "#{item.id} - #{item.name} - £#{item.unit_price} - #{item.quantity}"
    end

    items_list.each do |item|
      @io.puts item
    end
  end

  def create(item)
    sql = 'INSERT INTO items (id, name, unit_price, quantity) VALUES ($1, $2, $3, $4);'
    sql_params = [item.id, item.name, item.unit_price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

end

