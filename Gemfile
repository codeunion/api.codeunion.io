source "https://rubygems.org"

ruby File.read(".ruby-version").chomp

gem "rails", "4.2.0"
gem "rails-api"
gem "rack-cors", require: "rack/cors"

gem "unicorn"

gem "pg"
gem "pg_search", git: "https://github.com/openspectrum/pg_search.git", ref: "72773"

gem "octokit", "3.7.0"

# The Oj JSON parser
gem "oj"
gem "oj_mimic_json"

# For bulk inserting data
gem "activerecord-import"

group :development do
  # Infrastructure
  gem "spring"
  gem "foreman"

  # Environment Setup
  gem "dotenv-rails"

  # Style + Documentation
  gem "rubocop"
  gem "yard"
end

group :test do
  gem "factory_girl_rails", "4.5.0"
  gem "rspec-rails", "3.2.1"
end

group :production do
  gem "rails_12factor"
end
