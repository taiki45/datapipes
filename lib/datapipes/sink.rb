class Datapipes
  # Build your own sink logic in `run` method.
  class Sink
    include Composable

    def run_all(data)
      @accumulated ||= [self]
      @accumulated.each {|sink| sink.run(data) if sink.accept? data }
    end

    def accept?(data)
      true
    end
  end
end
