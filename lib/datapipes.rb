require 'active_support/all'

require 'datapipes/composable'
require 'datapipes/source'
require 'datapipes/tube'
require 'datapipes/sink'
require 'datapipes/pipe'
require 'datapipes/version'

class Datapipes
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
    consumer.join if consumer.status == "run"
  end

  private

  def run_comsumer
    Thread.new do
      loop do
        break if resource_ended? && @pipe.empty?

        data = @tube.run_all(@pipe.pull)
        @sink.run_all(data)
      end
    end
  end

  def notify_resource_ending
    @flag.enq true
  end

  def resource_ended?
    !@flag.empty?
  end
end
