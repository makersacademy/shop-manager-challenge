require 'item_repository'
require 'item'
require 'spec_helper'

describe ItemRepository do

  def reset_items_table
    seed_sql = File.read('spec/seeds_stock.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
  end

  it "puts a list of all items" do

    io = double :io

    expect(io).to receive(:puts).with("1 - Bag - £35.5 - 23")
    expect(io).to receive(:puts).with("2 - Lipstick - £15 - 49")
    expect(io).to receive(:puts).with("3 - Mascara - £18.4 - 4")

    repo = ItemRepository.new(io)
    repo.all

  end


  it "Adds an item to the database when the create method is used" do

    io = double :io

    expect(io).to receive(:puts).with("1 - Bag - £35.5 - 23")
    expect(io).to receive(:puts).with("2 - Lipstick - £15 - 49")
    expect(io).to receive(:puts).with("3 - Mascara - £18.4 - 4")
    expect(io).to receive(:puts).with("4 - Nail File - £1 - 21")

    repo = ItemRepository.new(io)
    item = Item.new

    item.id = 4
    item.name = 'Nail File'
    item.unit_price = 1
    item.quantity = 21

    repo.create(item)
    repo.all

  end

end
