class Datapipes
  module Composable
    attr_accessor :accumulated

    # Source and Sink can't composed as function composition.
    # So accumulates composed objects internaly, then use them later.
    def +(op2)
      op1 = self
      op1_acc = (op1.accumulated || [op1])
      op2_acc = (op2.accumulated || [op2])
      self.class.new.tap do |o|
        o.accumulated = op1_acc + op2_acc
      end
    end
  end
end
