# A basic source is list type. it produces a value in several times.
# Use `produce` method to emit data to pipe.
#
class List < Datapipes::Source
  def run
    (1..10).each {|i| produce(i) }
  end
end
