source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem "rails", "~> 5.1.4"

# Database
gem "mysql2", ">= 0.3.18", "< 0.5"

# Rails server
gem "puma", "~> 3.7"

# Common
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem 'jquery-rails'
gem "turbolinks", "~> 5"

# Frontend
gem "font-awesome-rails"

# Upload file
gem "mini_magick"
gem "carrierwave", "~> 1.0"

# Setting
gem "config"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "pry-rails"
gem "pry-byebug"

# Elasticsearch
gem "searchkick", "~> 2.3", ">= 2.3.2"

group :development, :test do
  gem "pry-rails"
  gem "faker", git: "git://github.com/stympy/faker.git", branch: "master"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

