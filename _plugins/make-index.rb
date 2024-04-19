require 'json'
require 'builder'

Jekyll::Hooks.register :documents, :post_write do |doc|
  # Create an array to hold all document objects
  all_documents = []

  # Loop through all site documents
  doc.site.documents.each do |document|
    # Create a hash for the current document with 'id' attribute
    # set to the permalink
    document_hash = { 'id' => document.url }

    # Add the front matter data to the document hash
    document_hash.merge!(document.data)

    # Add the document hash to the all_documents array
    all_documents << document_hash
  end

  # Generate the JSON content
  json_content = JSON.pretty_generate(all_documents)

  # Save the JSON content to a file named 'site-index.js' in the root directory
  File.write(File.join(doc.site.dest, 'site-index.json'), " #{json_content}")


  # Generate the Atom feed
  atom_feed = Builder::XmlMarkup.new(indent: 2)
  atom_feed.instruct! :xml, version: '1.0', encoding: 'utf-8'

  atom_feed.feed(xmlns: 'http://www.w3.org/2005/Atom') do
    atom_feed.title 'Your Site Title'
    atom_feed.subtitle 'Your site\'s subtitle or description.'
    atom_feed.link(href: "#{doc.site.config['url']}/feed.xml", rel: 'self')
    atom_feed.link(href: doc.site.config['url'])
    atom_feed.updated doc.site.time.strftime('%Y-%m-%dT%H:%M:%SZ')
    atom_feed.id "#{doc.site.config['url']}/"
    atom_feed.author { atom_feed.name 'Your Name' }

    # Load the site-index.json data
    site_index = JSON.parse(File.read(File.join(doc.site.dest, 'site-index.json')))

    # Loop through each entry in site-index.json
    site_index.each do |entry|
      atom_feed.entry do
        atom_feed.title entry['title']
        atom_feed.link(href: "#{doc.site.config['url']}#{entry['id']}", rel: 'alternate')
        atom_feed.id entry['url']
        atom_feed.updated entry['date_updated']
        atom_feed.published entry['date_updated']
        atom_feed.category(term: entry['category']) if entry['category']
        if entry['categories'] && entry['categories'].include?('image')
          atom_feed.content(type: 'html') do
            atom_feed << "<![CDATA["
              atom_feed.a(href: "#{doc.site.config['url']}#{entry['id']}") do
                atom_feed.img(src: "#{doc.site.config['url']}#{entry['link']}", alt: entry['title'])
            end
            atom_feed << "]]>"
          end
        else
          atom_feed.content entry['excerpt'] if entry['excerpt']
        end
      end
    end
  end

  # Save the Atom feed to a file named 'feed.xml' in the root directory
  File.write(File.join(doc.site.dest, 'everything.xml'), atom_feed.target!)
end

