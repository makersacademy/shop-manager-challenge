require 'items_repository'
require 'items'


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

        describe "create method" do
          it 'adds a new item' do
            fake_item = double :fake_item, name: "Football", price: 10, quantity: 120

            repo = ItemsRepository.new
            repo.create(fake_item)
            result = repo.all

            expect(result.last.name).to eq 'Football'
            expect(result.last.price).to eq 10
            expect(result.last.quantity).to eq 120
          end 
        end
      end 
end 