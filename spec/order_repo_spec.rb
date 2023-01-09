require_relative '../lib/order_repo'

def reset_books_table
  seed_sql = File.read('spec/shop_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrdersRepository do
  before(:each) do 
    reset_books_table
  end

  it "Lists all orders along with their name and date " do
    repo = OrdersRepository.new
    results = repo.all

    expect(results[0].id).to eq "1"
    expect(results[0].customer_name).to eq "Dave"
    expect(results[0].date).to eq "2022-01-01"
    expect(results[0].item_choice).to eq "1"

    expect(results[1].id).to eq "2"
    expect(results[1].customer_name).to eq "Helen"
    expect(results[1].date).to eq "2022-09-30"
    expect(results[1].item_choice).to eq "2"

    expect(results[2].id).to eq "3"
    expect(results[2].customer_name).to eq "Sam"
    expect(results[2].date).to eq "2022-12-25"
    expect(results[2].item_choice).to eq "3"
  end

  it "allows the user to create new orders" do
    repo = OrdersRepository.new
    repo.add("Adam", "2023-01-07", "1")
    results = repo.all

    expect(results[-1].id).to eq "4"
    expect(results[-1].customer_name).to eq "Adam"
    expect(results[-1].date).to eq "2023-01-07"
    expect(results[-1].item_choice).to eq "1"
  end
end 