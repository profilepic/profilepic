# encoding: utf-8

#############
# stdlibs

require 'pp'
require 'ostruct'


##############
# 3rd party gems


#########################################
# "standalone" version - pull in hybook
#  - todo/check - possible to use bookfile w/o hybook?? why, why not??

=begin
unless defined?(Hybook)
  require 'logutils'    # uses Logging etc.    -- todo: get required by hybook - remove??
  require 'textutils'   # uses File.read_utf8   -- todo: get required by hybook - remove??
  require 'hybook'      # todo/fix: check if hybook required/needed for now??
end
=end
## else assumes hybook gem aready required (avoid circular require)


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
puts Bookfile.banner   if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
