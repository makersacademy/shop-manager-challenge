require 'orders_repository'

describe OrdersRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_directory_test' })
    connection.exec(seed_sql)
  end
  

  before(:each) do 
    reset_orders_table 
  end

  it 'returns the list of orders' do
		repo = OrdersRepository.new
		orders = repo.all
		expect(orders.length).to eq (1)
		expect(orders.first.id).to eq ('1')
		expect(orders.first.customer_name).to eq ('John')
		expect(orders.first.order_date).to eq ('2023-02-02')
		expect(orders.first.item_id).to eq ('1')
	end
    
	it 'returns a formatted output' do
		repo = OrdersRepository.new
		orders = repo.all
		expect(repo.order_made(orders)).to eq ('#1 John - Order date: 2023-02-02 - Item id: 1')
	end

	it 'returns the information of parameters in the find method' do
		repo = OrdersRepository.new
    selection = repo.find(1)
		expect(selection.customer_name).to eq ('John')
		expect(selection.order_date).to eq ('2023-02-02')
		expect(selection.item_id).to eq ('1')
	end

	it 'creates a new item and returns its details' do
		repo = OrdersRepository.new
		new_order = Orders.new
		new_order.customer_name = 'Mitch'
		new_order.order_date = ("2023-01-25")
		new_order.item_id = '2'
		repo.create(new_order)
		selection = repo.find(2)
		expect(selection.customer_name).to eq ('Mitch')
		expect(selection.order_date).to eq ("2023-01-25")
		expect(selection.item_id).to eq ('2')
	end
end