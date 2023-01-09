require "item_repository"

describe ItemRepository do
  
  before(:all) do
    @repo = ItemRepository.new
    @item1 = Item.new([1, "Super Shark Vacuum Cleaner",
    99.99, 3])
    @item2 = Item.new([2, "Makerspresso Coffee Machine",
    69.5, 5])
    @item3 = Item.new([3, 'ThomasTech Wireless Charger',
    11.39, 1])
  end

  after(:each) do
    reset_query = File.read("spec/data_seeds.sql")
    connection = PG.connect({ host: '127.0.0.1', 
    dbname: "shop_manager_test" })
    connection.exec(reset_query)
  end

  it "#all returns array of item objects for all items in database" do
    expect(@repo.all).to eq [@item1, @item2, @item3]
  end

  it "#create takes item instance and inserts into database" do
    new_item = Item.new([4, "item", 1.0, 20])
    @repo.create(new_item)
    expect(@repo.all).to eq [@item1, @item2, @item3, new_item]
  end

end
