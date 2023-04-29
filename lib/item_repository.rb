require_relative 'database_connection'
require_relative 'item'

class ItemRepository
  def initialize
    @items = []
  end

  def all
    sql = "SELECT id, name, unit_price, stock_quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])
    
    result_set.each do |record|
      @items << single_item(record)
    end
    return @items
  end

  private

  def single_item(record)
    item = Item.new
    item.id = record["id"]
    item.name = record["name"]
    item.unit_price = record["unit_price"]
    item.stock_quantity = record['stock_quantity']
    return item
  end

end
