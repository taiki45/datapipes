class Datapipes
  class Sink
    include Composable

    def run(data)
      accumulated.each {|sink| sink.call(data) if sink.accept? data }
    end
  end
end
