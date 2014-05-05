require 'datapipes/composable'
require 'datapipes/source'
require 'datapipes/tube'
require 'datapipes/sink'
require 'datapipes/pipe'
require 'datapipes/version'

Thread.abort_on_exception = true

class Datapipes
  def initialize(source, sink, tube: Tube.new, pipe: Pipe.new)
    @source = source
    @tube = tube
    @sink = sink
    @pipe = pipe
  end

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
