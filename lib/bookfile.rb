# encoding: utf-8

#############
# stdlibs

require 'pp'
require 'ostruct'


##############
# 3rd party gems

require 'hybook'

require 'fetcher'
require 'zip'        # use $ gem install rubyzip


####################
# our own code

require 'bookfile/version'  # let it always go first

require 'bookfile/database/database'
require 'bookfile/package/package'
require 'bookfile/book/config'
require 'bookfile/book/book'
require 'bookfile/bookfile'
require 'bookfile/builder'



# say hello
puts Bookfile.banner   if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
