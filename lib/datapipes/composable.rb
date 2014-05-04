class Datapipes
  module Composable
    extend ActiveSupport::Concern
    def +(other)
      self.class.new.tap do |new_one|
        p = accumulated
        new_one.define_singleton_method(:accumulated) do
          p + other.accumulated
        end
      end
    end

    module ClassMethods
      def core(&body)
        define_method(:accumulated) do
          [-> { instance_eval(&body) }]
        end
      end
    end
  end
end
