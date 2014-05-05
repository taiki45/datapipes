class Datapipes
  # Build your own sink logic in `run` method.
  class Sink
    include Composable

    # TODO: parallel
    def run_all(data)
      @accumulated ||= [self]
      count = Parallel.processor_count
      Parallel.each(@accumulated, in_threads: count) do |sink|
        sink.run(data)
      end
    end
  end
end
