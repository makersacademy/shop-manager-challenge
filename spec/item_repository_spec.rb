require "item_repository"

describe ItemRepository do
  def reset_tables
    seeds_sql = File.read("seeds/seeds_items_orders.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test" })
    connection.exec(seeds_sql)
  end

  before(:each) do
    reset_tables
    @repo = ItemRepository.new
  end

  context "#all" do
    it "returns a list of Item objects" do
      items = @repo.all
      expect(items.length).to eq 5
      expect(items.first.name).to eq "Garlic Pasta Sauce"
      expect(items.last.name).to eq "Rump Steak"
    end
  end

  context "#create_item" do
    it "creates a new item" do
      @repo.create_item("washing powder", 4.55, 25)
      item = @repo.all.last
      expect(item.id).to eq 6
      expect(item.name).to eq "washing powder"
      expect(item.unit_price).to eq 4.55
      expect(item.quantity).to eq 25
    end
  end

  context "#update_stock" do
    it "adds stock of an item" do
      @repo.update_stock(1, 20, "+")

      item = @repo.all.first
      expect(item.id).to eq 1
      expect(item.name).to eq "Garlic Pasta Sauce"
      expect(item.unit_price).to eq 1.5
      expect(item.quantity).to eq 50
    end

    it "takes stock from an item" do
      @repo.update_stock(1, 5, "-")

      item = @repo.all.first
      expect(item.id).to eq 1
      expect(item.name).to eq "Garlic Pasta Sauce"
      expect(item.unit_price).to eq 1.5
      expect(item.quantity).to eq 25
    end
  end

  context "#update_price" do
    it "updates an item's price from items table" do
      @repo.update_price(1, 2.5)

      item = @repo.all.first
      expect(item.id).to eq 1
      expect(item.name).to eq "Garlic Pasta Sauce"
      expect(item.unit_price).to eq 2.5
      expect(item.quantity).to eq 30
    end
  end

  context "#remove_item" do
    it "deletes an item from items table" do
      @repo.remove_item(1)

      item = @repo.all.first
      expect(item.id).to eq 2
      expect(item.name).to eq "Shower Gel"
      expect(item.unit_price).to eq 2
      expect(item.quantity).to eq 55
    end
  end

  context "#is_enough_stock?" do
    it "returns true if the num <= quantity" do
      expect(@repo.enough_stock?(5, 10)).to be false
      expect(@repo.enough_stock?(1, 30)).to be true
    end
  end

  context "#is_exist?" do
    it "returns error message when no record is found" do
      expect { @repo.remove_item(23) }.to raise_error "Invalid id. Please enter again."
      expect { @repo.update_stock(35, 1, "+") }.to raise_error "Invalid id. Please enter again."
      expect { @repo.update_price(-2, 2) }.to raise_error "Invalid id. Please enter again."
      expect { @repo.enough_stock?(33, 50) }.to raise_error "Invalid id. Please enter again."
    end
  end
end
