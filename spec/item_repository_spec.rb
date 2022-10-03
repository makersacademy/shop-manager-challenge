require './lib/item_repository.rb'

def reset_items_table
    seed_sql = File.read('spec/item_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
        
    before(:each) do 
        reset_items_table
    end
   
    it "lists shop items" do
        repo = ItemRepository.new
        items = repo.all
        p items
        expect(items.length).to eq(3)
        expect(items.first.name).to eq('Perfume')
        expect(items.first.unit_price).to eq('20')
        expect(items.first.quantity).to eq('15')
    end

    it "creates a shop item" do
        repository = ItemRepository.new
        item = Item.new
        item.name = 'Cherries'
        item.unit_price = "20"
        item.quantity = "30"

        repository.create(item)

        all_items = repository.all
	    last_items = all_items.last
	    expect(last_items.name ).to eq('Cherries')
	    expect(last_items.unit_price).to eq('20')
	    expect(last_items.quantity).to eq("30")

    end



end