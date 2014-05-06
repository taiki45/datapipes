class Datapipes
  # Build your own sink logic in `run` method.
  #
  # Be careful each sinks are executed concurrently.
  # Avoid race condition in multi sinks.
  #
  # This is bad:
  #
  #   $shared = []
  #
  #   class A < Datapipes::Sink
  #     def run(data)
  #       $shared << data
  #     end
  #   end
  #
  #   class B < Datapipes::Sink
  #     def run(data)
  #       $shared << data
  #     end
  #   end
  #
  # On the other hand, a sink is called serially. So you can
  # touch shared object in one sink logic.
  #
  # This is good:
  #
  #   class A < Datapipes::Source
  #     def initialize
  #       @shared = []
  #     end
  #
  #     def run(data)
  #       @shared << data
  #     end
  #   end
  #
  class Sink
    include Composable

    # Override this in sub class
    def run(data)
      data
    end

    # For internal uses.
    def run_all(data)
      @accumulated ||= [self]
      count = Parallel.processor_count
      Parallel.each(@accumulated, in_threads: count) do |sink|
        sink.run(data)
      end
    end
  end
end
