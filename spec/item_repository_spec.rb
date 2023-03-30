require 'item_repository'

def reset_items_table
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_items.sql')
  connection.exec(seed_sql)
  seed_sql = File.read('spec/seeds_orders.sql')
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end
  let(:repo) { ItemRepository.new }

  context 'when checking db methods' do
    ### This section checks methods which communicate with the database ###
    it 'returns the list of all items in an array' do
      items = repo.all
      expect(items.length).to eq 11
      expect(items[0].name).to eq "Soap"
      expect(items[0].unit_price).to eq 10
      expect(items[-1].name).to eq "Chicken"
    end

    it 'adds a new item to database' do
      new_item = {name: 'Rice', unit_price: 9, quantity: 78}
      repo.add_item(new_item)
      items = repo.all
      expect(items.length).to eq 12
      ## Line below ensures we are adding new item to end of table
      expect(items[-2].name).to eq "Chicken"
      expect(items[-1].name).to eq 'Rice'
      expect(items[-1].id).to eq 12
      expect(items[-1].unit_price).to eq 9
      expect(items[-1].quantity).to eq 78
    end

    it 'deletes an item from database' do
      repo.delete_item(5)
      items = repo.all
      expect(items.length).to eq 10
      expect(items[-1].id).to eq 11
    end
  end

  context 'when reformatted' do
    ### This section checks methods which format object into strings ###
    it 'returns the list of all items and their prices in an array of strings' do
      items = repo.price_list
      expect(items.length).to eq 11
      expect(items[0]).to eq "Item: 1, Name: Soap, Price: 10"
      expect(items[-1]).to eq "Item: 11, Name: Chicken, Price: 18"
    end

    it 'returns the list of all items and their stock in an array of strings' do
      items = repo.inventory_stock_list
      expect(items.length).to eq 11
      expect(items[0]).to eq "Item: 1, Name: Soap, Quantity: 100"
      expect(items[-1]).to eq "Item: 11, Name: Chicken, Quantity: 40"
    end
  end
end