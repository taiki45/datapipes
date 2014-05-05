class Triple < Datapipes::Tube
  def run(data)
    if accept? data
      [data, data, data]
    else
      data
    end
  end

  def accept?(data)
    data.is_a? Integer and data > 3
  end
end
