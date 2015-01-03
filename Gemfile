source 'https://rubygems.org'

ruby ENV.fetch('CUSTOM_RUBY_VERSION') { '2.0.0' }

gem 'rails', '4.2.0.rc2'
gem 'rails-api'

gem 'unicorn'

gem 'pg'
gem 'pg_search', git: 'https://github.com/openspectrum/pg_search.git', ref: '72773'


gem 'nokogiri', '1.6.5'
gem 'faraday',  '0.9.0'
gem 'reverse_markdown', '0.6.0'

group :development do
  gem 'spring'
  gem 'dotenv'
  gem 'foreman'
  gem 'yard'
end

group :test do
  gem 'factory_girl_rails', '4.5.0'
  gem 'rspec-rails', '3.1.0'
end

group :production do
  gem 'rails_12factor'
end
