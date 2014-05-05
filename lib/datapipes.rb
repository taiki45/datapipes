require 'datapipes/composable'
require 'datapipes/source'
require 'datapipes/tube'
require 'datapipes/sink'
require 'datapipes/pipe'
require 'datapipes/version'

class Datapipes
  # TODO: optional tube and pipe
  def initialize(source, tube, sink, pipe)
    @source = source
    @tube = tube
    @sink = sink
    @pipe = pipe

    Thread.abort_on_exception = true
    @flag = Queue.new
  end

  def run_resource
    @source.pipe = @pipe
    runners = @source.run_all

    consumer = run_comsumer
    runners.each(&:join)

    notify_resource_ending
    graceful_down(consumer)
  end

  private

  def run_comsumer
    Thread.new do
      loop do
        break if resource_ended? && @pipe.empty?

        data = @tube.run(@pipe.pull)
        @sink.run_all(data)
      end
      Thread.current.kill
    end
  end

  def notify_resource_ending
    @flag.enq true
    Thread.pass
  end

  def resource_ended?
    !@flag.empty?
  end

  def graceful_down(consumer)
    sleep 0.1
    consumer.kill if consumer.status == 'sleep'
    consumer.join
  end
end
