require 'item_repository'

RSpec.describe ItemRepository do
  def reset_items_table 
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end  

  before(:each) do
    reset_items_table
  end
  
  context "With the All method" do
    it 'returns all the items in the database' do
      repo = ItemRepository.new

      items = repo.all

      expect(items.size).to eq 2
      expect(items.first.id).to eq '1'
      expect(items.first.name).to eq 'Super Shark Vacuum Cleaner'
      expect(items.first.unit_price).to eq '99'
      expect(items.first.stock_quantity).to eq '30'
    end
  end

  context "With the Find method" do
    it 'returns the items in the database with the corresponding id' do
      repo = ItemRepository.new
      item = repo.find(1)
    
      expect(item.id).to eq '1'
      expect(item.name).to eq 'Super Shark Vacuum Cleaner'
      expect(item.unit_price).to eq '99'
      expect(item.stock_quantity).to eq '30'
    end
  end

  context "With the Create method" do
    it 'returns the items in the database with the new item object added' do
      repo = ItemRepository.new

      add_item = Item.new
      add_item.name, add_item.unit_price, add_item.stock_quantity = 'Fight Milk', 19, 200

      repo.create(add_item)
      items = repo.all
      new_item = items.last

      expect(new_item.id).to eq '3'
      expect(new_item.name).to eq 'Fight Milk'
      expect(new_item.unit_price).to eq '19'
      expect(new_item.stock_quantity).to eq '200'
    end
  end

  context "With the Delete method" do
    it 'returns the items in the database with item object with the associated id input removed' do
      repo = ItemRepository.new
      repo.delete(1)
      items = repo.all
      first_item = items.first

      expect(first_item.id).to eq '2'
      expect(first_item.name).to eq 'Makerspresso Coffee Machine'
      expect(first_item.unit_price).to eq '69'
      expect(first_item.stock_quantity).to eq '15'
    end
  end

  context "With the Update method" do
    it 'returns the items in the database with item object updated' do
      repo = ItemRepository.new
      original_item = repo.find(1)

      original_item.name, original_item.unit_price, original_item.stock_quantity = 
        'New Hoover', 149, 100

      repo.update(original_item)
      updated_item = repo.find(1)

      expect(updated_item.id).to eq '1'
      expect(updated_item.name).to eq 'New Hoover'
      expect(updated_item.unit_price).to eq '149'
      expect(updated_item.stock_quantity).to eq '100'
    end
  end
end
