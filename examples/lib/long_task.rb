class LongTask < Datapipes::Source
  def initialize(range)
    @range = range
  end

  def run
    @range.each do |n|
      produce n
    end
  end
end
