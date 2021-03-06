class Datapipes
  # Pipe is not only data pipeline but handling asynchronous.
  #
  # You can make your own pipe with database or something, but
  # becareful this object used in multi thread.
  #
  # If you make your own, you can override _initialize_, because
  # this is not used in internal.
  #
  # Then supply _pour_in_ and _pour_out_. _pour_out_ must occur
  # thread blocking when it is empty.
  class Pipe
    # You can override and don't need to call super in sub class.
    def initialize
      @queue ||= Queue.new
    end

    # Emit data to pipe.
    def pour_in(data)
      @queue.enq data
    end

    # _pour_out_ must cause thread blocking when it is empty.
    def pour_out
      @queue.deq
    end
  end
end
