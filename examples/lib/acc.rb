# A sink is never called concurrently.
# On the other side, each sink can be called concurrently.
# So be careful to occur race condition in multi sinks.
class Acc < Datapipes::Sink
  attr_reader :stock

  def initialize
    @stock = []
  end

  def run(data)
    @stock << data
  end
end
