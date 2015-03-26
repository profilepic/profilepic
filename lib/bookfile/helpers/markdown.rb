# encoding: utf-8

module HybookHelper

###########################
# markdown helpers

###
#  fix: move to Markdown gem
#   add to new module
#  MarkdownHelper or Markdown::Helper ???


def link_to( title, link )
  "[#{title}](#{link})"
end


def columns_begin( opts={} )
  # note: will add  columns2 or columns3 etc. depending on columns option passed in

  ## note: default was 2 (columns) for world.db, 300 (px) for beer.db
  columns = opts[:columns] || 300

  "\n<div class='columns#{columns}' markdown='1'>\n\n"
end

def columns_end
  "\n</div>\n\n"
end

### todo: check if we can use columns simply w/ yield for body ??


end # module HybookHelper
