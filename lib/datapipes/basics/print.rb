class Datapipes
  module Basics
    class Print < Sink
      def run(data)
        puts data if accept? data
      end

      def accept?(data)
        data.is_a? Array and data[0] < 7
      end
    end
  end
end
