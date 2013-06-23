module Sirius
  #
  # All posts from threads maps on this class
  #
  #
  class Post
    extend Sirius::Attribute
    int %w(width lasthit num banned size timestamp)
    int %w(sticky tn_width tn_height closed)
    int %w(parent height op)
    str %w(thumbnail video image comment subject name date)
    
    class << self
      def parse(json) #:nodoc: 
        i = self.new
        json.each do |key, value|
          i.send("#{key}=", value)
        end
        i
      end
    end
  end
end