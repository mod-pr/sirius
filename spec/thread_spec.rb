require 'spec_helper'

describe Sirius::Thread do 
  let(:t){Sirius::Thread}
  
  it "create new thread from json" do 
    a = t.new({:image_count => 1})  
    a.image_count.should eq 1
  end
  
end