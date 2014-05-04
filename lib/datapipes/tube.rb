class Datapipes
  # Tube takes effect data which passes through pipe.
  # If a tube does not want to take effect, just pass data.
  class Tube
    include Composable

    def run(data)
      accumulated.reduce(data) {|d, tube| tube.call(d) }
    end
  end
end
