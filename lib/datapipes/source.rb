class Datapipes
  #
  # Build your own source logic in core block.
  # Use produce to emitt data to pipe.
  #
  #   core do
  #     10.times {|i| produce(i) }
  #   end
  #
  class Source
    include Composable
    core {}

    attr_accessor :pipe

    def run
      accumulated.map {|r| Thread.new { r.call } }
    end

    private

    def produce(data)
      pipe.recieve(data)
    end
  end
end
