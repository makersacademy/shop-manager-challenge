require "application"

RSpec.describe Application do
  describe "#run" do
    it "welcomes the user and prints out the options" do
      fake_io = double :fake_io
      expect(fake_io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(fake_io).to receive(:puts).with("What do you want to do?")
      expect(fake_io).to receive(:puts).with("  1 = list all shop items")
      expect(fake_io).to receive(:puts).with("  2 = create a new item")
      expect(fake_io).to receive(:puts).with("  3 = list all orders")
      expect(fake_io).to receive(:puts).with("  4 = create a new order")
      expect(fake_io).to receive(:puts).with("")

      app = Application.new(fake_io)
      app.run
    end

    # it "gets an option from the user" do
    #   fake_io = double :fake_io

    #   expect(fake_io)
    #   app = Application.new(fake_io)
    #   app.run
    # end
  end
end
