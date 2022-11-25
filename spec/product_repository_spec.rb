  require 'product_repository'

  def reset_products_table
    seed_sql = File.read('spec/seeds_products.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe ProductRepository do
    before(:each) do 
      reset_products_table
    end
    
    it 'returns all products' do
      repo = ProductRepository.new
      products = repo.all
      
      expect(products.length).to eq 2
      
      expect(products[0].name).to eq 'PS5'
      expect(products[0].unit_price).to eq '350'
      expect(products[0].quantity).to eq '2'
      expect(products[1].name).to eq 'XBOX'
      expect(products[1].unit_price).to eq '275'
      expect(products[1].quantity).to eq '10'
    end
    
    it 'creates a new product' do
      repo = ProductRepository.new

      new_product = Product.new
      new_product.name = 'NINTENDO SWITCH'
      new_product.unit_price = '300'
      new_product.quantity = '25'
      repo.create(new_product)
      
      products = repo.all
      expect(products.length).to eq 3
      expect(products[2].name).to eq 'NINTENDO SWITCH'
      expect(products[2].unit_price).to eq '300'
      expect(products[2].quantity).to eq '25'
    end

    it 'deletes a product by id' do

      repo = ProductRepository.new 
      repo.delete(1)
      products = repo.all
      expect(products.length).to eq 1
      expect(products[0].name).to eq 'XBOX'

    end

    it 'finds a specfic product' do
      repo = ProductRepository.new
      product = repo.find(2)

      expect(product.name).to eq 'XBOX'
      expect(product.unit_price).to eq '275'
      expect(product.quantity).to eq '10'
    end
  end