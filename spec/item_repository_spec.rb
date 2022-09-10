require 'item'
require 'item_repository'

RSpec.describe ItemRepository do
  def reset_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    user = ENV['PGUSER1'].to_s
    password = ENV['PGPASSWORD'].to_s
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager', user: user, password: password })

    connection.exec(seed_sql)
  end

  describe "temporary RSpec test" do
    it "" do
      repo = ItemRepository.new
      expect(repo.hi_rspec).to eq "Hi, RSpec!"
    end
  end
  
end