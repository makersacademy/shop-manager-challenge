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

  it "creates a new shop item" do
    repo = ShopItemRepository.new
    shop_item = ShopItem.new
    shop_item.name = 'Dyson Airwrap'
    shop_item.unit_price = 300
    shop_item.quantity = 5
    repo.create(shop_item)

    expect(repo.all.length).to eq 3
    expect(repo.all.last.id).to eq '3'
    expect(repo.all.last.name).to eq 'Dyson Airwrap'
    expect(repo.all.last.unit_price).to eq '$300.00'
    expect(repo.all.last.quantity).to eq '5'
  end
end
