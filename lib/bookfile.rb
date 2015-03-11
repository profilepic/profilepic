# encoding: utf-8

#############
# stdlibs

require 'pp'
require 'ostruct'

##############
# 3rd party gems

require 'fetcher'
require 'zip'        # use $ gem install rubyzip
require 'hybook'     # todo/fix: check if hybook required/needed for now??

####################
# our own code

require 'bookfile/version'  # let it always go first

###
# helpers
# todo/fix: move helpers to hybook
require 'bookfile/helpers/markdown'   ## module HybookHelper
require 'bookfile/helpers/misc'       ## module HybookHelper


require 'bookfile/database/database'
require 'bookfile/package/package'
require 'bookfile/book/book'
require 'bookfile/bookfile'
require 'bookfile/builder'

