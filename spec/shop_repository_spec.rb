require 'shop_repository'

RSpec.describe ShopRepository do
  def reset_shop_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_shop_table
  end

  it "returns list of all items for sale" do
    repo = ShopRepository.new
    item_list = repo.all_items
    output = []
    item_names = [
      "ChocoPop Cereal",
      "Zenith Smart Watch",
      "FrostyBites Ice Cream",
      "ThunderBolt Energy Drink",
      "ScentSation Perfume",
      "Glovolium",
      "Amplicord",
      "Luxifab",
      "Truscent",
      "Plasticoat"
    ]

    item_list.each { |item|
      output << item.name
    }

    expect(output.length).to eq 10
    expect(output).to eq item_names
  end

  it "shows single item's name, price, and qty" do
    repo = ShopRepository.new
    single_item = repo.single_item(2)

    expect(single_item.name).to eq "Zenith Smart Watch"
    expect(single_item.price).to eq 8999
    expect(single_item.qty).to eq 42
  end
end
