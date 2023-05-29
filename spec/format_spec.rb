require 'format'

RSpec.describe Format do
  
  let(:formatter) { Format.new }
  
  describe "#currency" do
    it "returns a formatted currency string" do
      # formatter = Format.new
      expect(formatter.currency(4.75)).to eq "£4.75"
      expect(formatter.currency(3)).to eq "£3.00"
      expect(formatter.currency(25.1)).to eq "£25.10"
    end
  end
  
  describe "#header" do
    it "returns a header string" do
      expect(formatter.header("TEST HEADER")).to eq "\e[0;31;49m====== TEST HEADER ======\e[0m"
    end
  end
end
