# file: spec/recipes_directory_repository_spec.rb
require "recipes_directory_repository"

RSpec.describe RecipeRepository do

  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_recipes_table
  end


  it "returns all recipes" do
    repo = RecipeRepository.new
    recipes = repo.all
  
    expect(recipes.length).to eq(2)
  
    expect(recipes[0].id).to eq('1')
    expect(recipes[0].name).to eq('Dumplings')
    expect(recipes[0].cooking_time).to eq('45')
    expect(recipes[0].rating).to eq('4')
  
    expect(recipes[1].id).to eq('2')
    expect(recipes[1].name).to eq('Duck Ragu')
    expect(recipes[1].cooking_time).to eq('120')
    expect(recipes[1].rating).to eq('5')
  end
  
  # 2
  # Get a single recipe
  
  it "returns single recipe" do
    repo = RecipeRepository.new
    recipes = repo.find(1)
  
    expect(recipes.id).to eq('1')
    expect(recipes.name).to eq('Dumplings')
    expect(recipes.cooking_time).to eq('45')
    expect(recipes.rating).to eq('4')
  end
end