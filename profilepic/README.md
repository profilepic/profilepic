#  Profile Pic(ture) As A Service


* home  :: [github.com/profilepic/profilepic](https://github.com/profilepic/profilepic)
* bugs  :: [github.com/profilepic/profilepic/issues](https://github.com/profilepic/profilepic/issues)
* gem   :: [rubygems.org/gems/profilepic](https://rubygems.org/gems/profilepic)
* rdoc  :: [rubydoc.info/gems/profilepic](http://rubydoc.info/gems/profilepic)



## Command-Line Tool 

Use the command line tool named - surprise, surpirse - `profilepic`
to run a zero-config / out-of-the-box profile pic(ture) as a service.  Type:

    $ profilepic

That will start-up a (local loopback) web server / service running on port 3000.  
Open-up up the index page in your browser to get started e.g. <http://localhost:3000/>. 

That's it. 






## Usage in Your Scripts And/Or (Web) Apps

Yes, you can. The [`ProfilepicService` class](lib/profilepic/service.rb) is a "plain-vanilla" rack (web) app  (powered by the [sinatra gem / library](https://github.com/sinatra/sinatra)). To run the app "standalone" use:

``` ruby
require 'profilepic'

# start-up the ProfilepicService (rack) app, that is, the profile pic(ure) as a service,
#   using the WEBrick server running on port 3000 using the local loopback host e.g. 127.0.0.1     
Rack::Handler::WEBrick.run ProfilepicService, :Port => 3000, :Host => '127.0.0.1'
```

Or mount the rack (web) app in your own scripts or web framework/library of choice.



## Install

Just install the gem:

    $ gem install profilepic



## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?


Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

