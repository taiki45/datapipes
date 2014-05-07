require 'datapipes'

$:.unshift File.expand_path('../lib', __FILE__)
require 'list'
require 'long_task'
require 'mul'
require 'triple'
require 'acc'
require 'reverse_acc'

acc = Acc.new
rev_acc = ReverseAcc.new

source = List.new + LongTask.new(21..30)
tube = Mul.new >> Triple.new
sink = acc + rev_acc

datapipe = Datapipes.new(
  source: source,
  sink: sink,
  tube: tube
)

datapipe.run_resource

p acc.stock
p rev_acc.stock
