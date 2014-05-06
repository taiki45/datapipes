require 'pry'
require 'stringio'

require 'coveralls'
require 'simplecov'
Coveralls.wear!
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter 'spec'
  add_filter 'examples'
end

$: << File.expand_path('../../lib', __FILE__)
require 'datapipes'
