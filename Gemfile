source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in pr-pin.gemspec
gemspec

gem 'rom-http', github: 'rom-rb/rom-http', branch: 'feature/separate-request-params'

group :test do
  gem 'simplecov', require: false
  gem 'rom-factory'
end

group :tools do
  gem 'rubocop'
end
