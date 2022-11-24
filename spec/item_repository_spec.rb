require 'item_repository'

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end
  def reset_orders_items_table
    seed_sql = File.read('spec/seeds_orders_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'orders_items_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
    reset_orders_table
    reset_orders_items_table
  end

  context 'all method' do
    it 'returns an array of all items' do
      repo = ItemRepository.new
      all_items = repo.all
      first_item = all_items.first
      last_item = all_items.last
      expect(all_items.length).to eq 4
      expect(first_item.id).to eq '1'
      expect(first_item.name).to eq 'Socks'
      expect(first_item.unit_price).to eq '2.75'
      expect(first_item.quantity).to eq '100'
      expect(last_item.id).to eq '4'
      expect(last_item.name).to eq 'Shoes'
      expect(last_item.unit_price).to eq '45.00'
      expect(last_item.quantity).to eq '30'
    end
  end
end