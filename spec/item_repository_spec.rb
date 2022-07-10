require 'item_repository'

RSpec.describe ItemRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds_shop.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end
  


    # (your tests will go here).

    # it 'returns all users' do
    #     repo = UserRepository.new 
    #     users = repo.all
    #     expect(users.length).to eq(3)
    #     expect(users[0].id).to eq('1')
    #     expect(users[0].email).to eq('test1@email.com')
    #     expect(users[0].username).to eq('username1')
    # end

  it 'returns all items' do
      repo = ItemRepository.new
      items = repo.all
      expect(items.length).to eq(3)
      expect(items[0].id).to eq('1')
      expect(items[0].item).to eq('item1')
      expect(items[0].price).to eq('1')
      expect(items[0].quantity).to eq('1')
  end

  # it 'returns a single item' do
  #     repo = ItemRepository.new
  #     item = repo.find(1)
  #     expect(item.id).to eq(1)
  #     expect(item.item).to eq('item1')
  #     expect(item.price).to eq('1')
  #     expect(item.quantity).to eq('1')
  # end

  it 'creates a new item' do
      repo = ItemRepository.new
      new_item = Item.new
      new_item.id = 4
      new_item.item = 'item4'
      new_item.price = '4'
      new_item.quantity = '4'

      expect(new_item.id).to eq(4)
      expect(new_item.item).to eq('item4')
      expect(new_item.price).to eq('4')
      expect(new_item.quantity).to eq('4')
  end





end