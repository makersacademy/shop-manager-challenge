require 'Item_Repo'
require 'Item'

def reset_shop_table
    seed_sql = File.read('spec/seeds_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
 RSpec.describe Items_Repo do
    before(:each) do 
      reset_shop_table
    end
        it 'Should list all the items in the database' do
            repo = Items_Repo.new
            items = repo.all
            expect(items.length).to eq 2 
            expect(items[0].id.to_i).to eq 1
            expect(items[0].name).to eq "Toothpaste"
            expect(items[0].price).to eq "£3.40"
            expect(items[0].quantity.to_i).to eq 10
        end
        it 'Should create a new item in the database' do
            New_Item = Items.new
            repo = Items_Repo.new
            New_Item.name = 'Hand Wash'
            New_Item.price = '£2.00'
            New_Item.quantity = 20
            repo.create(New_Item)
            expect(repo.all.length).to eq 3
        end
    end
    
    
    