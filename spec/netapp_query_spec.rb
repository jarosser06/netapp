require_relative '../lib/netapp'

class DummyClass
end

describe NetApp::Query do
  before :each do
    @dummy_class = DummyClass.new
    @dummy_class.extend(NetApp::Query) 
  end
end
