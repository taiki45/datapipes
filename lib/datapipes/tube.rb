class Datapipes
  # Tube takes effect data which passes through pipe.
  # If a tube does not want to take effect, just pass data.
  class Tube
    include Composable
    core {}

    def run(data)
      accumulated.reduce(data) do |d, tube|
        tube.accept?(d) ? tube.call(d) : d
      end
    end

    def accept?(data)
      false
    end
  end
end
