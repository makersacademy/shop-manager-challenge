class PrintItems

  def initialize(item_repository, io)
    @io = io
    @item_repository = item_repository
  end

  def print_items
    @io.puts "Here's a list of all shop items:"
    items = @item_repository.all
    print_items_formatter(items)
  end

  private
  
  def print_items_formatter(items)
    items.each { |item|
    @io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    }
  end

end