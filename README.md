# Eugeneral

Configuration driven behavior and logic.

## Description

Creates Generals which command your application. Creates objects whose behavior is driven by configuration.


## Installation

Add this line to your application's Gemfile:

    gem 'eugeneral'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eugeneral

## Usage

Let's say we have a YAML file with the following in ```command_list.yml```

```YAML
greater_than_five?:
  greater_than:
    - arg_number: 0
    - 5
less_than_ten?:
  less_than:
    - arg_number: 0
    - 10
between_five_and_ten?:
  and:
    - less_than:
      - arg_number: 0
      - 10
    - greater_than:
      - arg_number: 0
      - 5
```

Now let's use it:

```ruby
require 'eugeneral'

# get our configs from the file
command_list = File.read('command_list.yml')

# parse it into a general
general = Eugeneral::DSL::Parsers::YAML.new.parse(command_list)

# now let's use it
general.greater_than_five? 7 # true
general.greater_than_five? 3 # false

general.less_than_ten? 10 # false
general.less_than_ten? 9 # true

general.between_five_and_ten? 7 # true
general.between_five_and_ten? 3 # false
general.between_five_and_ten? 5 # false
general.between_five_and_ten? 11 # false
```

### DSL (YAML)

The top-level keys are always the resulting methods, so if we were to add:

```YAML
four_is_less_than_ten?:
  less_than:
    - 4
    - 10
```

your resulting general would have a method ```four_is_less_than_ten?``` which will always return true and, although might be a good reminder, is a pretty useless method to have around.

Beyond the top-level, every thing is either an argument or a command. A command is single key/value hash whose key is present in the parser's Vocabulary mapping. If the key isn't in the mapping, it's just treated as a hash.

Commands nested within other commands are resolved, and their values are then passed to the above command as arguments. In the example above:

```YAML
and:
  - less_than:
    - arg_number: 0
    - 10
```
the resolved value from ```arg_number``` is passed as the first argument of ```less_than```, which then resolves as an argument to the above ```and``` clause.

### Default Vocabulary

Out of the box, the following commands are available:

#### Comparison
* equal: takes an array of with two entries, returning true if they are equal to each other
* not_equal: the opposite of equal
* greater_than: compares an array of two arguments, returning true if the first is greater than the second
* greater_than_or_equal_to: Same as greater_than but also true if they're equal
* less_than: like greater_than, but true if the first is less than the second
* less_than_or_equal_to: like less_than, but also true if equal

#### Logic
* and: takes an array of arguments, returning true if all arguments resolve to true
* or: takes an array of arguments, returning true if any of them resolve to true
* not: takes a single argument, returning true if the argument resolves to false, and vice-versa

#### Arguments
When a General's command is called, it's called like any other method. To pass arguments from when the command is called, use the following commands in your configuration:
* arg_number: resolves positional arguments. In configuration, expects an argument specifying the argument position (starting at 0). if command ```fruit``` is called: ```fruit(:apple, :pear)``` ```arg_number: 0``` would be ```:apple```. Raises an error if it doesn't find anything at the specified location.
* arg_name: resolves named arguments (passed as a hash). ```foo(fruit: :apple)``` would resolve with ```:apple``` given ```arg_name: :fruit```.
* default_arg_number: Just like ```arg_number```, but takes a second argument which is the default value if the arguments passed do not contain an argument at the specified position.
* default_arg_name: just like ```arg_name``` but accepts a second argument specifying a default to use if the named argument is not specified.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/eugeneral/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
