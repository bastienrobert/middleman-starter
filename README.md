# Middleman Starter
[![Code Climate](https://codeclimate.com/github/bastienrobert/middleman-starter/badges/gpa.svg)](https://codeclimate.com/github/bastienrobert/middleman-starter)
[![Known Vulnerabilities](https://snyk.io/test/github/bastienrobert/middleman-starter/badge.svg)](https://snyk.io/test/github/bastienrobert/middleman-starter)

Starter for middleman, using i18n and including a URL helper to translate the same page in a different language.

## URL helper
To translate the same page in a different language.
By default, :fr is the default_locale. It works with any other default locale or within it. These are the steps to setup :

- **config.rb :** precise your default_locale in mount_as_root
- __locales **.yml :__ for each locale, precise :
  - the title _title_ of the page (identifier)
  - the title translation : in locale.titles
  - subdirectories _dir_ in a list (URL direction)
  - subdirectories translation : in locale.paths (one by one, not a list)
- **views :** really simple, call `<%= link_translate(:fr) %>` to translate in `:fr`, do the same with `:en` to translate in `:en`
