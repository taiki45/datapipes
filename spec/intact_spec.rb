require 'spec_helper'

describe 'intact objects' do
  context 'with intact all' do
    let(:datapipe) do
      Datapipes.new
    end

    it 'runs without any errors' do
      expect { datapipe.run_resource }.not_to raise_error
    end
  end

  context 'with intact tube and sink' do
    let(:source) do
      Class.new(Datapipes::Source) do
        def run
          10.times {|i| produce(i) }
        end
      end.new
    end

    let(:datapipe) { Datapipes.new(source: source) }

    it 'runs without any errors' do
      expect { datapipe.run_resource }.not_to raise_error
    end
  end
end
