require_relative '../lib/netapp.rb'

describe NetApp::Volume do
  before :each do
    @volume = NetApp::Volume.new("test_vol", 419430400, 209715200, 629145600)
  end

  describe "#new" do
    it "creates a new volume object" do
      @volume.class.should == NetApp::Volume
    end
  end

  describe "#name" do
    it "returns the name of the volume" do
      @volume.name.should == "test_vol" 
    end
  end
  
  describe "#used" do
    it "returns the amount of amount used by the volume" do
      @volume.used.should == 419430400
    end
  end

  describe "#free" do
    it "returns the amount free in the volume" do
      @volume.free.should == 209715200 
    end
  end

  describe "#total" do
    it "returns the total amount of storage in the volume" do
      @volume.total.should == 629145600
    end
  end

  describe "#percentage_used" do
    it "returns the percentage of storage used" do
      @volume.percentage_used.should == 66.667 
    end
  end

  describe "#to_u" do
    it "returns the unit conversion of a value" do
      @volume.total.to_u == 600  
    end
  end
end
