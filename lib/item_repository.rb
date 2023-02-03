require_relative './item'

class ItemRepository
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity'].to_i

      items << item
    end

    return items
  end

  def create(item)
    # Check if the item name is already added in the database
    check_sql = 'SELECT name FROM items WHERE name = $1;'
    result_set = DatabaseConnection.exec_params(check_sql,[item.name])
    result_set.each {|result| fail 'Item is already created' unless result.nil?}

    #Check input
    if item.name == '' || item.price <= 0 || item.quantity <= 0
      fail 'Invalid inputs'
    end

    # If no error, add to the database
    sql = 'INSERT INTO items (name,price,quantity) VALUES ($1,$2,$3);'
    params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end
