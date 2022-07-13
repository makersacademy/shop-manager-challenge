require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_data.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end


describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  it "returns all items" do
    repo = ItemRepository.new
    stock = repo.all
    expect(stock.length).to eq 5

    expect(stock[0].id).to eq 1
    expect(stock[0].name).to eq 'milk'
    expect(stock[0].unit_price).to eq '$1.00'
    expect(stock[0].quantity).to eq 35

    expect(stock[3].id).to eq 4
    expect(stock[3].name).to eq '6 eggs'
    expect(stock[3].unit_price).to eq '$2.33'
    expect(stock[3].quantity).to eq 28
  end

  it "return an Item object by its id" do
    repo = ItemRepository.new
    item = repo.find(1)

    expect(item.id).to eq 1
    expect(item.name).to eq 'milk'
    expect(item.unit_price).to eq "$1.00"
    expect(item.quantity).to eq 35
  end

  it "returns nil if the Item with given index does not exist" do
    repo = ItemRepository.new
    item = repo.find(199)
    expect(item).to eq nil
  end

  it "creates an Item object" do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.name = 'minced beef'
    new_item.unit_price = 3.99
    new_item.quantity = 15
    repo.create(new_item)
    stock = repo.all
    expect(stock.length).to eq 6
    expect(stock).to include(
      have_attributes(name: 'minced beef', unit_price: "$3.99", quantity: 15)
    )
  end

  context "when looking for an Item with orders data by item's ID" do
    it "returns an Item with associated orders" do
      repo = ItemRepository.new
      item = repo.find_with_orders(1)
      expect(item.name).to eq('milk')
      expect(item.orders.length).to eq(3)
    end

    it "returns nil if the Item with given index does not exist" do
      repo = ItemRepository.new
      item = repo.find_with_orders(199)
      expect(item).to eq nil
    end
  end
end