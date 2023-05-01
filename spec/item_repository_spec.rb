require 'item_repository'

def reset_shop_tables
  seed_sql = File.read('spec/seeds_shop_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do
    reset_shop_tables
  end

  it 'gets a list of all item objects' do
    repo = ItemRepository.new
    items = repo.all

    expect(items.length).to eq 2

    expect(items[0].id).to eq 1
    expect(items[0].name).to eq 'Hoover'
    expect(items[0].unit_price).to eq 99.99
    expect(items[0].quantity).to eq 20
  end

  it 'finds the first item when given an id of 1' do
    repo = ItemRepository.new
    item = repo.find(1)
    
    expect(item.id).to eq 1
    expect(item.name).to eq 'Hoover'
    expect(item.unit_price).to eq 99.99
    expect(item.quantity).to eq 20
  end

  it 'adds a new item to the database' do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Bike pump'
    item.unit_price = 20
    item.quantity = 3
    repo.create(item)

    items = repo.all

    expect(items).to include (
      have_attributes(
        name: 'Bike pump',
        unit_price: 20,
        quantity: 3
      )
    )
  end

  describe '#decrease_quantity' do
    it 'subtracts one from quantity of item with id 1' do
      repo = ItemRepository.new
      repo.update_quantity(1, -1)
      updated_item = repo.find(1)
      
      expect(updated_item.quantity).to eq 19
    end

    it 'subtracts five from quantity of item with id 1' do
      repo = ItemRepository.new
      repo.update_quantity(1, -5)
      updated_item = repo.find(1)
      
      expect(updated_item.quantity).to eq 15
    end

    it 'decreases quantity to zero when given an n value greater than current quantity' do
      repo = ItemRepository.new
      repo.update_quantity(1, -25)
      updated_item = repo.find(1)
      
      expect(updated_item.quantity).to eq 0
    end

    it 'adds to quantity of item with id 1' do
      repo = ItemRepository.new
      repo.update_quantity(1, 5)
      updated_item = repo.find(1)
      
      expect(updated_item.quantity).to eq 25
    end
  end
end
