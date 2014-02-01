BackboneMixin =
  componentDidMount: ->

    # Whenever there may be a change in the Backbone data, trigger a reconcile.
    @getBackboneModels().forEach ((model) ->
      model.on "add change remove", @forceUpdate.bind(this, null), this
    ), this

  componentWillUnmount: ->

    # Ensure that we clean up any dangling references when the component is
    # destroyed.
    @getBackboneModels().forEach ((model) ->
      model.off null, null, this
    ), this