require 'rubygems'
require 'rss'
require 'open-uri'
require 'time'
require 'yaml'
require 'to_slug'



 config = YAML.load_file('_config.yml')
 feed = config["feeds"]
 output_location = "_feeds/"
 notes_location = "_notes/"
 everytag = []

 feed.each do |feeditem|

  feed_url = feeditem["feed"]
  name = feeditem["name"]
 	bucket = feeditem["bucket"]

  # set parse_tags: true on the yaml for a feed
  # if you want to make notes for all the tags
  # that come in on the feed items

  parse_tags = feeditem["parse_tags"]
  bucket_slug = bucket.to_slug.sub(/-\Z/,"")

  # option to manually set tags for each item

  if feeditem["tags"]
    globaltags = feeditem["tags"]
  else
    globaltags = []
  end
 	this_output = output_location
 	if bucket
    # make sure the feed pages have somewhere to go
    this_output += "#{bucket_slug}/"
    unless File.exists?(this_output)
      Dir.mkdir(this_output)
    end

    # make sure the note that links to this bucket hass somewhere to go
    bucket_notes = "#{notes_location}buckets/"
			unless File.exists?(bucket_notes)
				Dir.mkdir(bucket_notes)
      end
			indexname = "#{bucket_notes}#{bucket_slug}.md"
			unless File.exists?(indexname)
			newindex = File.new(indexname, "w+")
			newindex.puts "---"
			newindex.puts "title: #{bucket}"
			newindex.puts "layout: bucket-garden"
			newindex.puts "--- \n"
      newindex.puts "A collection of all the notes and other pages in this garden that are in the #{bucket} bucket."
		end
 	end

   URI.open(feed_url) do |rss|
     feed_source = RSS::Parser.parse(rss)
     # puts "Title: #{feed.channel.title}"
     feed_source.items.each do |item|
       # puts "Item: #{item.title}"
       title = item.title.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '-')
       tags = globaltags
       if item.dc_subject
         tags += item.dc_subject.split(" ")
       end

       # make notes for tags -- include the tags from feed items if parse_tags flag is set

       if parse_tags
         tagnotes = tags
       else
         tagnotes = globaltags
       end

       tagnotes.each do |tag|
         everytag.push(tag) unless everytag.include?(tag)
       end

       description = "No Description"
       if item.description
         description = item.description
       end
       entry_url = item.link
       date = item.dc_date
       dateadded = Time.new
       date = dateadded if date.nil?
       filename = "#{this_output}#{title.to_slug.sub(/-\Z/,"")}.md"
       if File.exist?(filename)
   			next
   		 else
   			file = File.new(filename, "w+")
   			file.puts "---"
   			file.puts "title: > \n #{title}"
   			file.puts "date: #{date}"
   			file.puts "dateadded: #{dateadded}"
   			file.puts "link: \"#{entry_url}\""
   			file.puts "bucket: #{bucket}"
   			file.puts "layout: urlnote"
   			file.puts "tags: #{tags}"
   			file.puts "--- \n"
        file.puts description
   			file.puts " <!-- end excerpt --> \n"
        # ok this hardcodes the url, which is fine, but make dynamic if you turn this into a plugin
        file.puts "<div class='bucket'><a class='internal-link' href='/buckets/#{bucket_slug}'>#{bucket}</a></div> \n"
   			file.close
   		 end
     end
     p "#{name} feed updated in #{bucket}"
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
