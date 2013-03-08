
#
# ClassDelegator delegates class methods to a member instance.
#
class ClassDelegator

  # Delegates class methods to a member instance.
  #
  #     class Duck
  #       quack: ->
  #         console.log 'quack!'
  #
  #     class Pets
  #       delegate @, 'duck', Duck
  #       constructor: ->
  #         @duck = new Duck()
  #
  # @api public
  # @param [Function] delegatorClass The class which will delegate.
  # @param [String]   memberName     The name of the member instance.
  # @param [Function] delegateClass  The delegated class.
  @delegate: (delegatorClass, memberName, delegateClass) ->
    for key, value of delegateClass::
      if isFunction value
        delegateToMember(delegatorClass, memberName, key)

  # Checks if the value is a function.
  #
  # @api private
  isFunction = (val) ->
    return Object::toString.call(val) is '[object Function]'

  # Delegates the named method to the named member.
  #
  # @api private
  # @param [Function] aClass The delegator class. 
  # @param [String] memberName The delegate member name.
  # @param [String] methodName The delegated method name.
  delegateToMember = (aClass, memberName, methodName) ->
    aClass::[methodName] = ->
      @[memberName][methodName] arguments...

module.exports = ClassDelegator
