require 'rspec'
require_relative '../item_repository'
require_relative '../database_connection'


RSpec.describe ItemRepository do
  
  def reset_item_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_item_table
  end