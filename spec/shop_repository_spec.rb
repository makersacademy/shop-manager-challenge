require 'item_repository'

def reset_table
  seed_sql = File.read('spec/seeds_cohort_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do
    @repo = ItemRepository.new
    reset_table
  end

  it 'returns all shop items' do
    expect(@repo.all_items.length).to eq 3
    expect(@repo.all_items[0].name).to eq 'Pickles'
  end

  it 'adds a new user' do
    @repo.add_item('Popcorn', '5', '5')
    expect(@repo.all_items.length).to eq 4
    expect(@repo.all_items[-1].name).to eq 'Popcorn'
  end

  it 'list all orders' do
    expect(@repo.all_orders.length).to eq 3
    expect(@repo.all_orders[0].cust_name).to eq 'Thomas'
    expect(@repo.all_orders[0].product_name).to eq 'Cucumber'
  end

  it 'creates a new order' do
    @repo.add_order('Timmy', 'Cucumber', '3', '2010-10-10')
    expect(@repo.all_orders.length).to eq 4
    expect(@repo.all_orders[-1].product_name).to eq 'Cucumber'
  end
end

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order
