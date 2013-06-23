# Sirius

Wrap 2ch.hk api

## Installation

Add this line to your application's Gemfile:

    gem 'sirius'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sirius

## Usage


```ruby
Sirius::PR::pages #=> Return all threads from wakaba page
Sirius::PR::pages(2) #=> Return all threads from 2nd page
Sirius::PR::thread(1) #=> Return all posts from thread num 1.
Sirius::PR::pages #=> (20) Return page count
Sirius::pages('pr', 1) #=> Return all threads from wakaba page
Sirius::thread('pr', 1) #=> Return all posts from thread num 1.
Sirius::pages('pr') #=> Return page count

Sirius::PR::pages.first.load #=> Load all posts from 1st thread

#For more information => read code.
```

## TODO
 
    $ grep -r "TODO"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
