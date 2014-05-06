class Datapipes
  # Build your own source logic in `run` method.
  # Use `produce` method to emitt data to pipe.
  #
  #   def run
  #     10.times {|i| produce(i) }
  #   end
  #
  # You can use infinitie stream like:
  #
  #   def run
  #     twitter_client.userstream do |event|
  #       produce(event)
  #     end
  #   end
  #
  class Source
    include Composable

    # Run accumulated sources which are set by composition.
    # Each source works in new thread.
    def run_all
      @accumulated ||= [self]
      set_pipe
      @accumulated.map {|s| Thread.new { s.run } }
    end

    # For internal uses. Do not touch.
    attr_accessor :pipe

    private

    def produce(data)
      @pipe.recieve(data)
    end

    def set_pipe
      @accumulated.each {|s| s.pipe = @pipe }
    end
  end
end
