require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe AWeber::Collection do
  
  before :each do
    @oauth  = AWeber::OAuth.new("token", "secret")
    @aweber = AWeber::Base.new(@oauth)
    path    = File.dirname(__FILE__) + "/fixtures/lists_page_1.json"
    data    = JSON.parse File.read(File.expand_path(path))
    @lists  = AWeber::Collection.new(@aweber, AWeber::Resources::List, data)
  end
  
  it "should create classes from the one passed into initialize" do
    @lists[876].should be_an AWeber::Resources::List
  end
  
  it "should be iterable" do
    @lists.should respond_to :each
    @lists.map { |id, l| id }.should be_an Array
  end
  
  it "should be accessible via id in normal Hash form" do
    @lists[2].id.should == 2
  end
  
  it "should retrieve more resources, if needed, when being iterated over" do
    list_ids = @lists.map{ |id, list| list }
    list_ids.length.should == 24
    list_ids.all? { |e| e.is_a? AWeber::Resources::List }.should == true
  end
  
  it "should return single entries with dynamic find_by methods" do
    @lists.find_by_id(876).should be_an AWeber::Resources::List
    @lists.find_by_id(876).id.should == 876
  end
  
  it "should return Hashes of entries when find_by methods match many" do
    lists = @lists.find_by_resource_type_link("https://api.aweber.com/1.0/#list")
    lists.length.should == 24
  end
end
