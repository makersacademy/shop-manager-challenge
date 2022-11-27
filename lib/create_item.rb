class CreateItem

  def initialize(item_repository, io)
    @io = io
    @item_repository = item_repository
  end

  def create_item
    item = Item.new
    item.quantity = ""

    enter_name(item)
    enter_unit_price(item)
    enter_quantity(item)

    @item_repository.create(item)

    confirmation_message
  end

  private

  def enter_name(item)
    @io.puts "Enter Item name:"
    item.name = @io.gets.chomp
  end

  def enter_unit_price(item)
    item.unit_price = ""
    until item.unit_price.to_f.to_s == item.unit_price do
      @io.puts "Enter Unit Price:"
      item.unit_price = @io.gets.chomp
    end.to_f
  end

  def enter_quantity(item)
    item.quantity = ""
    until item.quantity.to_i.to_s == item.quantity do
      @io.puts "Enter Quantity:"
      item.quantity = @io.gets.chomp
    end.to_i
  end

  def confirmation_message
    added_item = @item_repository.all.last.name
    @io.puts "#{added_item} has been added"
  end
end