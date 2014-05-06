require 'spec_helper'

describe 'intact objects' do
  let(:datapipe) do
    Datapipes.new(
      Datapipes::Source.new,
      Datapipes::Sink.new
    )
  end

  it 'runs but occurs nothing' do
    expect { datapipe.run_resource }.not_to raise_error
  end
end
