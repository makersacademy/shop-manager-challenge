require 'shop_manager'

RSpec.describe ShopManager do
  describe '#create_item' do
    it 'creates a new item and adds it to the list of items' do
      shop_manager = ShopManager.new
      shop_manager.create_item('Item 1', 10.99, 5)

      expect(shop_manager.list_items).to eq("Name: Item 1 | Unit price: 10.99 | Quantity: 5\n")
    end
  end

  describe '#update_item_quantity' do
    xit 'updates the quantity of an existing item' do
      shop_manager = ShopManager.new
      item = Item.new('Item 1', 10.99, 5)
      shop_manager.create_item(item)

      shop_manager.update_item_quantity(item, 10)

      expect(shop_manager.list_items).to eq("Name: Item 1 | Unit price: 10.99 | Quantity: 10\n")
    end
  end

  describe '#create_order' do
    xit 'creates a new order and adds it to the list of orders' do
      shop_manager = ShopManager.new
      item = Item.new('Item 1', 10.99, 5)
      order = Order.new('John Doe', item, '01/01/2023')

      shop_manager.create_order(order)

      expect(shop_manager.list_orders).to eq("Customer name: John Doe | Item: Item 1 | Date: 01/01/2023\n")
    end
  end

  describe '#list_items' do
    xit 'lists all the items in the shop' do
      shop_manager = ShopManager.new
      item1 = Item.new('Item 1', 10.99, 5)
      item2 = Item.new('Item 2', 5.99, 10)
      shop_manager.create_item(item1)
      shop_manager.create_item(item2)

      expect(shop_manager.list_items).to eq("Name: Item 1 | Unit price: 10.99 | Quantity: 5\nName: Item 2 | Unit price: 5.99 | Quantity: 10\n")
    end
  end

  describe '#list_orders' do
    xit 'lists all the orders in the shop' do
      shop_manager = ShopManager.new
      item = Item.new('Item 1', 10.99, 5)
      order1 = Order.new('John Doe', item, '01/01/2023')
      order2 = Order.new('Jane Doe', item, '01/02/2023')
      shop_manager.create_order(order1)
      shop_manager.create_order(order2)

      expect(shop_manager.list_orders).to eq("Customer name: John Doe | Item: Item 1 | Date: 01/01/2023\nCustomer name: Jane Doe | Item: Item 1 | Date: 01/02/2023\n")
    end
  end
end


