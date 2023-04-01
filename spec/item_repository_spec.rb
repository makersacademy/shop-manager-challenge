require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do
    reset_items_table
  end

  it "gets all items" do
    repo = ItemRepository.new

    items = repo.all

    expect(items.length).to eq 6
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'milk'
    expect(items[0].price).to eq '2'
    expect(items[0].quantity).to eq '50'
  end
end
