module Datapipes
  module Composable
    attr_accessor :bodies

    def +(other)
      self.class.new.tap do |new_one|
        new_one.bodies = [body, other.body]
      end
    end
  end
end
