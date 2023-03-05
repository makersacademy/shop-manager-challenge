class Menu
  def initialize(io)
    @io = io
  end

  def show_menu
    @io.puts('Welcome to the shop management program!')
    @io.puts('What do you want to do?')
    @io.puts('1 = list all shop items')
    @io.puts('2 = create a new item')
    @io.puts('3 = list all orders')
    @io.puts('4 = create a new order')
  end

  def get_result
    result = @io.gets.chomp
    fail 'Invalid number' if !['1', '2', '3', '4'].include?(result)
    return result
  end

end
