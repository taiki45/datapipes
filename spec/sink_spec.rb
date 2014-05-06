require 'spec_helper'

describe Datapipes::Sink do
  describe 'composable' do
    context 'with 3 sinks' do
      subject { sink_a + sink_b + sink_c }

      it 'composes' do
        subject.run_all(5)
        expect(list).to have(3).items
      end
    end

    context 'with 4 sinks' do
      subject { sink_a + sink_b + sink_c + sink_d }

      it 'composes' do
        subject.run_all(5)
        expect(list).to have(4).items
      end
    end

    describe 'associative law' do
      let(:a) { (sink_a + sink_b) + sink_c }
      let(:b) { sink_a + (sink_b + sink_c) }

      it 'keeps' do
        a.run_all(3)
        size_a = list.size
        list.clear

        b.run_all(3)
        size_b = list.size

        expect(size_a).to eq size_b
      end
    end

    let(:list) { Queue.new }

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

    let(:sink_c) do
      list_ = list
      Class.new(Datapipes::Sink) do
        define_method(:run) do |data|
          list_ << (data + 1)
        end
      end.new
    end

    let(:sink_d) do
      list_ = list
      Class.new(Datapipes::Sink) do
        define_method(:run) do |data|
          list_ << (data * 10)
        end
      end.new
    end

  end
end
