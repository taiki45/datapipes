require 'spec_helper'
require 'datapipes/basics'

describe Datapipes::Basics do
  before { $stdout = StringIO.new }
  after { $stdout = STDOUT }

  let(:datapipe) do
    Datapipes.new(
      Datapipes::Basics::List.new,
      Datapipes::Basics::Triple.new,
      Datapipes::Basics::Print.new,
      Datapipes::Pipe.new
    )
  end

  let(:out) do
    (4..6).map {|i| [i, i, i] }.join("\n") + "\n"
  end

  it 'runs without errors' do
    datapipe.run_resource
    expect($stdout.string).to eq out
  end
end
