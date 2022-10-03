require_relative "../lib/item_repository.rb"

def reset_tables
  seed_sql = File.read('spec/orders_items_seeds.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: "shop_test", user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do
    reset_tables
  end

  let(:repo) {ItemRepository.new}

  it "Returns a list of Item objects" do
    items = repo.all
    expect(items.length).to eq 3
    expect(items.first.id).to eq "1"
  end

  it "Creates a new Item object" do
    item = Item.new
    item.name = 'LG Tumble Dryer'
    item.price = 770.00
    item.quantity = 2
    
    repo.create(item)
    items = repo.all

    expect(items).to include(
      have_attributes(
        name: 'LG Tumble Dryer',
        price: "$770.00",
        quantity: "2"
      )
    )
  end

  it "Returns an Item object of the specified id" do
    item = repo.find(1)
    expect(item.name).to eq 'Russell Hobbs Microwave'
    expect(item.id).to eq "1"
  end

  it "Updates an Item object with new values" do
    item = repo.find(1)
    item.quantity = item.quantity.to_i - 1
    repo.update(item)
    new_item = repo.find(1)
    expect(new_item.quantity).to eq "9"
    expect(new_item.name).to eq 'Russell Hobbs Microwave'
  end
end