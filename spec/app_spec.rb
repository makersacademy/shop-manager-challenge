require_relative "../app"

def reset_items_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end
RSpec.describe Application do 
  before(:each) do 
    reset_items_items_table
  end
  it "returns all items when input chooses 1 for items" do
    fake_items_repo = double(:fake_items_repo)
    fake_orders_repo = double(:fake_orders_repo)
    kernel = double(:kernel)
    item = double :item
    expect(kernel).to receive(:print).with("Welcome to the shop management program!\n")
    expect(kernel).to receive(:print).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 =list all orders\n4 = create a new order\n")
    expect(kernel).to receive(:gets).and_return("1\n")
    expect(kernel).to receive(:print).with("_________________________________________\n")   
    expect(kernel).to receive(:print).with("| item ID | item NAME | Price | Quantity |\n") 
     expect(kernel).to receive(:print).with("_________________________________________\n") 
    expect(fake_items_repo).to receive(:all).and_return(item)
    expect(item).to receive(:each).and_return("| 1       | GOLD WATCH   £3350   5      ")
    app = Application.new('shop_manager_test',kernel, fake_orders_repo, fake_items_repo )
    app.run
  end
  xit "returns all artists when input chooses 2 for artist" do
    fake_album_repo = double(:fake_album_repo)
    fake_artist_repo = double(:fake_album_repo)
    kernel = double(:kernel)
    artist = double :artist
    expect(kernel).to receive(:puts).with("Welcome to the music library manager!")
    expect(kernel).to receive(:puts).with("What would you like to do?")
    expect(kernel).to receive(:puts).with("1 - List all albums")
    expect(kernel).to receive(:puts).with("2 - List all artists")   
    expect(kernel).to receive(:puts).with("[ENTER]") 
    expect(kernel).to receive(:gets).and_return("2\n") 
    expect(fake_artist_repo).to receive(:all).and_return(artist)
    expect(artist).to receive(:each).and_return(artist)
    app = Application.new('music_libary',kernel, fake_album_repo, fake_artist_repo )
    app.run
  end
end 