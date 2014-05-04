class Datapipes
  class Sink
    include Composable
    core {|data| data }

    def run(data)
      accumulated.each {|sink| sink.call(data) if sink.accept? data }
    end

    def accept?(data)
      false
    end
  end
end
