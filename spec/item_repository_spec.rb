require 'item_repository'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_shop_table
  end
end

RSpec.describe ItemRepository do
  it 'returns the list of all the items' do
    repo = ItemRepository.new

    items = repo.all 

    expect(items.length).to eq 5
    expect(items.first.id).to eq '1'
    expect(items.first.item_name).to eq "Sherbet Lemons"
  end
end
