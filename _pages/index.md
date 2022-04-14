---
layout: page
title: Home
id: home
permalink: /
---

# Welcome! 🌱

Hi Evan! This is an adaptation of the [Jekyll digital garden template](https://github.com/maximevaillancourt/digital-garden-jekyll-template), a free and open-source template made by smart people.

Here's their [step-by-step guide explaining how to set this up from scratch](https://maximevaillancourt.com/blog/setting-up-your-own-digital-garden-with-jekyll). That covers most of it, but here's what I've added.

### Notes

> The main concept here is that you can make notes and easily link them to other notes. Most of the time you can edit them in Obsidian and not have to worry about the code at all.

Here's the starter note that comes with the template. It demonstrates all the stuff you can do with a note: [[Your first note]]


Here's all the sample [notes]({% link _pages/notecloud.md %}) that I've imported.

### You can import RSS feeds!

You'll have to use the command line in *terminal* for this, but don't worry -- it's super easy and you'll be a pro in no time.

If you're in the root directory of the site, the command for this is `ruby getfeeds.rb`

You can add and tag feeds in the all-important `_config.yml`

### I made some new page templates

These live in the `_layouts` folder

* The `garden` layout is for notes. It'll show you all the linked notes as 🪴
* The `tag-garden` and `tag-list` layouts are for pages. It'll show you anything that has the tag you assign to that page as either an item in a list or a 🪴 in a square
* The `url-note` layout is designed for notes that come from RSS feeds. It assumes there's an external source to link to.
