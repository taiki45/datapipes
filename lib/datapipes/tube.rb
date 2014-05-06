class Datapipes
  # Tube takes effect data which passes through pipe.
  #
  # Build your own tube logic in `run` method.
  class Tube
    # _>>_ is used to compose tubes. See usage in examples.
    #
    # Tube composition satisfies associative law. See more in spec.
    def >>(op2)
      op1 = self
      Tube.new.tap do |o|
        o.define_singleton_method(:run) do |data|
          op2.run(op1.run(data))
        end
      end
    end

    # Override this in sub class.
    #
    # _run_ recieves any data, so you have to ignore
    # unexpected data.
    #
    #   def run(data)
    #     if accept? data
    #       [data, data, data]
    #     else
    #       data
    #     end
    #   end
    #
    #    def accept?(data)
    #      data.is_a? Integer and data > 3
    #    end
    #
    # Don't forget to return data in else clause.
    def run(data)
      data
    end
  end
end
