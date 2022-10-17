---
title: Garden Development Log
---

10.16.22

I've made enough progress fiddling with how this site works that it's starting to take shape, and I've been meaning to track the decisions and work that have gone into that shape. I've never released a plugin or a theme or really anything publically, but some of this work is heading in that direction. That's kinda exciting to me, but who knows if I'll ever make the push to wrap it all up to be publically-usable. In any case, this is a record of the work I'm doing.

Related: [[metagardening| About this Garden]]
## Project summary

**Plan**

I want to experiment with ways the digital garden format can faciliate thoughtful browsing and reading, not just writing. The digital garden I imagine would continously sprout with entries for external content that could be easily integrated into the digital-garden way of writing, annotating, and connecting ideas and writing. In the short term, I just want a "front page of the internet" for me and my friends free from algorithms, ads, and hoo-ha.

**Along the way**

This led to working on how to integrate the concept of "collections" into the digital garden way. I think that's a big part of working with and thinking about linked text -- using terms not as as single points, but doors leading to a stream of information linked to that term. None of this is very fancy so far. We're talking photo galleries, and pages that collect individual tags.

**Vaporware dreams**

[[nik|Nik Wise]] and I are working on the world's 10-billionth implementation of tags and 10-millionth implementation of backlinks, which we're calling [[octothorpethoughts|Octothorpes]]. Why? I want to sit down with my garden's notes, connect my writing to my research, connect to my friends and their work, and not  be dependent on a particular app or even "go online." I'll write more about it if we get further down that road.

## Work 🪵

**Mid-April 2022**

Built [getfeeds.rb](https://github.com/thanims/digital-garden-jekyll-template/blob/master/getfeeds.rb) to create markdown files based on external RSS feeds with basic metadata. Script run manually while experimenting, not yet integrated with the Jekyll build process or plugin-ified yet. A lot of this was done on the Amtrak back from [[expoch-go-2022|Expo Chicago]]


**Use**

Add feeds you want to import to `_config.yml`

```
feeds:
  - name: "Astronomy Picture of the Day"
    feed: https://apod.nasa.gov/apod.rss
    bucket: "Astronomy Picture of the Day"
    tags: ["space", "science"]
```

Running `ruby getfeeds.rb` from the root directory does the following:

* puts feeds in their own collection: **_feeds**
* That way they don’t spam the notes graph
* It then makes _notes_ for every bucket and tag on any feed
* This way you can see your buckets on the graph, and link to them
* Those notes use the layouts **bucket-garden** or **tag-garden** (newly added) to list everything with that bucket or tag
* Those layouts have been updated to also include notes, pages, and posts, should any be tagged or bucketed

Also set up a free, no-code deployment solution for my buddy Evan. [Foresty](https://forestry.io) to edit, [Render](https://render.com) to host, tracked on Github

This remains experimental given how much overhead it creates for site rendering. Very much thinking of creating a separate install just for feeds.



**Sept - Oct 2022**

Built [getimgs.rb](https://github.com/thanims/digital-garden-jekyll-template/blob/master/getimgs.rb) to do something similar with directories of images:

* define image groups in `_config.yml` like so

```
galleries:
  - name: "Everything In My Wife's Bag Two Days After We Got Married"
    directory: "wife-bag"
    tags: ["drawing", "art", "Martha"]
```
* run from root like `getfeeds.rb`
* outputs .md files with boilerplate frontmatter in the `_galleries` collection for each image
* makes notes for each gallery linked to their corresponding collections

Started work in earnest on a new visual theme. 
* layout [bucket-gallery](https://github.com/thanims/digital-garden-jekyll-template/blob/master/_layouts/bucket-gallery.html) establishes visual styles
	* text, background, highlight, border, and background svg color can be set by a single page var in frontmatter
*  Made a new version of the home page using plant sprites for notes and feeds