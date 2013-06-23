require 'spec_helper'

describe Sirius::Post do 
  let(:json){{:width => "0", :closed => "0", :video => "" }}
  it "parse create new post from json" do
    z = Sirius::Post.parse(json)  
    z.class.should eq Sirius::Post
    z.closed.should eq 0
    z.width.should eq 0
    z.video.should eq ""
  end
end
