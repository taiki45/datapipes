module Datapipes
  class Source
    include Composable

    def run_resource
      bodies.map {|r| Thread.new { r.call } }
    end

    # Override
    def body
      -> { }
    end

    private

    def produce(data)
      Datapipes::Pipe.recieve(data)
    end
  end
end
