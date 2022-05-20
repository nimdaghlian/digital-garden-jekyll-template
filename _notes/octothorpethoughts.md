---
tags:
- |2-

  octothorpe
- cozyweb
title: octothorpethoughts
layout: note
poster: ''

---
I had a 15 mile hiking day in [[canyonlands]] and thought about digital gardens until my brain melted. I dumped my thoughts about this project on [[Nik]] and he dumped them back in a [much prettier pile](https://garden.nikolas.ws/thinking-about-octothorpes/).


[Social Web Protocol is interesting](https://www.w3.org/TR/social-web-protocols)

[DBPedia would be cool if it worked](https://www.dbpedia-spotlight.org)

# 5.9.2022

Had a chance to look at [Dorian Taylor's](https://doriantaylor.com) library of[ RDF for Ruby](https://github.com/doriantaylor/rb-rdf-sak) stuff. [[nik]] is super into his stuff, and have chatted with him briefly because of this on twitter. Obvs knows a lot about all of this.

Overall, my interest in digital gardens is I'm trying to stick to "what goes in the frame" than "how is the frame built". Of course, the whole octothorpe idea is very, very much a frame idea. With that in mind, and with the world benefitting from excellent frame-makers like Dorian, my hunch is that I want an in-the-middle approach like so:

* Leave the website making to the things that make websites -- Jekyll, Hugo, Next.js, whatever
* It's ok for people to use their website-makers to make connections and meaning on their website in their usual way
* Use the RDF layer to do all the mapping / relating / remaking

### This means:

* Any RDF and linked-data patterns should be able to read the cliff-notes version of this meaning and these connections (ie a Jekyll plugin that can convert tags / layouts to metadata)
* I think the canonical urls for a markdown-based SSG should be raw markdown files with rich frontmatter
* Octothorpes is a service that doesn't care how your site is made, and expects to look at markdown files like that
* Lightweight plugins / converters maintined within the ecosystems of website-makers take care of going from Their Way of Doing Things to producing these canonical markdown files
* How much metadata goes into a human-readable public url is decided within the website-making step
* Octothorpes as a service a human would use does the following:
	* parses and associates the meaning of the metadata on canonical urls with the content (markdown) within an namespace
	* generates the relevant JSON-LD for that namespace
	* coordinates / distributes resources like the plugins that a SSG would use to hook into the Octothorpoes ecostytem
	* provides JS interfaces for the core features of the Octothorpes ecosystem to plunk in on sites that don't use / have access to the above plugins ^. Eg:
		* simple D3-like graph visualization of related content
		* in-line activation of "octothorped" terms
		* backlinks
	* provides an infinite and growing set of visualizations, connections, remixes, etc from it's galaxy of linked data... lalaal whatever this is the "future is bright / open source everything" part of the roadmap
		* *This* step is where you would generate actual webpages from pure RDF / OWL / JSON-LD whathave you. This is fine, but I don't think we should *start* there.


So this represents a pretty big departure from Dorian's project. His swiss-army knife is super cool and interesting, but too unwieldy to carry in your pocket everywhere

I'm lookin [at this stuff](https://github.com/ruby-rdf/). Ecosystem seems healthy and well maintained.
