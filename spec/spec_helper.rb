require 'pry'
require 'stringio'

require 'coveralls'
require 'simplecov'
Coveralls.wear!
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter 'spec'
end

$: << File.expand_path('../../lib', __FILE__)
require 'datapipes'
