###
  Module Applicator
###

class Modules
  constructor: (modules) ->
    for moduleName, moduleOptions of modules
      if Q._.modules["Module_#{moduleName}"]?
        mod = new Q._.modules["Module_#{moduleName}"] moduleOptions, @
        Q.util.extend @, mod
      else
        console.error "#{moduleName} does not exist"
    # console.log "RESULT>>", @