class PrintItems

  def print_items(item_repository, io)
    io.puts "Here's a list of all shop items:"
    items = item_repository.all
    items.each { |item|
      io.puts "##{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
    }
  end

end