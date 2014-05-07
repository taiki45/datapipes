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
  # tube and pipe are optional.
  # If not given tube, a default tube which takes no effect is used.
  def initialize(source: Source.new, sink: Sink.new, tube: Tube.new, pipe: Pipe.new)
    @source, @sink, @tube, @pipe = source, sink, tube, pipe
    validate!
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

  def validate!
    invalids = {
      Source => @source,
      Sink => @sink,
      Tube => @tube,
      Pipe => @pipe
    }.select {|klass, arg| not arg.is_a? klass }

    message = invalids.map {|klass, _| klass.name.downcase }.join(', ')
    unless invalids.empty?
      raise ArgumentError.new("invalid arguments: #{message}")
    end
  end

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
end
