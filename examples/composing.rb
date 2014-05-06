require 'datapipes'

$: << File.expand_path('../lib', __FILE__)
require 'list'
require 'long_task'
require 'mul'
require 'triple'
require 'acc'

acc = Acc.new

source = List.new + LongTask.new(20..30)
tube = Mul.new >> Triple.new
sink = acc

datapipe = Datapipes.new(
  source,
  sink,
  tube: tube
)

datapipe.run_resource

p acc.stock
