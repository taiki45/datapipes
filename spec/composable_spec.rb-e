require 'spec_helper'

describe Datapipes::Composable do
  context 'with valid object' do
    let(:dummy) do
      Class.new do
        include Datapipes::Composable
        attr_accessor :body
      end
    end

    let(:a) { dummy.new.tap {|o| o.body = 1 } }
    let(:b) { dummy.new.tap {|o| o.body = 5 } }
    subject { a + b }

    its(:bodies) { should have(2).items }
    its(:body) { should be_nil }
  end
end
