class ReverseAcc < Datapipes::Sink
  attr_reader :stock

  def initialize
    @stock = []
  end

  def run(data)
    @stock.unshift data
  end
end
