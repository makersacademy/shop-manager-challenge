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
end
