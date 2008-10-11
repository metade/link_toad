require File.join(File.dirname(__FILE__), 'spec_helper')

describe LinkToad do
  before(:each) do
    @toad = LinkToad.new({})
  end
  
  describe "extracting links" do
    describe "from an empty doc" do
      before(:each) do
        @toad.expects(:open).once.returns('')
      end
      
      it "should return an empty array of links" do
       @toad.send(:links_from_url, 'http://www.foo.com').should == []
      end
    end
    
    describe "from a page with one link" do
      before(:each) do
        @toad.expects(:open).once.returns('<a href="http://www.foo.com">foo</a>')
      end
      
      it "should return that link back" do
        @toad.send(:links_from_url, 'http://www.foo.com').should == [ 'http://www.foo.com' ]
      end
    end
  end
  
  describe "looking up gids for a uri" do
    before(:each) do
      @toad.mapping.merge!({
        'http://www.coldplay.com/' => 'cc197bad-dc9c-440d-a5b5-d52ba2e14234',
        'http://www.keanemusic.com/' => 'c7020c6d-cae9-4db3-92a7-e5c561cbad50',
        'http://www.gymclassheroes.com/' => 'f4d4b515-0b74-423f-a161-db184330c37c',
        'http://www.madonna.com/' => '79239441-bfd5-4981-a70c-55c3f15c1287',
        'http://www.oasisinet.com/' => '39ab1aed-75e0-4140-bd47-540276886b60',
        'http://adele.tv/' => 'cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493',
      })
    end
    
    it "should return Coldplay's GID with an exact URL match" do
      @toad.send(:hits_for_uri, 'http://www.coldplay.com/').should == ['cc197bad-dc9c-440d-a5b5-d52ba2e14234']
    end
    
    it "should return Coldplay's GID without the trailing slash" do
      @toad.send(:hits_for_uri, 'http://www.coldplay.com').should == ['cc197bad-dc9c-440d-a5b5-d52ba2e14234']
    end

    it "should return Coldplay's GID with an index.php URL" do
      @toad.send(:hits_for_uri, 'http://www.coldplay.com/index.php').should == ['cc197bad-dc9c-440d-a5b5-d52ba2e14234']      
    end
    
    it "should return Coldplay's GID with an index.php URL" do
      @toad.send(:hits_for_uri, 'http://www.coldplay.com/index.php').should == ['cc197bad-dc9c-440d-a5b5-d52ba2e14234']      
    end
    
    it "should return Oasis's GID with an index.aspx URL" do
      @toad.send(:hits_for_uri, 'http://www.oasisinet.com/index.aspx').should == ['39ab1aed-75e0-4140-bd47-540276886b60']      
      @toad.send(:hits_for_uri, 'http://www.oasisinet.com/Index.aspx').should == ['39ab1aed-75e0-4140-bd47-540276886b60']      
    end
    
    it "should return Madonna's GID with an exact URL match" do
      @toad.send(:hits_for_uri, 'http://www.madonna.com/').should == ['79239441-bfd5-4981-a70c-55c3f15c1287']      
    end
    
    it "should return Madonna's GID with URL omitting www." do
      @toad.send(:hits_for_uri, 'http://madonna.com').should == ['79239441-bfd5-4981-a70c-55c3f15c1287']
      @toad.send(:hits_for_uri, 'http://madonna.com/').should == ['79239441-bfd5-4981-a70c-55c3f15c1287']
    end
    
    it "should return Adele's GID with an exact URL match" do
      @toad.send(:hits_for_uri, 'http://adele.tv/').should == ['cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493']          
    end
    
    it "should return Adele's GID with URL omitting www." do
      @toad.send(:hits_for_uri, 'http://www.adele.tv').should == ['cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493']
      @toad.send(:hits_for_uri, 'http://www.adele.tv/').should == ['cc2c9c3c-b7bc-4b8b-84d8-4fbd8779e493']
    end
  end
end
