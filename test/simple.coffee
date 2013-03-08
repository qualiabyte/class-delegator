should      = require 'should'
{delegate}  = require '../class_delegator'

describe 'ClassDelegator', ->

  describe 'delegate( delegatorClass, memberName, delegateClass )', ->

    it 'should delegate method functionality to the named member', ->
      class Duck
        quack: -> return 'quack!'

      class Pets
        delegate @, 'duck', Duck
        constructor: ->
          @duck = new Duck()

      pets = new Pets()
      pets.quack().should.equal 'quack!'

    it 'should allow multiple levels of delegation', ->
      class Bird
        fly: -> return 'flying!'

      class Duck
        delegate @, 'bird', Bird
        quack: -> return 'quack!'
        constructor: ->
          @bird = new Bird()

      class Pets
        delegate @, 'duck', Duck
        constructor: ->
          @duck = new Duck()

      pets = new Pets()
      pets.fly().should.equal 'flying!'
      pets.quack().should.equal 'quack!'

    it 'should allow delegation to multiple members', ->
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

      fooBar.doFoo().should.equal 'foo!'
      fooBar.doBar().should.equal 'bar!'

    it 'should pass arguments when invoking a method', ->
      class Sum
        doSum: ->
          total = 0
          total += n for n in arguments
          return total

      class Operations
        delegate @, 'sum', Sum
        constructor: ->
          @sum = new Sum()

      ops = new Operations()
      ops.doSum(1, 2, 3).should.equal 6
