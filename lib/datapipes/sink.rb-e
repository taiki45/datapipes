module Datapipes
  class Sink
    include Composable

    def run_sink(data)
      bodies.each {|sink| sink.call(data) if sink.accept? data }
    end
  end
end
