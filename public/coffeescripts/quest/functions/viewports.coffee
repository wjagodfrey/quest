###
  Viewport Constructor
###
scope = Q.viewport = {}

( ->

  @.create = (options) ->

    if options?.id?
      viewports = Q._.filesys.viewports
      viewports[options.id] = {}
      options.viewport = viewports[options.id]
      modules =
        Viewport: options
      viewports[options.id] = new Modules modules
    { then: (next) -> next(viewports[options.id]) }

).call scope