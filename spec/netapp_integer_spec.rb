require_relative '../lib/netapp'

describe "::Integer" do
  describe "#to_u" do
    it "should return a value conversion" do
      50000032432.to_u(:GB).should == 47683 
    end
  end  

  describe "#to_h" do
    it "should return a human readable string" do
      50000032432.to_h(:GB).should == "47683 GB"
    end
  end
end
