require_relative 'lib/item_repository'

DatabaseConnection.connect('shop')

repo = ItemRepository.new

repo.all