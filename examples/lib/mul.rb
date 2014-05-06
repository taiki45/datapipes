class Mul < Datapipes::Tube
  def run(data)
    if match? data
      data * 10
    else
      data
    end
  end

  def match?(data)
    data.is_a? Integer and data > 0
  end
end
