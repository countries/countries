# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## 0.11.2
- silence ruby warnings @franckverrot
- add find_country_by_translated_name @rposborne NOTE: this is garbage for the
  time being, some translations have duplicates in them and causes false results

## 0.11.1
- added bounding box coordinates for VI, CW, PR, AS, and GU : @marinom
- revert Lookup country by translated name via find_by_name @rposborne

## [0.11.0] - 2015-03-03
### Changed
- Cached Translations in gem to translation lookup speed @rposborne, @stayhero
- Upgrade test suite to rspec 3 @rposborne
- Added region_short for postal codes @stayhero
- Content Updates @masolino, @rosetree, @stayhero, @skarlcf, @cllns, @speric, @rposborne
- Adding Lat/Lng to countries @jabawack81
- Readme Updates @cllns
