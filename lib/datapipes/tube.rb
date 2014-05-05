class Datapipes
  # Tube takes effect data which passes through pipe.
  #
  # Build your own tube logic in `run` method.
  class Tube
    def >>(op2)
      op1 = self
      Tube.new.tap do |o|
        o.define_singleton_method(:run) do |data|
          data = op1.run(data) if op1.accept? data
          data = op2.run(data) if op2.accept? data
          data
        end
      end
    end

    def run(data)
      data
    end

    def accept?(data)
      true
    end
  end
end
