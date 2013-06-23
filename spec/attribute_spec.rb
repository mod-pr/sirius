require 'spec_helper'

class A
  extend Sirius::Attribute 
  
  int [:a, :b, :c]
  int [:d], 10
  str [:k], "foo"
  str [:z]
end

describe Sirius::Attribute do 
  
  it "generate correct attibutes" do 
    a = A.new
    a.a.should eq 0
    a.b.should eq 0
    a.c.should eq 0
    
    a.a = 10
    a.a.should eq 10

    a.k.should eq "foo"
    a.z.should eq ""
  end

end





   

