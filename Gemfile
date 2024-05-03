# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "pry"

eval_gemfile "gemfiles/rubocop.gemfile"

local_gemfile = "Gemfile.local"

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Security/Eval
else
  gem "activerecord", "~> 7.0"
end
