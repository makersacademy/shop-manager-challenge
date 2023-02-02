require_relative '../lib/order_repository'
require_relative 'reset_tables'

describe OrderRepository do
  before(:each) do
    reset_tables
  end

  describe "#all" do
    it "returns all records" do
      repo = OrderRepository.new

      expected = [
        have_attributes(id: 1, customer_name: 'Alice', date: '2023-01-29', item_id: 1),
        have_attributes(id: 2, customer_name: 'Bob', date: '2023-01-30', item_id: 2),
        have_attributes(id: 3, customer_name: 'Carry', date: '2023-01-31', item_id: 2),
        have_attributes(id: 4, customer_name: 'Dan', date: '2023-02-01', item_id: 1)
      ]

      expect(repo.all).to match_array(expected)
    end
  end

  describe "#create" do
    it "creates a record" do
      repo = OrderRepository.new
      new_order = Order.new(customer_name: 'Eve', date: '2023-02-02', item_id: 1)

      repo.create(new_order)

      expected = have_attributes(new_order.to_h.except(:id))

      expect(repo.all).to include(expected)
    end
  end
end
