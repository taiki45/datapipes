class LongTask < Datapipes::Source
  def run
    (10..20).each do |n|
      sleep 0.1
      produce n
    end
  end
end
