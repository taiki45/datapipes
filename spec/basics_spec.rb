require 'spec_helper'
require 'datapipes/basics'

describe Datapipes::Basics do
  before { $stdout = StringIO.new }
  after { $stdout = STDOUT }

  let(:datapipe) do
    Datapipes.new do |datapipe|
      datapipe.source = Datapipes::Basics::List.new
      datapipe.tube = Datapipes::Basics::Triple.new
      datapipe.sink = Datapipes::Basics::Print.new
      datapipe.pipe = Datapipes::Pipe.new
    end
  end

  let(:out) do
    (4..6).map {|i| [i, i, i] }.join("\n") + "\n"
  end

  it 'runs without errors' do
    datapipe.run_resource
    expect($stdout.string).to eq out
  end
end
