module Datapipes
  module Basics
    class Print < Sink
      core do |data|
        puts data
      end

      def accept?(_)
        true
      end
    end
  end
end
