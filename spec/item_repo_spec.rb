require_relative '../lib/item_repo'

def reset_books_table
  seed_sql = File.read('spec/shop_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemsRepository do
  before(:each) do 
    reset_books_table
  end

  it "lists all items with their name, quantity and price" do
    new_item_repo = ItemsRepository.new
    results = new_item_repo.all

    expect(results[0].id).to eq "1"
    expect(results[0].item_name).to eq "Cheese"
    expect(results[0].quantity).to eq "100"
    expect(results[0].unit_price).to eq "5"
  
    expect(results[1].id).to eq "2"
    expect(results[1].item_name).to eq "Milk"
    expect(results[1].quantity).to eq "50"
    expect(results[1].unit_price).to eq "3"
 
    expect(results[2].id).to eq "3"
    expect(results[2].item_name).to eq "Ham"
    expect(results[2].quantity).to eq "500"
    expect(results[2].unit_price).to eq "2"
  end

  it "takes a new item and adds it to the table" do
    new_item_repo = ItemsRepository.new
    new_item_repo.add("Fish", 10, 20)
    results = new_item_repo.all
    expect(results[-1].id).to eq "4"
    expect(results[-1].item_name).to eq "Fish"
    expect(results[-1].quantity).to eq "10"
    expect(results[-1].unit_price).to eq "20"
  end
end