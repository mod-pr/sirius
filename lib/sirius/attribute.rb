module Sirius
  #
  # === Macro
  # Generate attributes with default value.
  # And convert attribute to need type.
  # Because json return some values as String but it must be Integer.
  ##:method: +int+ as +attr_int+ 
  ##:method: +str+ as +attr_str+
  #
  # Get Array attributes and default value 
  # 
  # === Example
  #   class A
  #     extend Attribute
  #    
  #     int [:a, :b, :c] 
  #     int [:d], 10
  #     str [:k], "foo"   
  #    end
  #
  #    a = A.new
  #
  #    a.a # => 0 
  #    a.a = "10" 
  #    
  #    a.a # => 10
  #    a.a.class # => Fixnum
  # 
  #    a.k # => "foo"
  #    a.k = "bar"
  #    a.k # => "bar"
  #
  #
  module Attribute
    {:int => 0, :str => ""}.each do |k, v|
      method = "attr_#{k}"  
      
      define_method(method) do |attrs, default=v|
      attrs.each do |a|
          define_method("#{a}") do 
            instance_variable_get(:"@#{a}") || default  
          end
          define_method("#{a}=") do |new_attr|
            new_attr = new_attr.nil? ? default : new_attr.send("to_#{k[0]}") 
            instance_variable_set(:"@#{a}", new_attr)
          end   
        end
      end
      alias_method k, method
    end
  end
end
