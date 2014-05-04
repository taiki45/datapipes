class Datapipes
  module Basics
    class Triple < Tube
      def run(data)
        [data, data, data]
      end

      def accept?(_)
        true
      end
    end
  end
end
