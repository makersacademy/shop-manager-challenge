require 'application'


RSpec.describe Application do
  def reset_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test', user: user, password: password })

    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_tables
  end

  describe "#print_all_items" do
    it "prints all shop items" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("#1 - Item 1 - Price: 1 - Stock quantiy: 5")
      expect(io).to receive(:puts).with("#2 - Item 2 - Price: 2 - Stock quantiy: 10")
      app.print_all_items
    end
  end

  describe "#create_new_item" do
    it "creates a new shop item" do      
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      expect(io).to receive(:puts).with("Enter item name:")
      expect(io).to receive(:gets).and_return("Item 3")
      expect(io).to receive(:puts).with("Enter item price:")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("Enter item stock quantity:")
      expect(io).to receive(:gets).and_return("15")
      expect(io).to receive(:puts).with("Item created.")
      app.create_new_item
    end
  end

# describe "#print_all_items" do
#   it "prints items " do      
#     io = double :io
#     album_repo = ItemRepository.new
#     artist_repo = ArtistRepository.new
#     app = Application.new('shop_manager', io, item_repository, order_repository)
#     expect(io).to receive(:puts).with("1 - Bleach - 1989")
#     expect(io).to receive(:puts).with("2 - Hybrid Theory - 2000")
#     app.print_all_albums_with_year
#   end
# end

# describe "#run" do
#   context "when menu 1 is chosen" do
#     it "prints all albums" do
#       io = double :io
#       album_repo = ItemRepository.new
#       artist_repo = ArtistRepository.new
#       app = Application.new('shop_manager', io, item_repository, order_repository)
#       expect(io).to receive(:puts).with("Welcome to the music library manager!")
#       expect(io).to receive(:puts).with("What would you like to do?")
#       expect(io).to receive(:puts).with("1 - List all albums")
#       expect(io).to receive(:puts).with("2 - List all albums with release year")
#       expect(io).to receive(:puts).with("3 - List all artists")
#       expect(io).to receive(:puts).with("Enter your choice:")
#       expect(io).to receive(:gets).and_return("1")
#       expect(io).to receive(:puts).with("1 - Bleach")
#       expect(io).to receive(:puts).with("2 - Hybrid Theory")
#       app.run
#     end
#   end

#   context "when menu 2 is chosen" do
#     it "prints all albums with release year" do
#       io = double :io
#       album_repo = ItemRepository.new
#       artist_repo = ArtistRepository.new
#       app = Application.new('shop_manager', io, item_repository, order_repository)
#       expect(io).to receive(:puts).with("Welcome to the music library manager!")
#       expect(io).to receive(:puts).with("What would you like to do?")
#       expect(io).to receive(:puts).with("1 - List all albums")
#       expect(io).to receive(:puts).with("2 - List all albums with release year")
#       expect(io).to receive(:puts).with("3 - List all artists")
#       expect(io).to receive(:puts).with("Enter your choice:")
#       expect(io).to receive(:gets).and_return("2")
#       expect(io).to receive(:puts).with("1 - Bleach - 1989")
#       expect(io).to receive(:puts).with("2 - Hybrid Theory - 2000")
#       app.run
#     end
#   end

#   context "when menu 3 is chosen" do
#     it "prints all artists" do
#       io = double :io
#       album_repo = AlbumRepository.new
#       artist_repo = ArtistRepository.new
#       app = Application.new('shop_manager', io, item_repository, order_repository)
#       expect(io).to receive(:puts).with("Welcome to the music library manager!")
#       expect(io).to receive(:puts).with("What would you like to do?")
#       expect(io).to receive(:puts).with("1 - List all albums")
#       expect(io).to receive(:puts).with("2 - List all albums with release year")
#       expect(io).to receive(:puts).with("3 - List all artists")
#       expect(io).to receive(:puts).with("Enter your choice:")
#       expect(io).to receive(:gets).and_return("3")
#       expect(io).to receive(:puts).with("1 - Nirvana")
#       expect(io).to receive(:puts).with("2 - Linkin Park")
#       app.run
#     end
#   end
# end


end
