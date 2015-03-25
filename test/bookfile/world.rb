
package 'book-templates/world'
## use package or templates or  theme (instead of ???)
## will auto-include all helpers etc. from _scripts/ folder (hierachy/tree)


world adapter: 'sqlite3', database: './world.db'
## will connect to database;
## will require all libs
## will include all models


## page 'index', title: 'Contents',
##              id:    'index'   do |p|
##  p.write render_toc() ## render_toc( opts )
##  ## render :toc   -- auto includes opts???
## end

=begin
book do |b|
 
  puts "before first page"
 
  b.page 'index', title: 'Contents',
                  id:    'index'   do |p|
    puts "enter index"
    puts "leave index"
 end
end
=end


puts "self.class.name (in top level): #{self.class.name}"


book do |b|

  ## todo/fix:
  ##  find a way to pass along opts - why, why not??
  opts = {}

  puts "before first page"
  puts "self.class.name (in book block): #{self.class.name}"
 
  b.page 'index', title: 'Contents',
                  id:    'index'   do |page|
    puts "enter index"
    page.write "render_toc()" ## render_toc() ## render_toc( opts )
    page.write "render_toc() 2x"
    page.write "render_toc() 3x"

    page.render_toc( opts )
    ## render :toc   -- auto includes opts???

    puts "self.class.name (in page block): #{self.class.name}"
    page.write "continent.count: #{Continent.count}"
    puts "leave index"
  
   puts "continent.count: #{Continent.count}"
 end


  ### generate pages for countries
  # note: use same order as table of contents

  Continent.order(:id).each do |continent|
    continent.countries.order(:name).limit(1).each do |country|

      puts "build country page #{country.key}..."
      path = country.to_path
      puts "path=#{path}"
    
      b.page path, title: "#{country.name} (#{country.code})",
               id:    country.key do |page|
        page.write "render_country(#{country.name})"  ## render_country( country )  ## render_country( country, opts )
        page.render_country( country, opts )  ### fix: auto-include opts in render - how??
      end
    end
  end
end

