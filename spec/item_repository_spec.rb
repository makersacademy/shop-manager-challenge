require 'item_repository'


def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  describe '#all' do
    it 'returns an array of item objects for each record on items table' do

    repo = ItemRepository.new

    items = repo.all

    expect(items.first.id).to eq 1
    expect(items.first.name).to eq 'item one'
    expect(items.first.price).to eq 1
    expect(items.first.quantity).to eq 1

    expect(items.last.id).to eq 5
    expect(items.last.name).to eq 'item five'
    expect(items.last.price).to eq 5
    expect(items.last.quantity).to eq 5
    end
  end
end