require 'spec_helper'

describe Datapipes::Composable do
  context 'with valid object' do
    let(:class_a) do
      Class.new do
        include Datapipes::Composable

        core { one }

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

        core { five }

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
end
