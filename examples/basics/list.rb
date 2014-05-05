class List < Datapipes::Source
  def run
    (1..10).each {|i| produce(i) }
  end
end
