source 'https://rubygems.org'

ruby ENV.fetch('CUSTOM_RUBY_VERSION') { '2.0.0' }

gem 'rails', '4.2.0.rc2'
gem 'rails-api'

gem 'unicorn'

gem 'pg'
gem 'pg_search', git: 'https://github.com/openspectrum/pg_search.git', ref: '72773'

group :development do
  gem 'spring'
  gem 'dotenv'
  gem 'foreman'
end

group :production do
  gem 'rails_12factor'
end
