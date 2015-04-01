require 'hoe'
require './lib/bookfile/version.rb'

Hoe.spec 'bookfile' do

  self.version = Bookfile::VERSION

  self.summary = 'bookfile - builder for books'
  self.description = summary

  self.urls    = ['https://github.com/hybook/bookfile']

  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.licenses = ['Public Domain']

  self.extra_deps = [
    ['props'],         # settings / prop(ertie)s / env / INI
    ['logutils'],     # logging
    ['textutils'],    # e.g.  >= 0.6 && <= 1.0  ## will include logutils, props
    ['fetcher'],   ## todo: check if included in ??
    ['rubyzip'],   ## todo: check if included in ??
    ### ['hybook']     ## avoid circular dependency - do NOT include
  ]

  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end

