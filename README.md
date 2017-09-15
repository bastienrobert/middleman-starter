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

## Build
If you want to use `critical gem`, you have to install `critical npm module` before with the following command :
```
npm install -g critical
```

Than, if you want to use `imageoptim` without `image_optim_pack`, please check the followings has already been installed (open your terminal and type) :

```
brew install advancecomp gifsicle jhead jpegoptim jpeg optipng pngcrush pngquant jonof/kenutils/pngout
npm install -g svgo
```

Finally, run `middleman build` !


## Deploy
Using `middleman deploy`.

### Netlify
You can setup this template on Netlify with the middleman-netlify template : https://github.com/bastienrobert/middleman-netlify

### Github pages
Make sure that `git` is installed, and activate the extension by adding the
following to `config.rb`:

```ruby
activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
```

### FTP
Activate the extension by adding the following to `config.rb`:

```ruby
activate :deploy do |deploy|
  deploy.deploy_method   = :ftp
  deploy.host            = 'ftp.example.com'
  deploy.path            = '/srv/www/site'
  deploy.user            = 'tvaughan'
  deploy.password        = 'secret'
end
```

### SFTP
Activate the extension by adding the following to `config.rb`:

```ruby
activate :deploy do |deploy|
  deploy.deploy_method   = :sftp
  deploy.host            = 'sftp.example.com'
  deploy.port            = 22
  deploy.path            = '/srv/www/site'
  # Optional Settings
  # deploy.user     = 'tvaughan' # no default
  # deploy.password = 'secret' # no default
end
```

### Heroku
Create **Rakefile** and add the following code :
```
namespace :assets do
  task :precompile do
    sh 'middleman build'
  end
end
```
Then, add a new file named **config.ru** :
```
require "rack"
require "rack/contrib/try_static"

# Enable proper HEAD responses
use Rack::Head

# Add basic auth if configured
if ENV["HTTP_USER"] && ENV["HTTP_PASSWORD"]
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == [ENV["HTTP_USER"], ENV["HTTP_PASSWORD"]]
  end
end

# Attempt to serve static HTML files
use Rack::TryStatic,
    :root => "build",
    :urls => %w[/],
    :try => ['.html', 'index.html', '/index.html']

# Serve a 404 page if all else fails
run lambda { |env|
  [
    404,
    {
      "Content-Type" => "text/html",
      "Cache-Control" => "public, max-age=60"
    },
    File.open("build/404/index.html", File::RDONLY)
  ]
}
```
Finally, add a **Procfile** :
```
web: bundle exec puma -p $PORT
```


## Todo (later)
- When `middleman-robots` will be fixed, let'update it to '> 1.3.2' (1.3.2 is bugged)
