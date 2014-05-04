class Datapipes
  class Sink
    include Composable
    core {}

    def run(data)
      accumulated.each {|sink| sink.call(data) if sink.accept? data }
    end

    def accept?(data)
      false
    end
  end
end
