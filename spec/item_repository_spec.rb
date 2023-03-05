RSpec.describe ItemRepository do
    def reset_items_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'order_items_test' })
        connection.exec(seed_sql)
    end

    it '' do
        repo = ItemRepository.new
        items = repo.all
        expect(items.length).to eq ('4')
    end

end
#items.length # =>  4items.first.id # =>  1
#items.last.unit_price # =>  'David'
#items.first.quantity # =>  'April 2022'