require 'parallel'
require 'datapipes/composable'
require 'datapipes/source'
require 'datapipes/tube'
require 'datapipes/sink'
require 'datapipes/pipe'
require 'datapipes/version'

Thread.abort_on_exception = true

class Datapipes
  # Pass datapipes components instances.
  # Each component can be composed. See detail in examples.
  #
  # Pass parameters as a hash:
  #
  #   datapipe = Datapipes.new(source: my_source, sink: my_sink)
  #
  # Or pass all:
  #
  #   datapipe = Datapipes.new(
  #     source: my_source,
  #     sink: my_sink,
  #     tube: my_tube,
  #     pipe: my_pipe
  #   )
  #
  # All arguments are  optional. But in most case, you specify
  # source and sink.
  def initialize(args = {})
    @source, @sink, @tube, @pipe = *ArgParser.extract(args)
  end

  # Run sources, data flow via pipe, tubes and sinks work.
  # Everything work with just call this method.
  #
  # When all sources finished producing, and all sinks did their jobs,
  # this method returns.
  def run_resource
    @source.pipe = @pipe
    runners = @source.run_all

    sink = run_sink
    runners.each(&:join)

    notify_resource_ending
    sink.join
  end

  private

  def run_sink
    Thread.new do
      loop do
        data = @pipe.pour_out
        break if resource_ended?(data)

        @sink.run_all(@tube.run(data))
      end
    end
  end

  def notify_resource_ending
    @pipe.pour_in Notification.new
  end

  def resource_ended?(data)
    data.is_a? Notification
  end

  Notification = Class.new

  module ArgParser
    def self.extract(args)
      source = args[:source] || Source.new
      sink = args[:sink] || Sink.new
      tube = args[:tube] || Tube.new
      pipe = args[:pipe] || Pipe.new
      [source, sink, tube, pipe]
    end
  end
end
