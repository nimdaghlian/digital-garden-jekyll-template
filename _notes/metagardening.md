---
title: About Gardening This Garden
---

## How I Started this Garden

4.18.22

No digital garden is complete without a good pile of notes about digital gardens themselves!

Less than a month since reading this bittersweet thread 👇 from my friend Ryan, who was, like, *there* when the web cut its own bangs for the first time, I've not only started a digital garden, I've extended its features and roped at least [[Evan Dumas|one friend]] into making [his own](https://evans-thoughts-garden.onrender.com). 

https://twitter.com/sixfoot6/status/1506011362249437190


A little ways down that thread, someone mentions digital gardening.

https://twitter.com/Weegee/status/1506016809790554113


It was a term I'd heard before, but there was something about the specificity of how he said it that got me digging. You can see most of what I found and read at [[digitalgardens]] and [[cozyweb]]. 

It was timely, because just a few days prior I had lucked into an actual evening of *web browsing* thanks to the excellent [random button on Marginalia search](https://search.marginalia.nu/explore/random).

> Appropriately enough when I went to go get that link, I discovered that Marginalia has a [memex](https://memex.marginalia.nu), a central reference of one of the [instigating texts of the current movement of digital gardens](https://hapgood.us/2015/10/17/the-garden-and-the-stream-a-technopastoral/).
	
> and holy shit they have a... [gemini](https://en.wikipedia.org/wiki/Gemini_(protocol))? [site](https://proxy.vulpes.one/gemini/marginalia.nu/)? 
> wow... brand new thing learned while writing this. this nerdrabbithole keeps getting deeper.

Like Ryan and his friends in that thread, I've been casting about for ghosts of an internet time that I probably don't even remember correctly. Not just for nostalgia, though... for the reasons it was good in the first place. And I'm coming out of a five / ten year [writing project](https://conceptuallabor.com) with a pile of research and a great hunger for lighter, looser writing and free-association. This is it's own rabbithole, and it's getting a little late, so in the discursive, anti-completist nature of digital gardens, I'll put a pin in this and come back to it. In any case I was hella primed to find out about this [whole pattern](https://conceptuallabor.com/blog/writing-tools-1) or writing and making websites.

### This Garden's Harvests

That said, I am so far much more interested in the website-making rather than note-taking parts of digital gardens. That's reflected in my modifications thusfar to the really excellent [digital garden Jekyll template I'm using](https://github.com/maximevaillancourt/digital-garden-jekyll-template).

#### I'm importing RSS feeds 

Pinboard is totally central to my use of the internet. But, as the author of the Memex points out, we store much more information than we retrieve. I've wanted a better way to view and interact with my bookmarks and research for a long time.

So I banged together a [little ruby script](https://github.com/nimwunnan/digital-garden-jekyll-template/blob/master/getfeeds.rb) that does the following

* turns entries from an RSS feed into markdown files in the collection `_feeds`
* adds useful frontmatter such as tags and a default template
* creates a `note` for every `tag` and `bucket` specified
	* for pinboard feeds, it includes the tags from pinboard for each item
* adds backlinks to `feed` page content to their corresponding `bucket` note 

> I'd like to release this as an actual jekyll plugin. It needs some work first, and I'm not usually a ruby developer, but ruby's friendly enough. Anyway, I have to take a break from working *on* this garden to putting things *in* it, so stay tuned for that.

So far the external sites I've imported are:

* [[astronomy-picture-of-the-day]]
* [[public-domain-review]]
* [[the-morning-news]]
* and [[Martha]]'s excellent [[Grapefruits Sometimes Art Email]]

and you can find allllll my bookmarks in the [[bookmarks]] bucket.

### I made some new templates

Very quick and dirty so far. They serve two purposes: collecting groups of content, and making it possible for me to show [[Martha| Martha]] a garden of emoji plants. They're evident in the above links.


