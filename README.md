# Code Union API

An HTTP API serving JSON data for Code Union resources.

## Installation

After cloning the repository, run

```shell-session
$ bundle install
$ bin/rake db:setup
$ bin/foreman start
```

**Note**: See below if `bundle exec` gives you an error along the lines of

```text
Your Ruby version is 2.1.5, but your Gemfile specified 2.0.0
```

## Using Vagrant/Docker
This is kind of an example of using Vagrant/Docker to run rails apps. It's by no
means a good example (omg, using linking between containers to expose databases?
NO! NO!)

But here's what it takes to get running:

1. Install vagrant + virtualbox
1. `cd` into this directory
1. `vagrant up`
1. `vagrant ssh` - Now you're in the vagrant VM instead of your computer.
1. `sudo service docker restart` - For some reason, docker won't mount things
1                                  that are vagrant shares.
1. `cd /src`
1. `make start-docker-postgres` - Now postgres is ready for data!
1. Open a new terminal tab.
1. `vagrant ssh`
1. `cd /src`
1. `make build-docker` - This will build the initial docker image that we'll use
                         to run the app as well as install any gems.
1. `make run-docker-bash` - Now you've got a BASH prompt to poke at inside of
                            the rails environment. 
1. `createdb -u postgres -h postgres db` - Create a database to do stuff with
1. `bin/rspec` - Run the tests! (For some reason, this is *horribly slow*)
1. In a new tab, vagrant ssh in and run `make start-docker-rails` to boot app.

## Deploying

Assuming access the following heroku apps:

* Production: `git@heroku.com:api-codeunion-io.git`
* Staging: `git@heroku.com:api-codeunion-io-staging.git`

We deploy by:

* Pushing to the appropriate remote (staging first! Then production)
* Running any migrations
* Smoke-testing

An example terminal session is as follows:

```shell-session
$ git push staging
...
$ heroku run bin/rake db:migrate --app api-codeunion-io-staging
...
$ curl http://api-codeunion-io-staging.herokuapp.com/v1/search?query=JavaScript
```

### Ruby Version

Heroku recommends we specify the version of Ruby to use in our
[Gemfile](Gemfile), which we do.  We read the version from an environment
variable named `CUSTOM_RUBY_VERSION`.  Otherwise, we use Heroku's
default Ruby version of `2.0.0`.

If you want to use a different version of Ruby locally, just set the
`CUSTOM_RUBY_VERSION` environment variable by adding a line like this to
`~/.bash_profile`:

```text
export CUSTOM_RUBY_VERSION="2.1.5"
```

## Usage

The base URL is `https://api.codeunion.com/v1/`.

As of now no authentication is required.

### Rake commands

#### resources:create[category,github-url]

```
# Creates or updates a given resource
bin/rake resources:create[exercise,https://github.com/codeunion/rpm-calculator]
```

### Endpoints

#### Search resources

Find resources whose text contains a particular query

```
GET /v1/search?:query_params
```

##### Parameters

Name | Type | Description | Required
-----|------|-------------|---------
query | string | Search query | true
category | string | See supported categories in `app/models/resource.rb` | false

##### Request

```
GET /v1/search?category=examples&query=REST%20API
```

##### Response

```json
[
  {
    "name": "overheard-server",
    "description": "Example project for a web app that stores and shares hilarious, out of context quotess and quips.",
    "private": false,
    "url": "https://github.com/codeunion/overheard-server",
    "category": "examples",
    "tags": [
      "ruby",
      "sinatra",
      "datamapper",
      "sqlite"
    ],
    "access": [
      "public",
      "students",
      "staff"
    ],
    "license": true,
    "has_wiki": false,
    "notes": "",
    "excerpt": "<match>REST</match> <match>API</match> to add and list Overheards\n\nFor a list of planned and implemented features, known bugs, etc. check the\n[CHANGELOG"
  }
]
```
