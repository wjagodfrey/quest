###
  Gravity Module
###
class Q._.modules.Module_GameElements
  constructor: (options) ->

    @_ =
      elementCount: 0
      elements: {}


    @newElementIndex = ->
      @_.elementCount++