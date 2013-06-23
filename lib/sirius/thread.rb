module Sirius  
  #
  # All threads from request maps on this class
  #
  #
  class Thread
    include Enumerable
    
    attr_accessor :image_count, :omitimages, :omit, :board, :reply_count, :posts
    #
    # Get Hash{:image_count => "10" ...}  and generate attributes
    #
    def initialize(json)
      json.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def posts=(json) #:nodoc:
      @posts = []
      json.map{|_| _.first}.each do |post|
        @posts << Post.parse(post)
      end
    end


    #
    # Load thread
    # 
    # === Summary
    # When you get all threads from page, you take only limit posts from thread, but with this method you can load all posts for thread.
    #   
    # === Example
    #    Api::PR::page.first.size # => 6 
    #    # But with `load`
    #    Api::PR::page.first.load.size # => 100  
    #
    def load
      Api::thread(board, posts.first.num)
    end

    #TODO
    # add +more+ method = for ajax loading posts from thread
    # alias :moar :more

    alias :load! :load

    def each(&block) #:nodoc:
      posts.each(&block)
    end

    alias :size :count
  end
end