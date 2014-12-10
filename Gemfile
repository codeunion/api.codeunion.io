source 'https://rubygems.org'

ruby ENV.fetch('CUSTOM_RUBY_VERSION') { '2.0.0' }

gem 'rails', '4.2.0.rc2'
gem 'rails-api'

gem 'unicorn'
gem 'dotenv'
gem 'foreman'

gem 'pg'
gem 'pg_search'

group :development do
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
end
