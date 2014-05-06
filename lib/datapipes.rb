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
  def initialize(source, sink, tube: Tube.new, pipe: Pipe.new)
    @source = source
    @tube = tube
    @sink = sink
    @pipe = pipe
  end

  # Run sources, data flow via pipe, tubes and sinks work.
  # Everything work with just call this method.
  #
  # When all sources finished producing, and all sinks did their jobs,
  # this method returns.
  def run_resource
    @source.pipe = @pipe
    runners = @source.run_all

    consumer = run_comsumer
    runners.each(&:join)

    notify_resource_ending
    consumer.join
  end

  private

  def run_comsumer
    Thread.new do
      loop do
        data = @pipe.pull
        break if resource_ended?(data)

        @sink.run_all(@tube.run(data))
      end
    end
  end

  def notify_resource_ending
    @pipe.recieve Notification.new
  end

  def resource_ended?(data)
    data.is_a? Notification
  end

  Notification = Class.new
end
