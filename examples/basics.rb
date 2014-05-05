require 'datapipes'

class List < Datapipes::Source
  def run
    (1..10).each {|i| produce(i) }
  end
end

class Triple < Datapipes::Tube
  def run(data)
    [data, data, data]
  end

  def accept?(data)
    data.is_a? Integer and data > 3
  end
end

class Print < Datapipes::Sink
  def run(data)
    puts data
  end

  def accept?(data)
    data.is_a? Array and data[0] < 7
  end
end

datapipe = Datapipes.new(
  List.new,           # A source
  Triple.new,         # A tube
  Print.new,          # A sink
  Datapipes::Pipe.new # A pipe
)

datapipe.run_resource
