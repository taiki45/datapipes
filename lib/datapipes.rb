require 'active_support/all'

require 'datapipes/composable'
require 'datapipes/source'
require 'datapipes/tube'
require 'datapipes/sink'
require 'datapipes/pipe'
require 'datapipes/version'

class Datapipes
  class << self
    def make(source, tube, sink, pipe)
      new do |new_one|
        new_one.source = source
        new_one.tube = tube
        new_one = sink
        new_one.pipe
      end
    end
  end

  attr_accessor :source, :tube, :sink, :pipe

  def initialize
    Thread.abort_on_exception = true
    yield self
    @flag = Queue.new
  end

  def run_resource
    source.pipe = pipe
    runners = source.run

    consumer = run_comsumer
    runners.each(&:join)

    notify_resource_ending
    consumer.join if consumer.status == "run"
  end

  private

  def run_comsumer
    Thread.new do
      loop do
        break if resource_ended? && pipe.empty?

        data = tube.run(pipe.pull)
        sink.run(data)
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
