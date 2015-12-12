# Neddinna
[![Code Climate](https://codeclimate.com/github/andela-bebowe/neddinna/badges/gpa.svg)](https://codeclimate.com/github/andela-bebowe/neddinna)
[![Test Coverage](https://codeclimate.com/github/andela-bebowe/neddinna/badges/coverage.svg)](https://codeclimate.com/github/andela-bebowe/neddinna/coverage)
[![Issue Count](https://codeclimate.com/github/andela-bebowe/neddinna/badges/issue_count.svg)](https://codeclimate.com/github/andela-bebowe/neddinna)
[![Build Status](https://travis-ci.org/andela-bebowe/neddinna.svg?branch=master)](https://travis-ci.org/andela-bebowe/neddinna)

Neddinna is a [DSL](http://en.wikipedia.org/wiki/Domain-specific_language) for quickly creating light weight web applications in Ruby with really minimal effort. :)

## Installation

Add this line to your application"s Gemfile to install the gem:

```ruby
gem "neddinna"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install neddinna

## Usage

In your file e.g myapp.rb

###### myapp.rb

require "neddinna"

get "/" do

>"Hello Africa!"

end

Run with:

    $ ruby myapp.rb

View at http://localhost:4444

## Routes

Neddinna routes are HTTP methods paired with a URL matching pattern, each route is a method.

get "/" do
> Read/Display something

end

post "/" do
> Create some other thing

end

patch "/" do
> Modify something

end

Routes are matched by their definition and the first route that matches a request is invoked.
Route patterns may include named parameters, which can be gotten from the params hash:

get "/hello/:country" do
>"Hello #{params['country']}!"

end

## Views / Templates

Templates are assumed to be located directly under the `./views` directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-bebowe/neddinna. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
