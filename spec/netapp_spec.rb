require_relative '../lib/netapp.rb'

describe NetApp do
  before :each do
    @netapp = NetApp.new("192.168.10.10")
    snmp_results = { :name => "/vol/test/", :used => 419430400, :free => 209715200, :total => 629145600 } 
    @netapp.stub(:fetch_vol) { snmp_results } 
    @netapp.stub(:fetch_vols) { {1 => "/aggr0", 2 => "/vol/test/"} }
  end
  
  describe "#new" do
    it "should create a new netapp object" do
      @netapp.class.should == NetApp
    end
  end

  describe "#host" do
    it "should return a the netapp host" do
      @netapp.host.should == "192.168.10.10"
    end
  end

  describe "#community" do
    it "should return the default community" do
      @netapp.community.should == "public"
    end
  end

  describe "#options" do
    it "should return an empty hash" do
      @netapp.options.should == {}
    end
  end

  describe "#volume" do
    it "should return a new volume object" do
      @netapp.volume("/vol/test/").class.should == NetApp::Volume
    end
    it "should have the volumes amount used" do
      @netapp.volume("/vol/test").used.should == 419430400
    end
  end

  describe "#volumes" do
    it "should return an array of volumes" do
      @netapp.volumes.class.should == Array
    end
  end

  describe "#uptime" do
    it "should return an uptime" do
      @netapp.stub(:fetch) { ["105 days"] }
      @netapp.uptime.should == "105 days"
    end
  end 

  describe "#nvram_battery_status" do
    it "should return the battery as ok" do
      @netapp.stub(:fetch) { ["1"] }   
      @netapp.nvram_battery_status.should == "ok"
    end
    it "should return the battery as partially discharged" do
      @netapp.stub(:fetch) { ["2"] }
      @netapp.nvram_battery_status.should == "partially discharged"
    end
    it "should return the battery as fully discharged" do
      @netapp.stub(:fetch) { ["3"] }
      @netapp.nvram_battery_status.should == "fully discharged"
    end
  end

  describe "#failed_disks" do
    it "should return the amount of disks have failed" do
      @netapp.stub(:fetch) { ["0"] }
      @netapp.failed_disks.should == 0
    end
  end

  describe "#failed_disks?" do
    it "should return true if there are failed disks" do
      @netapp.stub(:fetch) { ["1"] }
      @netapp.failed_disks?.should == true
    end
  end
  
  describe "#cache_age" do
    it "should return the cache age" do
      @netapp.stub(:fetch) { ["0"] }
      @netapp.cache_age.should == 0
    end
  end
  
  describe "#over_temperature?" do
    it "should return false if not over temp" do
      @netapp.stub(:fetch) { ["1"] }
      @netapp.over_temperature?.should == false
    end
  end

  describe "#failed_power_supplies" do
    it "should return the number of failed power supplies" do
      @netapp.stub(:fetch) { ["0"] }
      @netapp.failed_power_supplies.should == 0
    end
  end
  
  describe "#failed_power_supply?" do
    it "should return true if there is a failed power supply" do
      @netapp.stub(:fetch) { ["1"] }
      @netapp.failed_power_supply?.should == true
    end
  end
  
end
