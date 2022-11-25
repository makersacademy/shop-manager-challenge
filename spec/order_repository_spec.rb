require "order_repository"

RSpec.describe OrderRepository do

  def reset_table
    seed_sql = File.read('spec/seeds.sql')

    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_challenge' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_table
  end


  it '' do
    # repo = PostRepository.new
    # posts = repo.all
    # expect(posts.length).to eq 7
    # expect(posts.first.title).to eq 'How to use Git'
    # expect(posts.last.title).to eq 'SQL basics'
  end


end
