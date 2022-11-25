require 'items_repository'

RSpec.describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
    before(:each) do
      reset_items_table
    end

  it "gets all of the items in the inventory" do
    repo = ItemRepository.new
    items = repo.all
    expect(items.length).to eq 5
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'ball'
    expect(items[0].price).to eq '10'
    expect(items[0].quantity).to eq '100'
    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'shoes'
    expect(items[1].price).to eq '50'
    expect(items[1].quantity).to eq '200'
  end

  it "finds a single item" do
    repo = ItemRepository.new
    items = repo.find(1)
    expect(items.id).to eq '1'
    expect(items.name).to eq 'ball'
    expect(items.price).to eq '10'
    expect(items.quantity).to eq '100'
  end 

  it "creates a new item" do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.name = 'hat'
    new_item.price = '15'
    new_item.quantity = '150'


    repo.create(new_item)
    items = repo.all
    last_item = items.last

    expect(last_item.name).to eq 'hat'
    expect(last_item.price).to eq '15'
    expect(last_item.quantity).to eq '150'
  end 
end 