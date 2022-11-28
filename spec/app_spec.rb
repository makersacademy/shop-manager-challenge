require_relative "../app"

RSpec.describe ItemRepository do
    def reset_app_table
      seed_sql = File.read("spec/seeds_app.sql")
      connection = PG.connect({ host: "127.0.0.1", dbname: "shop_manager_test"})
      connection.exec(seed_sql)
    end
  
    before(:each) do
      reset_app_table
    end

    let(:io) {double :io}
    let(:app) {Application.new('shop_app_test', io, ItemRepository.new, OrderRepository.new)}

    xit "prints list of all shop items " do
    
        expect(io).to receive(:puts).with("\nHere's a list of all shop items:")
        expect(io).to receive(:puts).with("#1 - Dyson Vaccum - Unit Price: $319.00 - Quantity: 10")
        expect(io).to receive(:puts).with("#2 - Fitbit Sense 2 - Unit Price: $90.00 - Quantity: 30")
        expect(io).to receive(:puts).with("#3 - Galaxy Tab A8 - Unit Price: $179.00 - Quantity: 15")
        expect(io).to receive(:puts).with("#4 - Tefal Air Fryer - Unit Price: $99.00 - Quantity: 21")
        expect(io).to receive(:puts).with("#5 - Nutribullet - Unit Price: $29.00 - Quantity: 10")
        expect(io).to receive(:puts).with("#6 - Oral B CrossAction Toothbrush - Unit Price: $24.00 - Quantity: 52")
        expect(io).to receive(:puts).with("#7 - LG 4K Ultra HD TV - Unit Price: $1,999.00 - Quantity: 9")

        app.print_items
      end
    end