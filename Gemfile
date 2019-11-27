source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in pr-pin.gemspec
gemspec

group :test do
  gem 'rom-factory', github: 'AMHOL/rom-factory', branch: 'fix/non-standard-output-schemas'
end
