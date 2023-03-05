shared_context "doubles setup" do

  let(:kernel) {spy(double :Kernel)}

  let(:itemRepo) { spy(double :ItemRepo) }
  let(:item1) { double :Item, id: 1, name: 'Xbox series X', price: 399, quantity: 20 }
  let(:item2) { double :Item, id: 2, name: 'Dell Monitor 4K', price: 499, quantity: 25 }
  let(:item3) { double :Item, id: 3, name: 'Macbook Air', price: 1249, quantity: 30 }
  let(:item4) { double :Item, id: 4, name: 'LG TV 4K', price: 119, quantity: 35 }
  let(:item5) { double :Item, id: 5, name: 'Ipad', price: 369, quantity: 40 }
  # New item
  let(:item6) { double :Item, id: 6, name: 'GoPro 11', price: 400, quantity: 45 }

  let(:orderRepo) { spy(double :orderRepo) }
  let(:order1) { double :Order, id: 1, date: '2023-03-01', customer: 'Jim', items: [item1, item4] }
  let(:order2) { double :Order, id: 2, date: '2023-02-01', customer: 'Tim', items: [item2, item3] }
  let(:order3) { double :Order, id: 3, date: '2023-01-01', customer: 'Kim', items: [item5, item3] }
  let(:order4) { double :Order, id: 4, date: '2022-12-01', customer: 'Lim', items: [item1, item2, item3, item4, item5] }
  let(:order5) { double :Order, id: 5, date: '2022-11-01', customer: 'Yim', items: [item5, item4, item1] }
  # New orders
  let(:order6) { double :Order, date: "2023-03-03", customer: "Pam", items: [item5] }
  let(:order7) { double :Order, date: "2023-03-02", customer: "Lam", items: [item2, item5, item3] }
end
