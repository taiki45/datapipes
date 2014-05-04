class Datapipes
  module Basics
    class List < Source
      def core
        -> { (1..10).each {|i| produce(i) } }
      end
    end
  end
end
