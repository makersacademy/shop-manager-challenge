require "items_repository"

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemsRepository do
  before(:each) do 
    reset_items_table
  end

  it "Gets all items" do
    repo = ItemsRepository.new
    items = repo.all

    expect(items.length).to eq  2

    expect(items[0].id).to eq  ('1')
    expect(items[0].item_name).to eq  ('Apples')
    expect(items[0].price).to eq  ('0.99')
    expect(items[0].quantity).to eq  ('2')

    expect(items[1].id).to eq  ('2')
    expect(items[1].item_name).to eq  ('Pears')
    expect(items[1].price).to eq  ('0.45')
    expect(items[1].quantity).to eq  ('1')
  end

  it "Creates an item object" do
    repo = ItemsRepository.new

    item = Items.new
    item.item_name = "jamespates4"
    item.price = "What I had for supper"
    item.quantity = "false"

    repo.create(item)

    items = repo.all

    last_item = items.last
    expect(last_item.item_name).to eq ("jamespates4")
    expect(last_item.price).to eq ("What I had for supper")
    expect(last_item.quantity).to eq ("false")
  end
end
