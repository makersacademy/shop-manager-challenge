require 'items_repository'


RSpec.describe ItemsRepository do 

    def reset_table
        seed_sql = File.read('spec/seed_items.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_challenge_test', password: 'a' })
        connection.exec(seed_sql)
      end

      describe ItemsRepository do
        before(:each) do 
          reset_table
        end
        
        describe "all method" do 
          it "lists all items" do
            repo = ItemsRepository.new
            result=repo.all
            expect(result.first.id).to eq 1
            expect(result.first.name).to eq 'Basketball'
            expect(result.first.price).to eq 13.5
            expect(result.first.quantity).to eq 756

          end
        end





      end 
end 