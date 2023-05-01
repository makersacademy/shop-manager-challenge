require 'item_repository'

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/item_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
  end

  it 'Should return all rows as an array of item objects when the all method is called' do
    repo = ItemRepository.new
    result = repo.all
    expect(result.length).to eq 3
    expect(result.first.id).to eq '1'
    expect(result.last.id).to eq '3'
    expect(result[1].item_name).to eq 'Lead-Pipe'
  end
end

describe ItemRepository do
  context 'Empty databse' do
    def reset_items_table
      seed_sql = File.read('spec/empty_seeds.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
      connection.exec(seed_sql)
    end

    before(:each) do
      reset_items_table
    end

    it 'Should return all rows as an array when the all method is called' do
      repo = ItemRepository.new
      expect(repo.all).to eq []
    end
  end
end
