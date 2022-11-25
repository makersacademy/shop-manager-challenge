require 'item_repository'

RSpec.describe ItemRepository do 

  def reset_items_table
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  describe ItemRepository do
    before(:each) do 
      reset_items_table
    end
  
    it 'Get all items' do

      repo = ItemRepository.new
      items = repo.all

      expect(items.length).to eq 4

      expect(items[0].id).to eq 1
      expect(items[0].name).to eq 'item 1'
      expect(items[0].unit_price).to eq "£1.11"
      expect(items[0].quantity).to eq 1

      expect(items[1].id).to eq 2
      expect(items[1].name).to eq 'item 2'
      expect(items[1].unit_price).to eq "£22.22"
      expect(items[1].quantity).to eq 22
  
    end

    xit 'Creates a new item' do

      repository = ItemRepository.new

      item = Item.new
      item.name = 'item 5'
      item.unit_price = 55555.55
      item.quantity = 5

      repository.create(item)

      all_items = repository.all
      last_item = all_items.last

      expect(last_item.name).to eq 'item 5'
      expect(last_item.unit_price).to eq 55555.55
      expect(last_item.quantity).to eq 5
    
    end

    xit 'Raises error when unit price is not money' do

      repository = ItemRepository.new

      item = Item.new
      item.name = 'item 5'
      item.unit_price = 'item 5'
      item.quantity = 5

      expect { repository.create(item) }.to raise_error "error"

    end

    xit 'Raises error when quanity is not int' do

      repository = ItemRepository.new

      item = Item.new
      item.name = 'item 5'
      item.unit_price = 55555.55
      item.quantity = 'item 5'

      expect { repository.create(item) }.to raise_error "error"

    end

    xit 'Raises error when name is not string' do

      repository = ItemRepository.new

      item = Item.new
      item.name = 55555.55
      item.unit_price = 55555.55
      item.quantity = 5

      expect { repository.create(item) }.to raise_error "error"

    end

  end

end