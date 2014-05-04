module Datapipes
  module Basics
    class Triple < Tube
      core do |data|
        if full?
          @triple
        else
          @triple << data
          throw :next
        end
      end

      def accept?(_)
        true
      end

      def initialize
        @triple = []
      end

      private

      def full?
        @triple.count > 2
      end
    end
  end
end
