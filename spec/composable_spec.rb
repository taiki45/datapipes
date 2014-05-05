require 'spec_helper'

describe Datapipes::Composable do
  context 'with valid object' do
    let(:class_a) do
      Class.new do
        include Datapipes::Composable

        def call
          one
        end

        def one
          1
        end

        def exec
          accumulated.map(&:call)
        end
      end
    end

    let(:class_b) do
      Class.new do
        include Datapipes::Composable

        def call
          five
        end

        def five
          5
        end
      end
    end

    let(:a) { class_a.new }
    let(:b) { class_b.new }
    subject { a + b }

    it 'remember defined body' do
      expect(subject.exec).to eq [1, 5]
    end
  end

  context 'with tube' do
    let(:tube_a) do
      Class.new(Datapipes::Tube) do
        def run(data)
          data + 2
        end
      end.new
    end

    let(:tube_b) do
      Class.new(Datapipes::Tube) do
        def run(data)
          data * 3
        end
      end.new
    end

    subject { tube_a + tube_b }

    it 'generates new tube' do
      expect(subject.run_all(4)).to eq 18
    end
  end
end
