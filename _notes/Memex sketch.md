---
---

# Bloggarden

* [ ] Garden view where articles appear as plant sprites
* [ ] Lots of filtering options in all views, incl garden
* [ ] Sustainable deployment pipeline that won't choke on 1000s of articles
* [ ] Convert articles to notes for my own use on the frontend
* [ ] Article contents generally don't get borked when imported
* [ ] Can run in Jekyll build time
* [ ] Open-sourceable if someone else wants to run it


---

* I want to write documents in plaintext or markdown with minimal YAML frontmatter.
* Only title is required, the rest of the frontmatter is arbitrary
	* Expected but optional terms:
		* tags < could this be "relationships?"
		* alias
		* slug
* I want to define significant terms on a per-directory basis
	* 
* I want to be able to use backlinks in any document
	* I should be able to define backlink syntax if it differs from a set of standard sytaxes (ie double brackets)
	* Backlinks to documents should accept aliases
	* Backlinks can link to octothorpes
* I want to be able to create Proxy Documents for octothorpes
	* Local backlinks to a Proxy Document will create document-level octothorpes for the term assigned to the Proxy