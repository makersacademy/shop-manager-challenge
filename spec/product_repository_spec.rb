require "product_repository"

def reset_seeds_table  
  seeds_sql = File.read('spec/seeds.sql')
  connection = PG.connect({host: '127.0.0.1', dbname: 'shop_manager_test'})
  connection.exec(seeds_sql)
end

RSpec.describe ProductRepository do
  
  before(:each) do 
    reset_seeds_table 
  end  
  
  it "lists all the items in the shop with name, price, and quantity of stock available" do 

    repo = ProductRepository.new 
    products = repo.all 

    expect(products.length).to eq(5)
    expect(products[0].name).to eq("Super Shark Vacuum Cleaner")
    expect(products[1].unit_price).to eq("69")
    expect(products[2].quantity).to eq("10")
    expect(products[3].name).to eq("CannonBall Printer")

  end

  it "creates a new item in the inventory database" do 

    repo = ProductRepository.new

    new_item = Product.new
    new_item.name = "ClayStation 5"
    new_item.unit_price = "600"
    new_item.quantity = "52"

    repo.create(new_item)

    products = repo.all

    expect(products.length).to eq(6)
    expect(products.last.name).to eq("ClayStation 5")
    expect(products.last.unit_price).to eq("600")
    expect(products.last.quantity).to eq("52")

  end 




end   