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

    def run
      accumulated.map {|r| Thread.new { r.call } }
    end

    core { }

    private

    def produce(data)
      Datapipes::Pipe.recieve(data)
    end
  end
end
