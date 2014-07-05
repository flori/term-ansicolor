if ENV['START_SIMPLECOV'].to_i == 1
  require 'simplecov'
  SimpleCov.start do
    add_filter "#{File.basename(File.dirname(__FILE__))}/"
  end
end
if RUBY_VERSION >= '1.9' && ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end
require 'minitest/unit'
require 'test/unit'
require 'term/ansicolor'
