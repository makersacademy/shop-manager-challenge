require 'item_repository'

describe ItemRepository do 

  def reset_table
    items_seed_sql = File.read('spec/seeds_items.sql')
    orders_seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_database' })
    [items_seed_sql, orders_seed_sql].each do |seed_sql|
      connection.exec(seed_sql)
    end
  end

  before(:each) do
    reset_table
  end

  context '#all' do 
    it 'returns a list of all items' do 
    
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 3

      expect(items[0].id).to eq '1'
      expect(items[0].name).to eq 'B1 Pencils'
      expect(items[0].unit_price).to eq '£0.70'
      expect(items[0].stock_count).to eq '506'

      expect(items[2].id).to eq '3'
      expect(items[2].name).to eq 'Blue Biros'
      expect(items[2].unit_price).to eq '£1.00'
      expect(items[2].stock_count).to eq '325'
    end 
  end 

  context '#find' do 
    it 'returns one record' do 

    repo = ItemRepository.new

    item = repo.find(2)

    expect(item.id).to eq '2'
    expect(item.name).to eq 'A5 Notebooks'
    expect(item.unit_price).to eq '£4.75'
    expect(item.stock_count).to eq '156'
    end 
  end 


  context '#delete' do 
    it 'deletes first record' do 

    repo = ItemRepository.new

    repo.delete(1)

    all_items = repo.all
    expect(all_items.length).to eq 2
    expect(all_items.first.id).to eq '2'
    expect(all_items.first.name).to eq 'A5 Notebooks'
    expect(all_items.first.unit_price).to eq '£4.75'
    expect(all_items.first.stock_count).to eq '156'
    end
  end 

  context '#create' do 
    it 'created new record' do 
      
      repo = ItemRepository.new
      
      new_item = Item.new
      new_item.name = 'Pritt Stick'
      new_item.unit_price = '£3.50'
      new_item.stock_count = '76'
      
      repo.create(new_item)
      
      all_items = repo.all
      expect(all_items.last.id).to eq '4'
      expect(all_items.last.name).to eq 'Pritt Stick'
      expect(all_items.last.unit_price).to eq '£3.50'
      expect(all_items.last.stock_count).to eq '76'
      expect(all_items.length).to eq 4
    end 
  end 

end
