require 'spec_helper'

$: << File.expand_path('../../examples/lib', __FILE__)
require 'list'
require 'long_task'
require 'mul'
require 'triple'
require 'acc'

describe 'composability' do
  let(:acc) { Acc.new }
  let(:source) { List.new + LongTask.new(21..30) }
  let(:tube) { Mul.new >> Triple.new }

  let(:datapipe) do
    Datapipes.new(
      source,
      acc,
      tube: tube
    )
  end

  it 'runs without errors' do
    datapipe.run_resource
    expect(acc.stock).to have(20).items
  end
end
