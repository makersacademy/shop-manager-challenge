require 'item'

RSpec.describe Item do
  describe '#out_of_stock' do
    it 'returns true when quantity 0' do
      item = Item.new
      item.quantity = 0

      expect(item.out_of_stock).to eq true
    end

    it 'returns false when quantity > 0' do
      item = Item.new
      item.quantity = 1

      expect(item.out_of_stock).to eq false
    end
  end
end