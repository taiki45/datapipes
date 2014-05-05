class Datapipes
  # Build your own sink logic in `run` method.
  class Sink
    include Composable

    # TODO: parallel
    def run_all(data)
      @accumulated ||= [self]
      @accumulated.each {|sink| sink.run(data) }
    end
  end
end
