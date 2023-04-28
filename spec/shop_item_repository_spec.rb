require 'shop_item_repository'

describe ShopItemRepository do
  def reset_shop_items_table
    seed_sql = File.read('spec/seeds_shop_manager_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_shop_items_table
  end

  it "returns a list of all shop items" do
    repo = ShopItemRepository.new

    shop_items = repo.all

    expect(shop_items.length).to eq 2
    expect(shop_items.first.name).to eq 'Super Shark Vacuum Cleaner'
    expect(shop_items.first.unit_price).to eq '$99.99'
    expect(shop_items.first.quantity).to eq '30'
  end
end