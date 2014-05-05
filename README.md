datapipes [![Build Status](https://travis-ci.org/taiki45/datapipes.svg?branch=master)](https://travis-ci.org/taiki45/datapipes) [![Code Climate](https://codeclimate.com/github/taiki45/datapipes.png)](https://codeclimate.com/github/taiki45/datapipes) [![Gem Version](https://badge.fury.io/rb/datapipes.svg)](http://badge.fury.io/rb/datapipes)
=========
datapipes is an asynchronous multi streaming library.

## About
datapipes encourages to handle multi streamings asynchronously. datapipes has
a few objects sparated by its responsibility.

- __Source__ Produces resources and emits the resource to pipe.
- __Tube__ Effector for resources. Processes resource in the middle of pipe.
- __Sink__ Consumer for resources. Do something with processed resources.
- __Pipe__ Resources pass through the pipe. Handles resources asynchronously.

```
 Source
   |   ↓ data flow
   |
  Tube
   |    pipe is '|'
   |
Consumer
```

To handle multi streamings, datapipes offers composabiliy. Source, Tube and Sink
are composable individually. So the diagram above will be:

```
 Composed Source works asynchronously

  [Source Source Source]
            |
            |  pipe handles asynchronous
            |
           Tube
           Tube  Composed Tube has individual tube in series
           Tube
           Tube
            |
            |
            |
           Sink
           Sink
           Sink

 Composed Sink works synchronously
```

## Installation

Add this line to your application's Gemfile:

    gem 'datapipes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datapipes

## Usage
You have to define your own Source, Tube and Sink.

A basic source is list type. it produces a value in several times.
Use `produce` method to emit data to pipe.

```ruby
class List < Datapipes::Source
  def run
    (1..10).each {|i| produce(i) }
  end
end
```

Next is tube. Tube processes piped data. A example tube recieve
Integer value then increase amount of the value.

Define `accept?` to recieve the data or skip this.

```ruby
class Triple < Datapipes::Tube
  def run(data)
    [data, data, data]
  end

  def accept?(data)
    data.is_a? Integer and data > 3
  end
end
```

Sink consumes piped data. A typical sink is printing data.

```ruby
class Print < Datapipes::Sink
  def run(data)
    puts data
  end

  def accept?(data)
    data.is_a? Array and data[0] < 7
  end
end
```

You can make your own datapipe with your objects.

```ruby
datapipe = Datapipes.new(
  List.new,           # A source
  Triple.new,         # A tube
  Print.new,          # A sink
  Datapipes::Pipe.new # A pipe
)
```

Then just run everything with `run_resource`.

```ruby
datapipe.run_resource
```

The output will be:

```
4
4
4
5
5
5
6
6
6
```

Congratulation!!

### Composing objects
TODO...

## Contributing

1. Fork it ( http://github.com/<my-github-username>/datapipes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
