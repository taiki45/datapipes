class Datapipes
  module Composable
    attr_accessor :accumulated

    def +(other)
      self.class.new.tap do |o|
        o.accumulated = [self, other] + (accumulated || [])
      end
    end
  end
end
