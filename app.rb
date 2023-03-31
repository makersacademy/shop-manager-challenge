Dir["./lib/*.rb"].each {|file| require file}

app = Application.new(
  'items_orders',
  Kernel,
  ItemRepository.new,
  OrderRepository.new
)
app.run