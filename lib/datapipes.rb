require 'active_support/all'

require 'datapipes/composable'
require 'datapipes/source'
require 'datapipes/tube'
require 'datapipes/sink'
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
  end

  def run_resource
    source.pipe = pipe
    runners = source.run

    run_comsumer
    runners.each(&:join)
  end

  private

  def run_comsumer
    Thread.new do
      loop do
        catch :next do
          data = tube.run(pipe.pull)
          sink.run(data)
        end
      end
    end
  end
end
