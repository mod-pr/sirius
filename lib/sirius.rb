require "sirius/version"
require "sirius/attribute"
require "sirius/boards"
require "sirius/post"
require "sirius/thread"

require "timeout"
require "json"
require "net/http"


##
# Top level module for Sirius
# 
# ==== Warning
# All methods throws Exception 
# * when page not found
# * when timeout error
# * when json parse error
# * otherwise?
#
# === Wow!
#
# Possible call methods for each board
# 
#
# === Example 
#
#    # Returns pages count
#    Sirius::PR::pages     # => 20
#    # Returns all threads
#    Sirius::PR::page      # => [<Thread>...<Thread>]
#    # Returns all posts from thread
#    Sirius::PR::thread(1) # => [<Post>...<Posts>] 
#

module Sirius
  extend self 

  #TODO Exceptions api

  ##
  # Default URL for request
  #
  URL  = "http://2ch.hk"

  ##
  # Default time for request
  #
  TIME = 4

  #
  # Get all threads from page.
  # Return Array of threads for +board+ from +page+.     
  # 
  # ==== Attributes
  # 
  # * +board+    - board for request  
  # * +page_num+ - page_num, default is `nil`[wakaba page or 0] 
  #
  # ==== Example
  #    # Return all threads from 0 page for `pr`
  #    Sirius::page('pr')   #=> [<Thread>...<Thread>]
  #    # For `b`, 1st page
  #    Sirius::page('b', 1) #=> [<Thread>...<Thread>]
  #
  # 
  def page(board, page_num = nil)
    get(board, page_num)[:threads].inject([]){|m, z| m << Thread.new(z.merge({:board => board})) }
  end
  
  #TODO
  #
  # #page should add in CACHE page count for board.
  # 
  
  #TODO
  # add #pages! method for get all pages from board
  # #pages get from CACHE
  # #pages! http-request for return page count.

  alias :threads :page

  #
  # Get all posts from thread
  # Return Array of posts
  # 
  # === Attributes
  # 
  # * +board+ - board  
  # * +num+ - num of thread
  #
  # === Example
  #    # Return all posts for 1st thread
  #    Sirius::thread('pr', 1)  #=> [<Post>...<Post>]
  #
  def thread(board, num)
    get("#{board}/res", num)[:thread].inject([]){|m, z| m << Thread.new({:board => board, :posts => [z]}) }
  end
  
  # 
  # Get count pages for +board+ 
  # Return Fixnum
  #
  # === Attributes
  # * +board+ - board for request
  #
  # === Example
  # 
  #   # Return pages count from `pr`
  #   Sirius::pages('pr')   #=> 20    
  #
  def pages(board)
    get(board, 1)[:pages].size
  end

  self::Boards::constants.each do |boards| 
    top = self
    self::Boards::const_get(boards).each do |board|
      self.const_set(board.upcase, Module.new {
          %w(pages page thread).each do |method|
            define_singleton_method(method) do |*args|
              top.send(method, *(args << board).reverse)
            end
          end 
        })  
    end 
  end
  
  private 

    def get(board, page_num='wakaba') #:nodoc:
      begin 
        page_num = page_num == 'wakaba' || page_num.nil? ? 'wakaba' : page_num.to_i
        url = URI("#{URL}/#{board}/#{page_num}.json")
        response = Timeout.timeout(TIME) do
          Net::HTTP.get_response(url)
        end
        JSON::parse(response.body, {:symbolize_names => true})
      rescue Exception => e 
        e
      end
    end
end
