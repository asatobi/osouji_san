# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 6.0.1'
gem 'puma', '~> 4.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'haml-rails'
gem 'jquery-rails'
gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons'
gem 'rails-i18n'

group :development, :test do
  gem 'mysql2', '~> 0.4.4'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
