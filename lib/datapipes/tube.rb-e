module Datapipes
  # Tube takes effect data which passes through pipe.
  # If a tube does not want to take effect, just pass data.
  class Tube
    include Composable

    def run_tupe(data)
      bodies.reduce(data) do |d, tube|
        tube.accept?(d) ? tube.call(d) : d
      end
    end
  end
end
