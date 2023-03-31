require 'item_repository'

def reset_all_tables
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_all.sql')
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_all_tables
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

    it 'retrieves the item id from item name' do
      expect(repo.retrieve_item_id_by_name("Bread")).to eq 8
    end

    it 'returns false if there is no such item in database' do
      expect(repo.retrieve_item_id_by_name("Blanket")).to eq false
    end

    it 'returns false if item quantity is 0 even if item exists' do
      expect(repo.retrieve_item_id_by_name("Cheese")).to eq false
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