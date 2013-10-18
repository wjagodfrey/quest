###
  Module Applicator
###

class Modules
  constructor: (modules) ->
    for moduleName, moduleOptions of modules
      if Q._.modules["Module_#{moduleName}"]?
        Q.util.extend @, new Q._.modules["Module_#{moduleName}"] moduleOptions
      else
        console.error "#{moduleName} does not exist"

