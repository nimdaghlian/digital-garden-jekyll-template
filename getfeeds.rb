require 'rss'
require 'open-uri'
require 'time'
require 'yaml'
require 'to_slug'



 config = YAML.load_file('_config.yml')
 feed = config["feeds"]
 output_location = "_notes/"

 feed.each do |feeditem|

  feed_url = feeditem["feed"]
  name = feeditem["name"]
 	bucket = feeditem["bucket"]
 	this_output = output_location
 	if bucket
    p bucket
 		this_output += "#{bucket}/"
 			unless File.exists?(this_output)
 				Dir.mkdir(this_output)
 				indexname = "#{output_location}buckets/#{bucket}.md"
 				unless File.exists?(indexname)
 					newindex = File.new(indexname, "w+")
 					newindex.puts "---"
 					newindex.puts "title: #{bucket} Bucket"
 					newindex.puts "layout: garden"
 					newindex.puts "---"
 				end
 			end
 	end

   URI.open(feed_url) do |rss|
     feed = RSS::Parser.parse(rss)
     # puts "Title: #{feed.channel.title}"
     feed.items.each do |item|
       # puts "Item: #{item.title}"
       title = item.title.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '-')
       categories = []
       if item.dc_subject
         categories = item.dc_subject.split(" ")
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
   			file.puts "categories: #{categories}"
   			file.puts "--- \n"
        file.puts description
   			file.puts " <!-- end excerpt --> \n [[#{bucket}|buckets/#{bucket}]]"
   			file.close
   		end
     end
   end
end
