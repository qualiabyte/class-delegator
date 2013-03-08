
# ClassDelegator

Delegates class methods to a member instance.  
Designed for use with CoffeeScript classes, but JavaScript should work too!


## Example

```coffee-script
# ClassDelegator provides `delegate` as a static method.
{delegate} = require 'class-delegator'

# Ducks go quack!
class Duck
  quack: ->
    console.log 'quack!'

# Pets delegates Duck behavior to the `duck` member instance.
class Pets
  delegate @, 'duck', Duck
  constructor: ->
    @duck = new Duck()

# Create a new pets instance (with duck member).
pets = new Pets()

# Pets leaves the quacking to the duck!
pets.quack()
```


## Install

```bash
$ npm install 'class-delegator'
```


## API

### ClassDelegator = require('class-delegator')

Provides the ClassDelegator module.

```coffee-script
ClassDelegator = require('class-delegator')
```

### .delegate( delegatorClass, memberName, delegateClass )

Delegates class methods to a member instance.

**Params**
+ `delegatorClass` *Function* The class which will delegate.
+ `memberName` *String* The name of the member instance.
+ `delegateClass` *Function* The delegated class.

**Example**
```coffee-script
delegate = ClassDelegator.delegate

class Foo
  doFoo: -> return 'foo!'

class Bar
  doBar: -> return 'bar!'

class FooBar
  delegate @, 'foo', Foo
  delegate @, 'bar', Bar

  constructor: ->
    @foo = new Foo()
    @bar = new Bar()

fooBar = new FooBar()

fooBar.doFoo()
fooBar.doBar()
```

## License
MIT
