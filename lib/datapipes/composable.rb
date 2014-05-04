class Datapipes
  module Composable
    def +(other)
      self.class.new.tap do |new_one|
        p = accumulated
        new_one.define_singleton_method(:accumulated) do
          p + other.accumulated
        end
      end
    end

    def accumulated
      [core]
    end
  end
end
