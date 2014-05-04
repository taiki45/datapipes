class Datapipes
  module Basics
    class Print < Sink
      def core
        -> data { puts data }
      end

      def accept?(_)
        true
      end
    end
  end
end
