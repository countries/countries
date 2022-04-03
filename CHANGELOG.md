# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/).

## [5.0.0] (https://github.com/countries/countries/releases/tag/v5.0.') (2022/04/03 17:44 +00:00)

**Breaking Changes**

- Drop support for Ruby 2.5 and 2.6. (EOL in 2021-03-31 and 2022-03-31, respectively)
- Remove deprecated attributes and add new `#find_by_any_name` finder, see https://github.com/countries/countries#upgrading-to-42-and-5x for details

**Merged pull requests:**

- Drop support for Ruby 2.5 and 2.6 [\#708](https://github.com/countries/countries/pull/708) ([pmor](https://github.com/pmor))
- Remove deprecated attributes; Add new `#find_by_any_name` finder [\#745](https://github.com/countries/countries/pull/708) ([pmor](https://github.com/pmor))

## [4.2.3](https://github.com/countries/countries/releases/tag/v4.2.2) (2022/03/24 11:00 +00:00)

**IMPORTANT NOTE: This will be be the last release of the 4.x series, and the last one to support Ruby 2.5 and 2.6**

* Use bundle add instead [\#743](https://github.com/countries/countries/pull/743) ([glaucocustodio](https://github.com/glaucocustodio))
* update i18n_data [\#742](https://github.com/countries/countries/pull/742) ([bonekost](https://github.com/bonekost))

## [4.2.2](https://github.com/countries/countries/releases/tag/v4.2.2) (2022/02/17 13:52 +00:00)

**Merged pull requests:**

* http:// -> https:// [\#737](https://github.com/countries/countries/pull/737) ([biow0lf](https://github.com/biow0lf))
* Update AE start_of_week to monday. [\#739](https://github.com/countries/countries/pull/739) ([pmor](https://github.com/pmor))
* Fix Subdivision data by [\#740](https://github.com/countries/countries/pull/740) ([pmor](https://github.com/pmor))

**Closed issues:**

* Change on UAE Value.start_of_week [\#738](https://github.com/countries/countries/issues/738)


**Full Changelog**: https://github.com/countries/countries/compare/v4.2.1...v4.2.2

## [4.2.1](https://github.com/countries/countries/releases/tag/v4.2.1) (2022/01/11 12:39 +00:00)

- Missing update to cache files on release 4.2.0
- Update postal code regexes from rake task [\#734](https://github.com/countries/countries/pull/734 ) ([cover](https://github.com/cover))

## [4.2.0](https://github.com/countries/countries/releases/tag/v4.2.0) (2022/01/11 11:04 +00:00)

**Deprecations**

- `Country#name`, `Country#names` and the finders using these attributes. See README ('Upgrading to 4.2 and 5.x')
- `latitude_dec` and `longitude_dec` attributes

**Merged pull requests:**

* Name methods refactor [\#717](https://github.com/countries/countries/pull/717) ([pmor](https://github.com/pmor))
* Remove non-ISO US subdivisions [\#720](https://github.com/countries/countries/pull/720) ([pmor](https://github.com/pmor))
* Update MK subdivisions [\#721](https://github.com/countries/countries/pull/721) ([pmor](https://github.com/pmor))
* Update Kenya subdivision data [\#722](https://github.com/countries/countries/pull/722) ([pmor](https://github.com/pmor))
* Fix French Southern Territories continent and region data [\#725](https://github.com/countries/countries/pull/725) ([pmor](https://github.com/pmor))
* Fix SG subdivision data [\#726](https://github.com/countries/countries/pull/726) ([pmor](https://github.com/pmor))
* Remove FO subdivisions [\#727](https://github.com/countries/countries/pull/727) ([pmor](https://github.com/pmor))
* JE and IM currencies should be GBP [\#728](https://github.com/countries/countries/pull/728) ([pmor](https://github.com/pmor))
* Fix US translations in nb and no locales [\#729](https://github.com/countries/countries/pull/729) ([pmor](https://github.com/pmor))
* Missing alternative names for GB and US [\#724](https://github.com/countries/countries/pull/#724) ([dima4p](https://github.com/dima4p))
* Deprecate latitude_dec and longitude_dec, delegate to latitude [\#723](https://github.com/countries/countries/pull/#723) ([pmor](https://github.com/pmor)
* add VAT for Israel and Saudi Arabia [\#730](https://github.com/countries/countries/pull/#723) ([Venca24](https://github.com/Venca24)
* Remove non-ISO KY subdivisions [\#731](https://github.com/countries/countries/pull/731) ([pmor](https://github.com/pmor))
* Fix duplicated translations of CZ-10 subdivision [\#733](https://github.com/countries/countries/pull/733) ([pmor](https://github.com/pmor))

**Closed issues:**

* Update Kenya subdivisions/states [\#318](https://github.com/countries/countries/issues/318)
* North Macedonia updates (2020-03-02) [\#674](https://github.com/countries/countries/issues/674)
* Singapore wrong subdivision codes (SG-SG-0x) [\#663](https://github.com/countries/countries/issues/663)
* Remove Faroe Islands subdivisions [\#606](https://github.com/countries/countries/issues/606)
* Jersey uses GBP instead of JEP currency [\#492](https://github.com/countries/countries/issues/492)
* USA in Norwegian translation should be 'USA' instead of 'De forente stater' [\#564](https://github.com/countries/countries/issues/564)
* Geographic bounds for UK includes all of Europe [\#535](https://github.com/countries/countries/issues/535)
* Wrong min_longitude for United States of America? [\#698](https://github.com/countries/countries/issues/698)
* Translations for CZ-10 are defined twice [\#732](https://github.com/countries/countries/issues/732)


## [4.1.3](https://github.com/countries/countries/releases/tag/v4.1.2) (2022/01/03 12:16 +00:00)

**Merged pull requests:**

* Fix empty translations in LV subdivisions [\#719](https://github.com/countries/countries/pull/719) ([pmor](https://github.com/pmor))

**Closed issues:**

* Subdivision translations for some latvian subdivisions nil in countries 4.1.2 [\#718](https://github.com/countries/countries/issues/718)

## [4.1.2](https://github.com/countries/countries/releases/tag/v4.1.2) (2021/12/20 17:06 +00:00)

**Merged pull requests:**

* Update subdivisions, fix #600 conflicts [\#710](https://github.com/countries/countries/pull/710) ([donnen](https://github.com/donnen), [pmor](https://github.com/pmor))
* Fix conflicts in #605 and update those countries to the latest subdivision data [\#711](https://github.com/countries/countries/pull/711) ([jjamesjohnson](https://github.com/jjamesjohnson), [pmor](https://github.com/pmor))
* Update NZ subdivision data and fix Chatham Island entry [\#712](https://github.com/countries/countries/pull/712) ([pmor](https://github.com/pmor))
* Update translation corrections for Occitan.[\#713](https://github.com/countries/countries/pull/713) ([pmor](https://github.com/pmor))
* Update i18n_data to 0.15.0 [\#715](https://github.com/countries/countries/pull/715) ([pmor](https://github.com/pmor))

## [4.1.1](https://github.com/countries/countries/releases/tag/v4.1.1) (2021/12/06 13:31 +00:00)

**Merged pull requests:**

* Fix ISO3166::Country respond_to_missing? [\#625](https://github.com/countries/countries/pull/625) ([biinari](https://github.com/biinari))
* Revert subdivision changes to NO.yaml [\#709](https://github.com/countries/countries/pull/709) ([pmor](https://github.com/pmor))

## [4.1.0](https://github.com/countries/countries/releases/tag/v4.1.0) (2021/11/30 09:44 +00:00)

**New features:**

- `Country.pluck` [\#706](https://github.com/countries/countries/pull/706) ([dorianmariefr](https://github.com/dorianmariefr))

**Closed issues:**

 - Ensure Moscow Oblast translations reference the "province" [\#694](https://github.com/countries/countries/pull/694) ([carlesjove](https://github.com/carlesjove))
 - Update NL reduced VAT rate [\#693](https://github.com/countries/countries/pull/693) ([oscaredel](https://github.com/oscaredel))
 - Serbian translation for North Macedonia is incorrect [\#703](https://github.com/countries/countries/issues/703)

**Merged pull requests:**

- Set the code when creating subdivisions [\#658](https://github.com/countries/countries/pull/658) ([IamDavidovich](https://github.com/IamDavidovich))
- Refresh subdivision data from CLDR  [\#704](https://github.com/countries/countries/pull/704) ([pmor](https://github.com/pmor))
- Update I18nData gem to 0.13.1 and fix MK translation in `mk` locale [\#705](https://github.com/countries/countries/pull/705) ([pmor](https://github.com/pmor))

## [4.0.1](https://github.com/countries/countries/releases/tag/v4.0.1) (2021/07/19 14:47 +01:00)

**Closed issues:**

- ISO Country Code for Czechia/Czech Republic should be updated. [\#688](https://github.com/countries/countries/issues/688)
- Regression in 4.0.0: ISO3166::Country.translations(:en) with symbol arg raises [\#691](https://github.com/countries/countries/issues/691)

**Merged pull requests:**

 - Updating Norway subdivision codes to match late 2020 ISO change [\#666](https://github.com/countries/countries/pull/666) and [\#689](https://github.com/countries/countries/pull/689) ([thomascrumrine](https://github.com/thomascrumrine))
- Update CZ.yaml: Czechia is the ISO short name for the Czech Republic [\#690](https://github.com/countries/countries/pull/690) ([pmor](https://github.com/pmor))
- Fix regression in `ISO3166::Country.translations` with symbols [\#692](https://github.com/countries/countries/pull/692) ([pmor](https://github.com/pmor))


## [4.0.0](https://github.com/countries/countries/releases/tag/v4.0.0) (2021/06/11 09:47 +01:00)

[Full changelog](https://github.com/countries/countries/compare/v3.1.0...v4.0.0)

**Breaking changes:**

  - None

**Closed issues:**

  - update_cldr_subdivison_data Rake task broken due to CLDR repo change [\#633](https://github.com/countries/countries/issues/633)
  - Fix ISO3166::Data.register loading of nested hashes (from https://github.com/countries/countries/pull/397#issuecomment-846543094)
  - Angola's bounds is the same as Austria? [\#682](https://github.com/countries/countries/issues/682)

**Merged pull requests:**

 - `make_cache_thread_safe` ([factorialco](https://github.com/factorialco))
 - Update i18n_data to 0.13.0 and drop support for rubies <2.5 [\#650](https://github.com/countries/countries/pull/650) ([pmor](https://github.com/pmor))
 - Fixes [\#633] and updates geocoder searches [\#634](https://github.com/countries/countries/pull/634) ([mezza](https://github.com/mezza))
 - `translation_corrections.yaml`: Fix broken link [\#664](https://github.com/countries/countries/pull/664) ([henrik](https://github.com/henrik))
 - Correct Danish translation of CZ [\#661](https://github.com/countries/countries/pull/661) ([JanMSP](https://github.com/JanMSP))
 - Swedish translation correction: RU = "Ryssland" [\#665](https://github.com/countries/countries/pull/665) ([henrik](https://github.com/henrik))
 - Update gemspec metadata with new repo url [\#672](https://github.com/countries/countries/pull/672) ([pmor](https://github.com/pmor))
 - Fix typo and lint in README.markdown [\#675](https://github.com/countries/countries/pull/675) ([DigiPie](https://github.com/DigiPie))
 - Update CI to the latests ruby point versions [\#677](https://github.com/countries/countries/pull/677) ([pmor](https://github.com/pmor))
 - Adds North Korea to list of unofficial names of KP [\#681](https://github.com/countries/countries/pull/681) ([talha-akram ](https://github.com/talha-akram ))
 - Update Vietnam subdivisions with current ISO_3166-2:VN [\#673](https://github.com/countries/countries/pull/673) ([keymastervn](https://github.com/keymastervn))
 - Add custom countries to translation lists [\#595](https://github.com/countries/countries/pull/595) ([phylor](https://github.com/phylor))
 - Fix ISO3166::Data.register loading of nested hashes, eg: geo data. [\#683](https://github.com/countries/countries/pull/683) ([pmor](https://github.com/pmor))
 - Remove Travis CI configuration. [\#685](https://github.com/countries/countries/pull/683) ([pmor](https://github.com/pmor))

## [3.1.0](https://github.com/countries/countries/releases/tag/v3.1.0) (2021/03/24 00:01 +05:00)

[Full Changelog](https://github.com/countries/countries/compare/v3.0.1...v3.1.0)

**Closed issues:**

- Add timezones to country data [\#669](https://github.com/countries/countries/issues/669)
- The name for Vietnam is incorrect  [\#660](https://github.com/countries/countries/issues/660)
- Missing address\_format for Vietnam [\#652](https://github.com/countries/countries/issues/652)
- Temporary German VAT rate \(16%\) from July 1st to December 31st, 2020 [\#637](https://github.com/countries/countries/issues/637)
- Armenian translations are incorrect [\#622](https://github.com/countries/countries/issues/622)
- Please cut a release [\#610](https://github.com/countries/countries/issues/610)
- Please update i18n\_data to 0.10.0 [\#607](https://github.com/countries/countries/issues/607)
- Release '3.0.0' missing some commits [\#603](https://github.com/countries/countries/issues/603)
- Please release a new version [\#591](https://github.com/countries/countries/issues/591)
- 'Portugal' is misspelled in lib/countries/cache/locales/nn.json [\#583](https://github.com/countries/countries/issues/583)
- Any interest in fiscal year data? [\#532](https://github.com/countries/countries/issues/532)
- Kosovo independent from Serbia [\#511](https://github.com/countries/countries/issues/511)
- Include country's postcode/zip format [\#366](https://github.com/countries/countries/issues/366)

**Merged pull requests:**

- add find\_all\_by example to readme [\#667](https://github.com/countries/countries/pull/667) ([glaucocustodio](https://github.com/glaucocustodio))
- Add address\_format for Vietnam, fixes [\#652] [\#653](https://github.com/countries/countries/pull/653) ([pmor](https://github.com/pmor))
- "The United Kingdom" is an unofficial name for Great Britain [\#651](https://github.com/countries/countries/pull/651) ([RogerPodacter](https://github.com/RogerPodacter))
- UK is an unofficial name for Great Britain [\#648](https://github.com/countries/countries/pull/648) ([RogerPodacter](https://github.com/RogerPodacter))
- \[French\] Bad encoding for new zealand [\#643](https://github.com/countries/countries/pull/643) ([waghanza](https://github.com/waghanza))
- Update gemspec: i18n\_data 0.11.0 [\#640](https://github.com/countries/countries/pull/640) ([masawo](https://github.com/masawo))
- Add missing Latvia address\_format template [\#639](https://github.com/countries/countries/pull/639) ([RogerPodacter](https://github.com/RogerPodacter))
- Used the common name República Checa in PT [\#635](https://github.com/countries/countries/pull/635) ([basex](https://github.com/basex))
- Fix China subdvivisions iso code see https://en.wikipedia.org/wiki/IS… [\#632](https://github.com/countries/countries/pull/632) ([daniel88m](https://github.com/daniel88m))
- Use AUD currency for Tuvalu [\#629](https://github.com/countries/countries/pull/629) ([mayrsascha](https://github.com/mayrsascha))
- Add country code 672 to HM [\#626](https://github.com/countries/countries/pull/626) ([wongyouth](https://github.com/wongyouth))
- \[GB\] Add unofficial names for ERY [\#620](https://github.com/countries/countries/pull/620) ([carlesjove](https://github.com/carlesjove))
- \[ES\] Add unofficial names + translations + remove weird characters [\#619](https://github.com/countries/countries/pull/619) ([carlesjove](https://github.com/carlesjove))
- Add data & script to update postal code & format [\#618](https://github.com/countries/countries/pull/618) ([cover](https://github.com/cover))
- Fixes failing rspec assertions after cache update [\#617](https://github.com/countries/countries/pull/617) ([rposborne](https://github.com/rposborne))
- Potential solution for thread safety [\#608](https://github.com/countries/countries/pull/608) ([hammerdr](https://github.com/hammerdr))
- Fix a typo in 'Portugal' [\#602](https://github.com/countries/countries/pull/602) ([mbirman](https://github.com/mbirman))
- added CL standard VAT [\#578](https://github.com/countries/countries/pull/578) ([tiagomatos](https://github.com/tiagomatos))
- Remove Puerto Rico subdivisions [\#539](https://github.com/countries/countries/pull/539) ([philipefarias](https://github.com/philipefarias))

## [v3.0.1](https://github.com/countries/countries/releases/tag/v3.0.1) (2020/02/11 00:04 +05:00)

[Full Changelog](https://github.com/hexorx/countries/compare/v3.0.0...v3.0.1)

**Closed issues:**

- Accessing all ISO 639-1 language codes [\#604](https://github.com/hexorx/countries/issues/604)
- County ISO and translations for Cork County \(Ireland\) in invalid [\#594](https://github.com/hexorx/countries/issues/594)
- Chile added Ñuble Region [\#592](https://github.com/hexorx/countries/issues/592)
- Samoa currency code should be WST [\#584](https://github.com/hexorx/countries/issues/584)
- Mauritanian currency code is changed [\#568](https://github.com/hexorx/countries/issues/568)
- Czech Republic changed it's name to Czechia [\#560](https://github.com/hexorx/countries/issues/560)
- Swaziland renamed to eSwatini [\#521](https://github.com/hexorx/countries/issues/521)

**Merged pull requests:**

- Update UK EU and EEA status [\#615](https://github.com/hexorx/countries/pull/615) ([carlesjove](https://github.com/carlesjove))
- Add "The Netherlands" as an unofficial name of NL [\#614](https://github.com/hexorx/countries/pull/614) ([RogerPodacter](https://github.com/RogerPodacter))
- CI: Drop unused sudo: false directive [\#613](https://github.com/hexorx/countries/pull/613) ([olleolleolle](https://github.com/olleolleolle))
- Samoa currency is WST [\#599](https://github.com/hexorx/countries/pull/599) ([mbirman](https://github.com/mbirman))
- Add Ñuble region [\#598](https://github.com/hexorx/countries/pull/598) ([mbirman](https://github.com/mbirman))
- Update Ireland Subdivision Formatting and Connacht and \(County\) Cork Data [\#596](https://github.com/hexorx/countries/pull/596) ([anastasiastowers](https://github.com/anastasiastowers))
- Change the name of Macedonia to North Macedonia [\#585](https://github.com/hexorx/countries/pull/585) ([svetliomihailov](https://github.com/svetliomihailov))
- Add Murica to United States unoffical names [\#577](https://github.com/hexorx/countries/pull/577) ([mikeyduece](https://github.com/mikeyduece))
- Fix state codes from being returned as false [\#574](https://github.com/hexorx/countries/pull/574) ([akiellor](https://github.com/akiellor))
- Update i18n\_data version [\#572](https://github.com/hexorx/countries/pull/572) ([tatarsky-v](https://github.com/tatarsky-v))
- remove bin/console from gemspec [\#571](https://github.com/hexorx/countries/pull/571) ([patleb](https://github.com/patleb))
- Add North Macedonia as alternate name [\#570](https://github.com/hexorx/countries/pull/570) ([toddwschneider](https://github.com/toddwschneider))
- Update Mauritanian currency code [\#569](https://github.com/hexorx/countries/pull/569) ([vencislavdimitrov](https://github.com/vencislavdimitrov))
- Update name of SZ to eSwatini \(was Swaziland\) [\#567](https://github.com/hexorx/countries/pull/567) ([rossgayler](https://github.com/rossgayler))
- Fixed links to debian package iso-codes [\#566](https://github.com/hexorx/countries/pull/566) ([panterch](https://github.com/panterch))
- It should include language variants which are available in i18n\_data. [\#565](https://github.com/hexorx/countries/pull/565) ([torumori](https://github.com/torumori))
- Fix "it's"-related typos [\#563](https://github.com/hexorx/countries/pull/563) ([RogerPodacter](https://github.com/RogerPodacter))
- Add Czechia as unofficial name for Czech Republic [\#561](https://github.com/hexorx/countries/pull/561) ([msdundar](https://github.com/msdundar))
- Drops the i18n requirement from the gem [\#558](https://github.com/hexorx/countries/pull/558) ([rposborne](https://github.com/rposborne))
- Add caching to the parsing of values during search [\#557](https://github.com/hexorx/countries/pull/557) ([radixhound](https://github.com/radixhound))
- 🇬🇧🇪🇺 Britain leaves the EU and EEA [\#500](https://github.com/hexorx/countries/pull/500) ([seanhandley](https://github.com/seanhandley))

### v2.2.0 (yanked and re-released as 3.0.0) (2018/12/17 10:20 +00:00)
**Closed issues:**

- Overriding/Extending Country class with custom methods [\#506](https://github.com/hexorx/countries/issues/506)
- fonts [\#503](https://github.com/hexorx/countries/issues/503)
- USA counties [\#501](https://github.com/hexorx/countries/issues/501)
- flags not working [\#489](https://github.com/hexorx/countries/issues/489)
- Proper way to only change a few subset of data [\#486](https://github.com/hexorx/countries/issues/486)

**Merged pull requests:**

- Relax i18n gemspec  [\#553](https://github.com/hexorx/countries/issues/553)
- Update cache [\#549](https://github.com/hexorx/countries/pull/549) ([jgrau](https://github.com/jgrau))
- Update cache [\#549](https://github.com/hexorx/countries/pull/549) ([jgrau](https://github.com/jgrau))
- Add dash to Nouvelle-Calédonie [\#547](https://github.com/hexorx/countries/pull/547) ([HLFH](https://github.com/HLFH))
- New currency\_code for Venezuela: VEF -\> VES [\#546](https://github.com/hexorx/countries/pull/546) ([madacol](https://github.com/madacol))
- More vat rates [\#544](https://github.com/hexorx/countries/pull/544) ([jgrau](https://github.com/jgrau))
- Consistently use single-quotes in code block [\#541](https://github.com/hexorx/countries/pull/541) ([orhantoy](https://github.com/orhantoy))
- Add Thailand vat rates [\#536](https://github.com/hexorx/countries/pull/536) ([jgrau](https://github.com/jgrau))
- Update and fix LatAm countries subdivisions [\#534](https://github.com/hexorx/countries/pull/534) ([philipefarias](https://github.com/philipefarias))
- Add feature toggle for countries to avoid money dependency [\#533](https://github.com/hexorx/countries/pull/533) ([stefkin](https://github.com/stefkin))
- Fixing language code for Urdu to ISO 639-2 [\#531](https://github.com/hexorx/countries/pull/531) ([dachusa](https://github.com/dachusa))
- Correcting syntax for YAML numeric list key 08 [\#530](https://github.com/hexorx/countries/pull/530) ([dachusa](https://github.com/dachusa))
- Rubocop style guides [\#527](https://github.com/hexorx/countries/pull/527) ([mrclmrvn](https://github.com/mrclmrvn))
- Added 20 subdivisions yaml files [\#526](https://github.com/hexorx/countries/pull/526) ([dachusa](https://github.com/dachusa))
- Created Anguilla Subdivision YAML file [\#525](https://github.com/hexorx/countries/pull/525) ([dachusa](https://github.com/dachusa))
- Correcting Ash Shamālīyah's translations location [\#524](https://github.com/hexorx/countries/pull/524) ([dachusa](https://github.com/dachusa))
- Singapore IOC code has changed [\#523](https://github.com/hexorx/countries/pull/523) ([pzupan](https://github.com/pzupan))
- \#519 correct NO subdivision key for Sudan's Ash Shamālīyah [\#520](https://github.com/hexorx/countries/pull/520) ([jlw](https://github.com/jlw))
- Fixed incorrect flag emoji in Readme example [\#518](https://github.com/hexorx/countries/pull/518) ([keithpitt](https://github.com/keithpitt))
- Corrected VAT rates of Greece [\#516](https://github.com/hexorx/countries/pull/516) ([gauda](https://github.com/gauda))
- correct currency for Haiti [\#515](https://github.com/hexorx/countries/pull/515) ([genevievebelle](https://github.com/genevievebelle))
- Update LT.yaml [\#514](https://github.com/hexorx/countries/pull/514) ([s4uliu5](https://github.com/s4uliu5))
- \[CI\] Test against Ruby 2.1 and 2.5 [\#513](https://github.com/hexorx/countries/pull/513) ([nicolasleger](https://github.com/nicolasleger))
- Add zh translation for CN subdivisions [\#512](https://github.com/hexorx/countries/pull/512) ([wingice](https://github.com/wingice))
- Memoize subdivision YAML loading [\#510](https://github.com/hexorx/countries/pull/510) ([mdehoog](https://github.com/mdehoog))
- Update CZ country name [\#509](https://github.com/hexorx/countries/pull/509) ([minvs1](https://github.com/minvs1))
- Add Ukraine vat rates [\#507](https://github.com/hexorx/countries/pull/507) ([jgrau](https://github.com/jgrau))
- Corrected swedish transation for GB [\#505](https://github.com/hexorx/countries/pull/505) ([pidu](https://github.com/pidu))
- Remove empty :geo key and misspelled latitude [\#504](https://github.com/hexorx/countries/pull/504) ([normancapule](https://github.com/normancapule))
- Update README.markdown [\#502](https://github.com/hexorx/countries/pull/502) ([gssbzn](https://github.com/gssbzn))


### v2.1.4 (2018/02/09 01:52 +00:00)
- [#498](https://github.com/hexorx/countries/pull/498) Updated Switzerland VAT rates (@Aethelflaed)
- [#497](https://github.com/hexorx/countries/pull/497) Swedish translation correction of GB (@eric-khoury)
- [#493](https://github.com/hexorx/countries/pull/493) Add vat rates for Philippines (@jgrau)

## 2.1.3
- [#480](https://github.com/hexorx/countries/pull/480) Add subdivision names with codes (@md-hamed)
- [#490](https://github.com/hexorx/countries/pull/490) Fix search to work for countries with comma in their name (@bud-yoyo)
- [#488](https://github.com/hexorx/countries/pull/488) Update BY currency code (BYR -> BYN) (@mainameiz)
- [#487](https://github.com/hexorx/countries/pull/487) fix TW national_prefix (@swdyh)
- [#478](https://github.com/hexorx/countries/pull/478) Add vat rates for mexico (@jgrau)
- [#476](https://github.com/hexorx/countries/pull/476) Add standard vat rate for Norway (@jgrau)
- [#473](https://github.com/hexorx/countries/pull/473) Add CLDR data source for subdivion translations. (@rposborne)
- [#472](https://github.com/hexorx/countries/pull/472) Fix corrupted Subdivisions (@rposborne)

## 2.1.2
  -	Fix incorrectly named subdivision data files @skyborn8
  - Updates MX.yaml to reflect Mexico City's official name change @novohispano

## 2.1.1
  - Updated cache @rposborne
  - Add code attribute to Subdivision @kasparsj
  - Allow override of cache dir @kasparsj

## 2.1.0
  - Fix emoji support in old rubies < 2.0 @pezholio
  - Detect if active_support is loaded before using .html_safe @subfusc
  - Changed the nationality of Hong Kong from Chinese to Hong Kongnese @neosepulveda
  - Readme Cleanup @dankimio
  - Correct typo for Virgin Islands, U.S and add translation for Palestine @jpawlyn
  - Add new French Regions (january 2016) @clemthenem
  - Add Russian unofficial name to GB @faucct
  - Update gem i18n_data @seb-sykio

## 2.0.8
  - Add language data to Nepal @gkunwar
  - Add start of week day @Vsanchezr
  - Normalized Turkey's Subdivisions @emir

## 2.0.7
  - Content Fixes

## 2.0.6
  - Adds French Guiana nationality
  - Add missing un_locode for south sudan
  - Fix Norwegian country code (false -> NO)
  - Add missing un location codes
  - Further reduce calls to .keys to provide additional speedup and performance bump
  - Add sixarm_ruby_unaccent to gemspec dependencies
  - Update all official country names to the ISO 3166 standard
  - [Full Changelog](https://github.com/hexorx/countries/compare/v2.0.5...v2.0.6)

## 2.0.5
  - Fixes #408 Correct Subdivision files for AD, AE, AF, AG, and AL
  - [Full Changelog](https://github.com/hexorx/countries/compare/v2.0.4...v2.0.5)

## 2.0.4
  - Update cache.
  - [Full Changelog](https://github.com/hexorx/countries/compare/v2.0.3...v2.0.4)

## 2.0.3
  - Fix comparison with country to nil
  - Add NANP_prefix as separate field
  - [Full Changelog](https://github.com/hexorx/countries/compare/v2.0.2...v2.0.3)

## 2.0.2
  - Add nanp_prefix data.
  - [Full Changelog](https://github.com/hexorx/countries/compare/v2.0.1...v2.0.2)

## 2.0.1
  - Content updates
    - Fix bounding boxes that were mismatched.
  - Update bounding box update task to prevent any lookup from return anything other than a country.
  - [Full Changelog](https://github.com/hexorx/countries/compare/v2.0.0...v2.0.1)

## 2.0.0
- Remove find_country_by_translations
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.2.5...v2.0.0)
- [Changelog from RC](https://github.com/hexorx/countries/compare/v2.0.0.rc3...v2.0.0)

## 2.0.0.rc3
- Content updates
  - All geo cords, are no longer strings
  - All bounding boxes updated
  - United States is now United States of America
- Refactor of Rake tasks
- [Changelog from RC](https://github.com/hexorx/countries/compare/v2.0.0.rc2...v2.0.0.rc3)

## 2.0.0.rc2
- Add fallback when looking up locales for pt-BR style languages
- Implement project style guide
- [Changelog from RC](https://github.com/hexorx/countries/compare/v2.0.0.rc...v2.0.0.rc2)

## 2.0.0.rc
- Fixed a regression that would purge the countries memory cache when adding a custom country #353
- Various Content Updates
- [Changelog from RC](https://github.com/hexorx/countries/compare/v2.0.0.pre.4...v2.0.0.rc)

## 2.0.0.pre.4
- [Changelog from RC](https://github.com/hexorx/countries/compare/v2.0.0.pre.2...v2.0.0.pre.4)
- Fix crash when app introduces an unexpected locale. Much thanks to @jstenhouse

## 2.0.0.pre.2
- [Changelog from RC](https://github.com/hexorx/countries/compare/v2.0.0.pre...v2.0.0.pre.2)
- Bringing in content from 1.x branch

## 2.0.0.pre
- [Changelog from RC](https://github.com/hexorx/countries/compare/v1.2.5...v2.0.0.pre)
- Selective loading translations of countries
- Auto detect I18n locales to load
- Add Configuration methods to force locales to load
- Dropped currencies gem in favor of money
- Add Time Zone Support
- DATA STRUCTURE CHANGES
  -COUNTRY
    - BREAKING CHANGES
      - names: => unofficial_names
      - languages: => official_languages
      - lat/lng fields are nested under a "geo" key
    - + spoken_languages
    - +


## 1.2.5 @ 2016-01-22
- Rebuilding cache
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.2.4...v1.2.5)

## 1.2.4 @ 2016-01-21
- Romanian Standard VAT rate is 20% as of 2016-01-01 #325 @dougal
- Palestine submit #324 @samizan
- Added 47 as calling code for Bouvet Island, Norwegian territory #323
- Added XAF as currency code for Congo @espen
- Force converting passed locale to string @borodiychuk
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.2.3...v1.2.4)

## 1.2.3
- Content Updates
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.2.2...v1.2.3)

## 1.2.2
- Content Updates
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.2.1...v1.2.2)

## 1.2.1
- Fixed issue in loading @rposborne
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.2.0...v1.2.1)

## 1.2.0 (yanked)
- Cleaning up Global Load Path @rposborne
- Add MOP as the currency for Macao @kriskhaira
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.1.0...v1.2.0)

## 1.1.0
- Adding compare operation to country @guilleart
- Content Updates @rposbone
- Correct NL to NO for un_locode @ohenrik
- Fix spelling of Sjælland @boatrite
- Add alternate spelling of Macao/Macau @nityaoberoi
- [Full Changelog](https://github.com/hexorx/countries/compare/v1.0.0...v1.1.0)

## 1.0.0
- Switch to Marshalling for cache storage @rposborne
- Country class helper now must be explicitly loaded @rposborne
- Removed Rails 2.0 FormHelper COUNTRIES @rposborne
- Add class codes method to get list of all alpha2 codes @rposborne
- Change default behavior of all method to return a list of country objects vs a tuple of alpha code + name
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.11.5...v1.0.0)

## 0.11.5
- Refactored data loading into it's own class
- Added ability to override bad translations from i18n
- Update languages in NO.yml @matfiz
- Fix Subdivisions & States in README @pnomolos
- Fix New York, Washington, Oklahoma state's latitude/longitude information @GUI
- Bad state data present in Uruguay has been removed @saisha92
- Various Other Content Updates by @danshultz @embs @sykaeh, @tg0
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.11.4...v0.11.5)

## 0.11.4
- Added coordinates for subdivisions @fabn
- Various Other Content Updates by @fabn, @snowblink
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.11.3...v0.11.4)

## 0.11.3
- Translations update from i18n-data
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.11.2...v0.11.3)

## 0.11.2
- silence ruby warnings @franckverrot
- add find_country_by_translated_name @rposborne NOTE: this is garbage for the
  time being, some translations have duplicates in them and causes false results
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.11.1...v0.11.2)

## 0.11.1
- added bounding box coordinates for VI, CW, PR, AS, and GU : @marinom
- revert Lookup country by translated name via find_by_name @rposborne
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.11.0...v0.11.1)

## [0.11.0] - 2015-03-03
### Changed
- Cached Translations in gem to translation lookup speed @rposborne, @stayhero
- Upgrade test suite to rspec 3 @rposborne
- Added region_short for postal codes @stayhero
- Content Updates @masolino, @rosetree, @stayhero, @skarlcf, @cllns, @speric, @rposborne
- Adding Lat/Lng to countries @jabawack81
- Readme Updates @cllns
- [Full Changelog](https://github.com/hexorx/countries/compare/v0.10.0...v0.11.0)

### v0.10.0 (2015/01/23 05:58 +00:00)
- [#151](https://github.com/hexorx/countries/pull/151) Added VAT rates to EU countries (@cedricdubois)
- [#212](https://github.com/hexorx/countries/pull/212) Rename CU-02 to 'Provincia de la Habana' and CU-03 to 'La Habana' (@cllns)
- [#150](https://github.com/hexorx/countries/pull/150) Arabic Translations and names (@m7moud)
- [#187](https://github.com/hexorx/countries/pull/187) Added World Regions (APAC, EMEA, AMER) to countries. (@jeppester, @simonask)
- [#163](https://github.com/hexorx/countries/pull/163) Gems should not have their Gemfile.locks committed (@snowblink)
- [#111](https://github.com/hexorx/countries/pull/111) Corrected NZ national_prefix (@dnch)
- [#145](https://github.com/hexorx/countries/pull/145) adding 11 to national_number_lengths on Brazil because Sao Paulo city us... (@ustrajunior)
- [#153](https://github.com/hexorx/countries/pull/153) Corrected English spelling of Barbados (@just3ws)
- [#162](https://github.com/hexorx/countries/pull/162) adding latitude and longitude for Curaçao and Guadeloupe (@joshtaylor)
- [#169](https://github.com/hexorx/countries/pull/169) Define primary language of Malaysia as Malay (@maxwell, @kriskhaira)
- [#173](https://github.com/hexorx/countries/pull/173) Updated Russian Federation english translation: Russia to Russian Federation (@mikestone14)
- [#174](https://github.com/hexorx/countries/pull/174) Correct translation of Afghanistan for fr and es (@schatteleyn)
- [#180](https://github.com/hexorx/countries/pull/180) Add more names for some countries (@Baltazore)
- [#181](https://github.com/hexorx/countries/pull/181) Add 'Newfoundland', 'Yukon' to list of valid names and add missing French names. (@dwhelan)
- [#175](https://github.com/hexorx/countries/pull/175) Saint Barthélemy uses the Euro (@sugru)
- [#199](https://github.com/hexorx/countries/pull/199) Add Russian as Estonian language (@martinholmin)
- [#207](https://github.com/hexorx/countries/pull/207) Add Cuban Subdivisions - Artemisa and Mayabeque (@cllns)
- [#205](https://github.com/hexorx/countries/pull/205) Adding Address format for New Caledonia, Thailand and Liechtenstein (@rposborne)
- [#177](https://github.com/hexorx/countries/pull/177) Fix Country#equality method (@estum)
- [#157](https://github.com/hexorx/countries/pull/157) Update ES.yaml (@mediatainment)
- [#184](https://github.com/hexorx/countries/pull/184) Belarusian translations (@micrum)
- [#194](https://github.com/hexorx/countries/pull/194) Update Singapore subdivisions to reflect ISO-3166-2:SG (@speric)
- [#201](https://github.com/hexorx/countries/pull/201) Lithuania adopted the Euro on 2015-01-01 (@philippbosch)

### upstream-12-24-14+speric (2014/12/24 18:26 +00:00)
- [#156](https://github.com/hexorx/countries/pull/156) Add postal code knowledge (@maxwell)
- [#161](https://github.com/hexorx/countries/pull/161) fixed tests for 136 (@hexorx)
- [#142](https://github.com/hexorx/countries/pull/142) Latvia's currency is now the Euro (@sugru)
- [#141](https://github.com/hexorx/countries/pull/141) Add additional names for Russia & Ukraine (@uzbekjon)
- [#140](https://github.com/hexorx/countries/pull/140) adding NO- to the list of Norway counties. Based on the ISO 3166 description for Norway. (@miguelperez)
- [#137](https://github.com/hexorx/countries/pull/137) Update Japanese translation (@rono23)
- [#136](https://github.com/hexorx/countries/pull/136) Adding arabic translation for many countries (@OmarQunsul)
- [#130](https://github.com/hexorx/countries/pull/130) Added the method #all_translated(locale) that returns a list of translated country names. (@LostTie)
- [#127](https://github.com/hexorx/countries/pull/127) Add currency to Macedonia (MK) (@sluceno)
- [#125](https://github.com/hexorx/countries/pull/125) Update AT.yaml (@mediatainment)
- [#124](https://github.com/hexorx/countries/pull/124) Updated country name for Palestine (@stangel)
- [#119](https://github.com/hexorx/countries/pull/119) Myanmar currency is MMK (@zeto)
- [#123](https://github.com/hexorx/countries/pull/123) Update county names in Croatia (@toncid)
- [#129](https://github.com/hexorx/countries/pull/129) add missing german translations (@benben)
- [#128](https://github.com/hexorx/countries/pull/128) Fix Russian Federation instead Russia and fix and add RU.yml subdivisions translation (@mibamur)
- [#118](https://github.com/hexorx/countries/pull/118) Updated destination code and number lengths for Germany (@daniel-rikowski)
- [#121](https://github.com/hexorx/countries/pull/121) russian translation (@razum2um)
- [#117](https://github.com/hexorx/countries/pull/117) Changed Guernseys currency code to be in line with ISO4217. (@richardmcmillen-examtime)
- [#102](https://github.com/hexorx/countries/pull/102) Add "Francia" to names section of France. (@nosolosoftware)
- [#103](https://github.com/hexorx/countries/pull/103) Add method to get currency code from data, without ISO4217::Currency wrapper (@scarfacedeb)
- [#105](https://github.com/hexorx/countries/pull/105) Useful #to_s method (@lorddoig)
- [#96](https://github.com/hexorx/countries/pull/96) Feature/mongoid (@lorddoig)
- [#95](https://github.com/hexorx/countries/pull/95) Add EU membership to Croatia (@razor-rs)
- [#94](https://github.com/hexorx/countries/pull/94) make country instance creation case insensitive (@jeremywrowe)
- [#93](https://github.com/hexorx/countries/pull/93) Fix some spanish translations (@jrdi)
- [#90](https://github.com/hexorx/countries/pull/90) Updated countries.yaml with Dutch country names/translations. (@joost)
- [#89](https://github.com/hexorx/countries/pull/89) Add Dutch Caribbean (former Netherlands Antilles) countries. (@woodrow)
- [#87](https://github.com/hexorx/countries/pull/87) add armed forces subdivisions to united states (@jeremywrowe)
- [#82](https://github.com/hexorx/countries/pull/82) add subdivisions to morocco (@jeremywrowe)
- [#83](https://github.com/hexorx/countries/pull/83) add subdivisions to marshall islands (@jeremywrowe)
- [#84](https://github.com/hexorx/countries/pull/84) add subdivisions to italy (@jeremywrowe)
- [#85](https://github.com/hexorx/countries/pull/85) add subdivisions to hungary (@jeremywrowe)
- [#86](https://github.com/hexorx/countries/pull/86) added subdivisions to chile (@jeremywrowe)
- [#88](https://github.com/hexorx/countries/pull/88) Add waffle.io badge to readme (@waffleio)
- [#75](https://github.com/hexorx/countries/pull/75) Bangladesh Currency code is BDT (@bradleypriest)
- [#76](https://github.com/hexorx/countries/pull/76) italian and some missing spanish translations (@lorenzopagano)
- [#77](https://github.com/hexorx/countries/pull/77) Convert to string before downcasing find_all_by attribute comparison (@jeremywrowe, @npverni)
- [#80](https://github.com/hexorx/countries/pull/80) adds malta subdivisions (@jeremywrowe)
- [#81](https://github.com/hexorx/countries/pull/81) added additional subdivisions to Uganda (@jeremywrowe)
- [#74](https://github.com/hexorx/countries/pull/74) Update Mayotte (YT) country code from 269 to 262. (@illoyd)
- [#72](https://github.com/hexorx/countries/pull/72) Merge pull request #72 from jrdi/refactorize_complex_methods (@jrdi)
- [#69](https://github.com/hexorx/countries/pull/69) Add configuration and build status badge for Travis CI (@dwilkie)
- [#67](https://github.com/hexorx/countries/pull/67) ignore rvm (@dwilkie)
- [#71](https://github.com/hexorx/countries/pull/71) Merge pull request #71 from nettsundere/translations-spec (@nettsundere)
- [#68](https://github.com/hexorx/countries/pull/68) specify gem dependencies in gemspec as recommended in Gemfile (@dwilkie)
- [#66](https://github.com/hexorx/countries/pull/66) Documentation for in_eu? functionality (@jgrau)
- [#64](https://github.com/hexorx/countries/pull/64) Rwanda phone numbers are now 8 and 9 digits long. (@dondeng)
- [#61](https://github.com/hexorx/countries/pull/61) Initialize with wrong/not-present ISO should return nil (@jrdi)
- [#63](https://github.com/hexorx/countries/pull/63) Fix and add french translations (@caedes)
- [#60](https://github.com/hexorx/countries/pull/60) fix 'should return alternate names' spec (@jrdi)
- [#57](https://github.com/hexorx/countries/pull/57) replace .rvmrc file with .ruby-version and .ruby-gemset for new versions of rvm (@dwilkie)
- [#58](https://github.com/hexorx/countries/pull/58) Abbreviations for subdivisions in thailand (@dwilkie)
- [#55](https://github.com/hexorx/countries/pull/55) Japanese Translations of Countries (@pwim)
- [#54](https://github.com/hexorx/countries/pull/54) EU member state data (@kevinvandijk)
- [#53](https://github.com/hexorx/countries/pull/53) Don't depend on rails and country_select (@fschwahn)
- [#52](https://github.com/hexorx/countries/pull/52) Use country_select gem to provide country_select form helper (@eakret)
- [#51](https://github.com/hexorx/countries/pull/51) Correct Vietnam - reopen (@allika)
- [#1](https://github.com/hexorx/countries/pull/1) Change 'Viet Nam' to 'Vietnam'. (@allika)
- [#48](https://github.com/hexorx/countries/pull/48) Added missing continent data to Norway. (@gilbertmj)
- [#46](https://github.com/hexorx/countries/pull/46) add translations (@benben)
- [#45](https://github.com/hexorx/countries/pull/45) added and corrected german translations (@benben)
- [#44](https://github.com/hexorx/countries/pull/44) Fix country_options_for_select for when selected = nil (the default) (@rymai)
- [#43](https://github.com/hexorx/countries/pull/43) Prevent selected from being included twice in the HTML for country selector helper (@damonmorgan)
- [#42](https://github.com/hexorx/countries/pull/42) Divider for "priority countries" is still escaped (@damonmorgan)
- [#41](https://github.com/hexorx/countries/pull/41) Specs (@leemhenson)
- [#39](https://github.com/hexorx/countries/pull/39) Add south sudan (@josepjaume)
- [#38](https://github.com/hexorx/countries/pull/38) Nationalities from CIA database (@bartoszkopinski)
- [#32](https://github.com/hexorx/countries/pull/32) add continents (@lukkry)
- [#36](https://github.com/hexorx/countries/pull/36) Updated Libya's name (@yctay)
- [#35](https://github.com/hexorx/countries/pull/35) Country#find_all_by improved (@cibernox)
- [#34](https://github.com/hexorx/countries/pull/34) Country#all accepts a block to customize the output (@cibernox)
- [#33](https://github.com/hexorx/countries/pull/33) Fix Hungarian subdivisions (@macat)
- [#29](https://github.com/hexorx/countries/pull/29) Taiwan isn't a province of china. (@isieo)

### v0.8.3 (2012/08/19 16:54 +00:00)
- [#28](https://github.com/hexorx/countries/pull/28) Update lib/data/countries.yaml (@hugovk)
- [#27](https://github.com/hexorx/countries/pull/27) Updated currency of Estonia (EE) to EUR (since january 1st, 2011) (@markkorput)
- [#26](https://github.com/hexorx/countries/pull/26) Fix: Mark all country names as html_safe for compatibility with Rails 3.1.4 and above (@theozaurus)
- [#22](https://github.com/hexorx/countries/pull/22) Refactor internals to use Bundler for gem management instead of Jewler (@dwilkie)
- [#21](https://github.com/hexorx/countries/pull/21) Makes two Country instances compare as equal if they have the same data (@fj)

### v0.8.2 (2012/03/05 17:45 +00:00)
- [#18](https://github.com/hexorx/countries/pull/18) Use html_safe for country_select helper (@thibaudgg)
- [#15](https://github.com/hexorx/countries/pull/15) Adding IOC and UN/LOCODE (@unnu)

### v0.8.1 (2011/12/12 19:10 +00:00)
- [#13](https://github.com/hexorx/countries/pull/13) Cambodian Subdivision name change (@dwilkie)

### v0.8.0 (2011/12/12 07:25 +00:00)
- [#12](https://github.com/hexorx/countries/pull/12) UTF-8 Subdivision names (@dwilkie)

### v0.7.0 (2011/12/06 19:24 +00:00)
- [#11](https://github.com/hexorx/countries/pull/11) attribute based finder methods, override selected html option, fix for loading yaml. (@esfourteen)

### v0.6.3 (2011/11/22 07:40 +00:00)
- [#9](https://github.com/hexorx/countries/pull/9) Update country codes (@urbanwide)
- [#8](https://github.com/hexorx/countries/pull/8) remove single quote escapes from countries data (@esfourteen)
- [#7](https://github.com/hexorx/countries/pull/7) Added name to authors in gem specification (@joecorcoran)

### v0.6.2 (2011/09/20 01:52 +00:00)
- [#6](https://github.com/hexorx/countries/pull/6) Scope under module in select helper (@joecorcoran)

### v0.6.1 (2011/09/16 20:01 +00:00)
- [#4](https://github.com/hexorx/countries/pull/4) add find_country_by_name method, use downcase in find methods (@joecorcoran)

### v0.5.3 (2011/07/12 15:26 +00:00)
- [#3](https://github.com/hexorx/countries/pull/3) Fix FK country name. Thank you umka. (@umka)
