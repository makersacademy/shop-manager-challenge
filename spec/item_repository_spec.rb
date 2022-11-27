require 'item_repository'
require 'item'

RSpec.describe 'item_repository' do

  def reset_items_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  describe ItemRepository do
    before(:each) do 
      reset_items_table
    end
  end

  it "returns all items" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.first.id).to eq "1"
    expect(items.length).to eq 5
    expect(items.first.item_name).to eq "Deepchord"
  end







end
