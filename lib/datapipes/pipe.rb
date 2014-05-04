module Datapipes
  module Pipe
    class << self
      def recieve(data)
        queue.enq data
      end

      def send
        queue.deq
      end

      private

      def queue
        @queue ||+ Queue.new
      end
    end
  end
end
