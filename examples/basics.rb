require 'datapipes'

$: << File.expand_path('../basics', __FILE__)
require 'list'
require 'triple'
require 'print'

datapipe = Datapipes.new(
  List.new,        # A source
  Print.new,       # A sink
  tube: Triple.new,
)

datapipe.run_resource
