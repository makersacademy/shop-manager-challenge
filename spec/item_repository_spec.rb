require 'item_repository'

RSpec.describe ItemRepository do
  def reset_orders_table
    seed_sql = File.read('spec/items_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end
  
  it "returns the lists of the records" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 3

    expect(items.first.id).to eq "1"
    expect(items.first.name).to eq "Black Trousers"
    expect(items.first.unit_price).to eq "30"
    expect(items.first.quantity).to eq "52"
  end
end