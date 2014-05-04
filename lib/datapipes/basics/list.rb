class Datapipes
  module Basics
    class List < Source
      def run
        (1..10).each {|i| produce(i) }
      end
    end
  end
end
