datapipes [![Gem Version](https://badge.fury.io/rb/datapipes.svg)](http://badge.fury.io/rb/datapipes)
=========
datapipes is an asynchronous multi streaming library.

[![Build Status](https://travis-ci.org/taiki45/datapipes.svg?branch=master)](https://travis-ci.org/taiki45/datapipes) [![Coverage Status](https://coveralls.io/repos/taiki45/datapipes/badge.png?branch=master)](https://coveralls.io/r/taiki45/datapipes?branch=master) [![Code Climate](https://codeclimate.com/github/taiki45/datapipes.png)](https://codeclimate.com/github/taiki45/datapipes) [![Dependency Status](https://gemnasium.com/taiki45/datapipes.svg)](https://gemnasium.com/taiki45/datapipes) [![Inline docs](http://inch-ci.org/github/taiki45/datapipes.png)](http://inch-ci.org/github/taiki45/datapipes)

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
  Sink
```

To handle multi streamings, datapipes offers composability. Source, Tube and Sink
are composable individually. So the diagram above will be:

```
 Composed Source works concurrently.

  [Source Source Source]
            |
            |  pipe handles asynchronous.
            |
           Tube
           Tube  Composed Tube has individual tube in series.
           Tube
           Tube
            |
            |
            |
     [Sink Sink Sink]

 Composed Sink works concurrently.
```

You can see how to compose objects in `examples/composing.rb`.

## Installation
__datapipes requires Ruby >= 2.0.__

Add this line to your application's Gemfile:

    gem 'datapipes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datapipes

## Usage
You have to define your own Source, Tube and Sink. See more in `examples`.

### Composing objects
See more in `examples/composing.rb`.

## Contributing

1. Fork it ( http://github.com/taiki45/datapipes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
