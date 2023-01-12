require_relative 'lib/database_connection'

DatabaseConnection.connect('shop_manager') # This database needs to already been created by sql 

result = DatabaseConnection.exec_params(‘SELECT * FROM ;’, [])

result.each do |record|
    p record
end
