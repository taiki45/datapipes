class Datapipes
  class Sink
    include Composable

    def run(data)
      accumulated.each {|sink| sink.call(data) }
    end
  end
end
