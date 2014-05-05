class Datapipes
  #
  # Build your own source logic in `run` method.
  # Use `produce` method to emitt data to pipe.
  #
  #   def run
  #     10.times {|i| produce(i) }
  #   end
  #
  class Source
    include Composable

    attr_accessor :pipe

    def run_all
      @accumulated ||= [self]
      @accumulated.map {|s| Thread.new { s.run } }
    end

    private

    def produce(data)
      pipe.recieve(data)
    end
  end
end
