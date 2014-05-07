require 'datapipes'
#
# You have to define your own Source, Tube and Sink.
#
$: << File.expand_path('../lib', __FILE__)
require 'list'
require 'triple'
require 'print'
#
# Then you can make your own datapipe with your objects.
#
datapipe = Datapipes.new(
  source: List.new,
  sink: Print.new,
  tube: Triple.new,
)

# Just run everything with `run_resource`.
datapipe.run_resource

# The output will be:
#
#   4
#   4
#   4
#   5
#   5
#   5
#   6
#   6
#   6
#
# Congratulation!!
