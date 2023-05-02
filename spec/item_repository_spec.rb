require "item_repository"

def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
    connection.exec(seed_sql)
end

RSpec.describe ItemRepository do

    before(:each) do
        reset_items_table
      end

  it "return all items" do 
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq(2) 
    expect(items.first.name).to eq("book")
  end 

    it "create a new item" do 
    repo = ItemRepository.new
    item = Item.new
    item.name = 'monitor'
    item.unit_price = '100'
    item.quantity = '50'
    expect(repo.create(item)).to eq(nil)
    repo.create(item)
    all_items = repo.all
    expect(all_items).to include(
        have_attributes(
            name: item.name,
            unit_price: "100", 
            quantity: "50"
        )
    )
end

end 

