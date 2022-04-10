require 'rubygems'
require 'feed-normalizer'
require 'time'
require 'yaml'
require 'to_slug'
require 'sanitize'

feed_file = "localfeeds.yml"
output_location = "../_notes/"

feed = YAML.load_file(feed_file)
feed.each do |feeditem|

	feed_url = feeditem["feed"]
  name = feeditem["name"]
	bucket = feeditem["bucket"]
	this_output = output_location
	if bucket
		this_output += "#{bucket}/"
			unless File.exists?(this_output)
				Dir.mkdir(this_output)
				indexname = "#{output_location}buckets/#{bucket}.md"
				unless File.exist?(indexname)
					newindex = File.new(indexname, "w+")
					newindex.puts "---"
					newindex.puts "title: #{bucket} Bucket"
					newindex.puts "layout: garden"
					newindex.puts "---"
				end
			end
	end

	rss = FeedNormalizer::FeedNormalizer.parse URI.open(feed_url)
	rss.parser = "SimpleRSS"

	rss.entries.each do |entry|
		title = entry.title.encode('utf-8', :invalid => :replace, :undef => :replace, :replace => '-')
		body = entry.content
		authors = entry.authors.join(', ') rescue ''
		entry_url = entry.urls.first
		dateadded = Time.new
		date = entry.date_published
		updated = entry.last_updated
		date = updated if date.nil?
		date = dateadded if date.nil?

		filename = "#{this_output}#{title.to_slug.sub(/-\Z/,"")}.md"
		description = Sanitize.fragment(entry.description)
		if File.exist?(filename)
			next
		else
			file = File.new(filename, "w+")
			file.puts "---"
			file.puts "title: > \n #{title}"
			file.puts "date: #{date}"
			file.puts "dateadded: #{dateadded}"
			file.puts "description: > \n #{description}"
			file.puts "link: \"#{entry_url}\""
			file.puts "bucket: #{bucket}"
			file.puts "layout: urlnote"
			file.puts "excerpt_separator: <!-- excerpt-end -->"
			file.puts "--- \n"
			file.puts " <!-- excerpt-end -->[[#{bucket}|buckets/#{bucket}]]"
			file.close
		end
	end
end

# .downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
