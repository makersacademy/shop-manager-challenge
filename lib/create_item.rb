class CreateItem
  def create_item(item_repository, io)
    item = Item.new
    item.quantity = ""
    item.unit_price = ""

    io.puts "Enter Item name:"
    item.name = io.gets.chomp

    until item.unit_price.to_f.to_s == item.unit_price do
      io.puts "Enter Unit Price:"
      item.unit_price = io.gets.chomp
    end.to_f
  
    until item.quantity.to_i.to_s == item.quantity do
      io.puts "Enter Quantity:"
      item.quantity = io.gets.chomp
    end.to_i

    item_repository.create(item)
    added_item = item_repository.all.last.name
    
    io.puts "#{added_item} has been added"
  end
end