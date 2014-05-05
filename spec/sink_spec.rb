require 'spec_helper'

describe Datapipes::Sink do
  describe 'composable' do
    let(:list) { [] }

    let(:sink_a) do
      list_ = list
      Class.new(Datapipes::Sink) do
        define_method(:run) do |data|
          list_ << (data + 3)
        end
      end.new
    end

    let(:sink_b) do
      list_ = list
      Class.new(Datapipes::Sink) do
        define_method(:run) do |data|
          list_ << (data * 4)
        end
      end.new
    end

    subject { sink_a + sink_b }

    it 'composes' do
      subject.run_all(5)
      expect(list).to have(2).items
    end
  end
end
