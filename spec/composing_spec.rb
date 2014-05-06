require 'spec_helper'

$:.unshift File.expand_path('../../examples/lib', __FILE__)
require 'list'
require 'long_task'
require 'mul'
require 'triple'
require 'acc'
require 'reverse_acc'

describe 'composability' do
  let(:acc) { Acc.new }
  let(:rev_acc) { ReverseAcc.new }

  let(:source) { List.new + LongTask.new(21..30) }
  let(:tube) { Mul.new >> Triple.new }
  let(:sink) { acc + rev_acc }

  let(:datapipe) do
    Datapipes.new(
      source,
      sink,
      tube: tube
    )
  end

  it 'runs without errors' do
    datapipe.run_resource

    expect(acc.stock).to have(20).items
    expect(rev_acc.stock).to have(20).items
  end
end
