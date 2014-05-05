class Datapipes
  class Pipe
    def initialize
      @queue ||= Queue.new
    end

    def recieve(data)
      @queue.enq data
    end

    def pull
      @queue.deq
    end
  end
end
