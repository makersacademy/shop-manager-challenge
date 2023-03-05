require_relative 'lib/shop_manager_challenge_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('shop_manager_challenge_test')

ShopManager.new.all.each do |tired|
  p tired 
end