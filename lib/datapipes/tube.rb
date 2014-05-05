class Datapipes
  # Tube takes effect data which passes through pipe.
  #
  # Build your own tube logic in `run` method.
  class Tube
    def >>(op2)
      op1 = self
      Tube.new.tap do |o|
        o.define_singleton_method(:run) do |data|
          op2.run(op1.run(data))
        end
      end
    end

    def run(data)
      data
    end
  end
end
