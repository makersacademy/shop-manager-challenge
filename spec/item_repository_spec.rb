require 'item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test'})
  connection.exec(seed_sql)
end

describe ItemRepository do
  before :each do
    reset_tables
  end

  it "returns all items" do
    repo = ItemRepository.new
    result_set = repo.all
    expect(result_set.length).to eq 3
    expect(result_set.first.name).to eq "MacBookPro"
    expect(result_set.last.quantity).to eq 25
  end
end