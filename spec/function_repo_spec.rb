require 'function_repo'

RSpec.describe FunctionRepo do
  before(:each) do
    reset_tables
  end

  it "returns a full list of all functions from shop_functions table" do
    repo = FunctionRepo.new

    functions = repo.all
    expect(functions.length).to eq 4
    expect(functions.first.function).to eq 'List all items.'
    expect(functions.last.function).to eq 'Create a new order.'
  end
end
