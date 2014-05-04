class Datapipes
  module Basics
    class Triple < Tube
      def run(data)
        [data, data, data]
      end

      def accept?(data)
        data.is_a? Integer and data > 3
      end
    end
  end
end
