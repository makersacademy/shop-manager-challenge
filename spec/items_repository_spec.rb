require 'items_repository'

describe ItemsRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_directory_test' })
    connection.exec(seed_sql)
  end
  

  before(:each) do 
    reset_items_table 
  end

  it 'returns the list of Items' do
		repo = ItemsRepository.new
		items = repo.all
		expect(items.length).to eq (2)
		expect(items.first.id).to eq ('1')
		expect(items.first.name).to eq ('Chocolate')
		expect(items.first.unit_price).to eq ('3')
		expect(items.first.quantity).to eq ('6')
	end

	it 'returns a formatted output' do
		repo = ItemsRepository.new
		items = repo.all
		expect(repo.stock(items)).to eq ('#1 Chocolate - Unit price: 3 - Quantity: 6')
	end

	it 'returns the information of parameters in the find method' do
		repo = ItemsRepository.new
    selection = repo.find(1)
		expect(selection.name).to eq 'Chocolate'
		expect(selection.unit_price).to eq '3'
		expect(selection.quantity).to eq '6'
	end

	it 'creates a new item and returns its name' do
		repo = ItemsRepository.new
		new_item = Items.new
		new_item.name = 'Vacuum'
		new_item.unit_price = '99'
		new_item.quantity = '3'
		repo.create(new_item)
		selection = repo.find(3)
		expect(selection.name).to eq ('Vacuum')
		expect(selection.unit_price).to eq ('99')
		expect(selection.quantity).to eq ('3')
	end
end