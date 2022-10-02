require_relative "item_repository"

class Application
  def initialize(io)
    @io = io
  end

  def run
    @io.puts "Welcome to the shop management program!"
    @io.puts ""
    @io.puts "What do you want to do?"
    @io.puts "  1 = list all shop items"
    @io.puts "  2 = create a new item"
    @io.puts "  3 = list all orders"
    @io.puts "  4 = create a new order"
    choice = @io.gets
    
    case choice
    when "1"
      @io.puts "Here's a list of all shop items:"
      repo = ItemRepository.new
      items_list = repo.all_items
      items_list.each do |item|
        @io.puts "#{item.id} #{item.name} - Unit price: #{item.unit_price} - Quantity: #{item.quantity}"
      end
    end
    
    # when 2

    # when 3

    # when 4
  end
end

app = Application.new(Kernel)
app.run