require 'rubygems'
require 'open-uri'
require 'time'
require 'yaml'
require 'to_slug'



config = YAML.load_file('_config.yml')
gal = config["galleries"]
image_location = "images/"
notes_location = "_notes/"
gallery_notes = "#{notes_location}galleries/"
collection_name = "_galleries/"


everytag = []

gal.each do |galitem|
  gal_dir = galitem["directory"]
  gal_name = galitem["name"]
  gal_tags = galitem["tags"]
  date = galitem["date"]
  dateadded = Time.new
  date = dateadded if date.nil?
  name_slug = gal_name.to_slug.sub(/-\Z/,"")
  files_location = "#{image_location}#{gal_dir}/"
  output_location = "#{collection_name}#{gal_dir}/"


  # make pages for every image in the specified directory #

  # make sure the gallery exists
  if File.exists?(files_location)

    # make gallery index #

    if gal_name

      # make sure the note that links to this gallery has somewhere to go
      unless File.exists?(gallery_notes)
        Dir.mkdir(gallery_notes)
      end

      # make a note to link to this gallery

      indexname = "#{gallery_notes}#{name_slug}.md"
      unless File.exists?(indexname)
      newindex = File.new(indexname, "w+")
      newindex.puts "---"
      newindex.puts "title: #{gal_name}"
      newindex.puts "gallery: #{name_slug}"
      newindex.puts "layout: bucket-gallery"
      newindex.puts "--- \n"
      newindex.puts "Gallery: #{gal_name}"
      end
    else
      # add error message for galleries needing to have a name
    end
    
    if !File.exist?(output_location)
      Dir.mkdir(output_location)
     end
    Dir.glob(['*.{jpg,jpeg,tiff,png,gif}'], base: files_location) do |f|
     
     filename = "#{output_location}#{f.to_slug.sub(/-\Z/,"")}.md"
     if File.exist?(filename)
  			next
    	 else
    		file = File.new(filename, "w+")
    		file.puts "---"
    		file.puts "title: #{f}"
    		file.puts "date: #{date}"
    		file.puts "dateadded: #{dateadded}"
    		file.puts "link: \"#{files_location}#{f}\""
    		file.puts "gallery: #{name_slug}"
    		file.puts "layout: img_note"
    		file.puts "tags: #{gal_tags}"
    		file.puts "--- \n"
    		file.close
    	end
    end

    # set tags #
    gal_tags.each do |tag|
     everytag.push(tag) unless everytag.include?(tag)
    end

    # error if dir doesn't exist
    else
      Dir.mkdir(files_location)
      puts "The directory you defined did not exist, so one was created. No notes have been made."
    end
end


# make notes for new tags too. this should defo be cleaned up later
   everytag.each do |tagpage|
     tag_output = "#{notes_location}tags/"
      unless File.exists?(tag_output)
          Dir.mkdir(tag_output)
      end
        indexname = "#{tag_output}#{tagpage.to_slug.sub(/-\Z/,"")}.md"
        unless File.exists?(indexname)
        newindex = File.new(indexname, "w+")
          newindex.puts "---"
          newindex.puts "title: #{tagpage}"
          newindex.puts "layout: tag-garden"
          newindex.puts "--- \n"
          newindex.puts "A collection of all the notes and other pages in this garden that have the #{tagpage} tag."
      end
      p "Handled tag: #{tagpage}"
  end
