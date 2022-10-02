class Greeter
  def initialize(io)
    @io = io
  end

  def greet
    @io.puts "Welcome to the shop management program!

    What function would you like to do?

      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"

    name = @io.gets.chomp
      # while name != 1, 2, 3 ,4
    if name == 1
      @io.puts ItemRepository.all
    elsif name == 2
      @io.puts ItemRepository.create
    elsif name == 3
      @io.puts OrderRepository.all
    elsif name == 4
      @io.puts OrderRepository.create
    else @io.puts "Sorry, please pick one of the above options!"
    end

  end
end

# If we want to run `Greeter` for real, we do it like this
# greeter = Greeter.new(Kernel)
# greeter.greet