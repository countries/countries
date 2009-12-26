Countries
=========

Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard. It contains info for the following standards ISO3166-1 and E.164. Next release will contain ISO3166-2 and ISO4217. I will add any country based data I can get access to. I hope this to be a repository for all country based information.

Warning!
--------

The data in this gem is collected from many different sources including [CommonDataHub][] and represents a best effort to be accurate and up to date. It is used at your own risk.

Installation
------------

Countries is hosted on GemCutter, so simply run the following:

    gem sources -a http://gemcutter.org
    sudo gem install countries
    
Use It!
-------

Simply load a new country object using Country.new(iso 3166 alph2 code) or the shortcut Country[iso 3166 alph2 code]. An example  works best.

    c = Country.new('US')
    c = Country['US']
    
Then you have all sorts of methods on the Country object to give you info about the country.

    c.number # ISO3166 numeric country code
    c.alpha2 # ISO3166 alpha2 country code
    c.alpha3 # ISO3166 alpha2 country code
    c.name # ISO3166 name
    c.names # ISO3166 alternate names
    c.latitude # uuuh the latitude
    c.longitude # obvious?
    c.region # UN Region
    c.subregion # UN SubRegion
    c.country_code # E.164 Country Code
    c.national_destination_code_lengths # E.164 length of national destination code
    c.national_number_lengths # E.164 length of the national number
    c.international_prefix # E.164 code for dialing international from country
    c.national_prefix # E164 code for dialing within the country
    c.subdivisions # All ISO3166-2 for that country with there codes

ToDo
----

* currency (ISO 4217)
* search/indexing

Sponsored By
------------

This gem is sponsored by [Teliax][]. [Teliax][] makes business class Voice, [Centrex][](Including Hosted: IVRs, Ring Groups, Extensions and Day Night Mode) and Data services accessible to anyone. You don't have to be a fortune 500 to sound big!

Note on Patches/Pull Requests
-----------------------------
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2009 hexorx. See LICENSE for details.


[Teliax]: http://teliax.com
[Centrex]: http://en.wikipedia.org/wiki/Centrex
[CommonDataHub]: http://commondatahub.com