datapipes [![Build Status](https://travis-ci.org/taiki45/datapipes.svg?branch=master)](https://travis-ci.org/taiki45/datapipes)
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

To handle multi streamings, datapipes offers composable. Source, Tube and Sink
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

### Source
A basic source is list type. it produces a value in several times.
Use `produce` method to emit data to pipe.

```ruby
class Datapipes
  module Basics
    class List < Source
      def run
        (1..10).each {|i| produce(i) }
      end
    end
  end
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/datapipes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
