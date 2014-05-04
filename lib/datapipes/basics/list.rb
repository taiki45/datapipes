module Datapipes
  module Basics
    class List < Source
      core do
        (1..10).each {|i| produce(i) }
      end
    end
  end
end
