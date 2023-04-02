require 'item_repository'

describe ItemRepository do 
  def reset_all_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  def reset_empty_table
    seed_sql = File.read('spec/seeds_empty.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_all_table()
  end

  it "should return name and price" do 
    item_repo = ItemRepository.new 
    result = item_repo.all 
    item_1 = Item.new(1,'Ray-Ban Sunglasses', 80.00, 100)
    item_2 = Item.new(2,'Tefal set pans', 150.00, 9)
    item_3 = Item.new(3,'Super Shark Vacuum Cleane', 99.00, 30)
    item_4 = Item.new(4,'Makerspresso Coffee Machine', 69.00, 15)

    expect(result).to eq [item_1, item_2, item_3, item_4]

  end

  it "should return quantity" do 
    item_repo = ItemRepository.new 
    result = item_repo.all 
    item_1 = Item.new(1,'Ray-Ban Sunglasses', 80.00, 100)
    item_2 = Item.new(2, 'Tefal set pans', 150.00, 9)

    expect(result[0].quantity).to eq 100
    expect(result[1].quantity).to eq 9

  end

  it "should return an empty array" do 
    reset_empty_table()
    item_repo = ItemRepository.new 
    result = item_repo.all 
  
    expect(result).to eq []

  end

  it "should create a new item" do 
    item_repo = ItemRepository.new 

    item_5 = Item.new(nil, 'Blender', 90.00, 70)

    item_repo.create(item_5)
    result = item_repo.all[-1]

    expect(result.name).to eq 'Blender'
    expect(result.price).to eq 90.00
    expect(result.quantity).to eq 70

  end

  it "should have stock available" do
    item_repo = ItemRepository.new 
    result = item_repo.has_stock(1)
    expect(result).to eq true
  end


  it "should not have stock available" do
    item_repo = ItemRepository.new 

    item_5 = Item.new(nil, 'Blender', 90.00, 0)

    item_repo.create(item_5)
    last_item = item_repo.all[-1]

    result = item_repo.has_stock(last_item.id)
    expect(result).to eq false
  end

end