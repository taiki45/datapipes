class Datapipes
  module Basics
    class Triple < Tube
      def core
        -> data { [data, data, data] }
      end
    end
  end
end
