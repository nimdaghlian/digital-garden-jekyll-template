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

# 12.26.22

We wrote version 1 in our heads, so why not make a spec for Version 2 before we actually write it in code


# Octothorpes

Octothorpes is a lightweight protocol for creating bidirectional links and event streams between documents, regardless of whether the documents are accessible via local or networked protocols. The octothorpe ecosystem consists of:
	* documents
		* content
		* yaml frontmatter
	* an octothorpes parser
	* an octothorpes server

Write **documents** in plaintext or markdown, describe them with basic YAML frontmatter.
Run an octothorpes parser to create meaningful records that describe the documents and their relationships to other records.

> A Parser runs in the same environment where you access the documents. For example, if you were writing documents in markdown files on your own machine, you would use the Octothorpes CLI. If you are writing them in Wordpress on a public blog, you would use an embedded script or Wordpress plugin.

**An Octothorpes parser** creates descriptive RDF records for each of your documents. These records can contain the full content of your documents, or simply a reference to a canonical source of a document's content. Parsers deal with the following entities:

* Document records
* Backlinks 
* Octothorpe Terms (also known simply as `octothorpes`)
* User terms


### Octothorpes server


Connect your parser to an **octothorpe server** to relate your parsed documents to other documents and terms. A `server` reads the RDF created by parsers and provides an API for interacting with that information. Octothorpe servers respond to requests for all of the above entities and handle the following **Events**

* [All ActivityPub actions](https://www.w3.org/TR/activitypub/)
* Sync
* Transform
* Feed

## Entities


### Document records

Parsing a document creates a descriptive record of a document that is treated as a permanent ID for that document in the Octothorpes ecosystem. 

> todo: document spec.
> I think docs should only require title, alias, terms, mode (r,w,x), and content (reference or canonical)
> but feels like more thinking is required.

**Canonical document records**

Optionally, the content of a document can be stored in the document record and treated as the canonical version. Separate files or URLS can be created from a canonical document record via Events, according to access rights a Server has to the environment in which those files exist. Setting a document record's mode to `read-write` requires converting it to a `CDR`. `CDRs` could also be used when moving a set of documents to a new environment, preventing accidental editing of a document, or, conversely, if your preferred method of editing a document is with a (currently nonexistent) document record editor application.


### Backlinks

Backlinks are bidirectional links between documents. Since Octothorpes uses RDF descriptions of your documents, these *can* be hyperlinks but *don't have to be.* A backlink is simply a bidirectional relationship between any two documents the Octothorpes Server can identify. An octothorpes server includes backlink relationship information with any request for a document, and can respond to direct requests for backlink nodes.

> todo: resolve backlink concept with activitypub 
> maybe a good [ref here](https://github.com/pfefferle/wordpress-activitypub)?

### Octothorpe Terms
Whereas backlinks describe a relationship between documents, Octothorpe Terms -- or simply `octothorpes` -- describe a relationship between a document and a universal term. A document that is octothorped with the term `#octothorpe` has a potential relationship to every other accessible document with the same octothorpe. 

**Browsing and following octothorpes**

Octothorpe servers provide an API for all the terms and documents they know about. If this API is made public, it can be subscribed to or manually interacted with via ActivityStreams / ActivityPub protocols, or a `feed` request.

> Example: Nik subscribes a private Octothorpes server (Server A) and subscribes to the popular public server octothorp.es. (Server B). Nim only subscribes to Server B, but  When Nik issues a request for the octothorpe `#wombats` he sees results from Servers A and B. Nim will only see results from Server B.  


## User terms
An arbitrary number of terms can be associated with a document record. These can be as simple as plaintext tags or a full schema such as SKOS.

> By default, Parsers should be able to read and write User terms as [ActivityStreams](https://www.w3.org/TR/activitystreams-core/#object) and [ActivityPub](https://www.w3.org/TR/activitypub/)


## Events

**Sync** 

`Sync` is used to copy content between environments, according to the access rights of those environments.

Assuming the user has appropriate rights and access in both the environment where the `Server` they `sync` to and the `Parser` that issues the request,the requested `server` will respond with the canonical content and all terms for the requested `document record`.

The `parser` which issued the `sync` request then creates an associated `document record` . Environment variables or request params can be used to set whether that `document record` uses the original as its canonical reference, creates a new file to reference, or creates a new `CDR` backlinked to the original `document record`. 

If the `mode` is set to `read-write` a sync request can be sent with an `overwrite` flag, which will update the `document record` with the canonical content of a separate `document record.` 

**Transform**

`transform` is a read-only version of `sync` that can map `document record` attributes to an arbitrary set of outputs according to schema definitions provided to the `parser` in the form of JSON / JSON-LD. This is mainly a convenience function for `parsers`, as the response from the `server` will be the same as a `sync` request, but upon success will trigger further work by the `parser` that issued the request, according to env variables, request params, and schema definitions. 

> Example 1: Nim writes documents in Obsidian and publishes them on a Jekyll site. Both allow backlinking via alias but use different terms to define the alias. He sets up a simple schema definition that converts the `alias` term to a `title` term. He then uses the Octothorpes CLI to `transform` documents within his working directory using the `obsidian-jekyll` schema, outputting them as markdown files in his specified Jekyll directory. 
> Example 2: Retweet the web. Nik reads an article he likes on a blog that provides public `document records` for each of its articles. Using a bookmarklet authenticated to his private `server`, he can send a `transform` request to his server which will convert the `document record` of the blog article he's reading into a document format that his own website uses, creating a `backlink` to the original `document record` in the process.

**Feed**

The `feed` request will create an rss/xml/whatever feed based on request parameters or `server` defaults when sent. 

> Example: Nik and Nim create a shared, private `server` that they both `sync` their notes to. They don't feel like creating a website, but they want to share what they're working on. So they set a public endpoint for `feed?authors=Nik-nim&format=rss-rdf` that allows anyone to subscribe via RSS. Of course, the feed includes well-formed `document records` by default, so anyone running their own `server` locally can easily `transform` that feed into any format they want.
> 