class window.TodoList extends Backbone.Collection
  # Reference to this collection's model.
  model: Todo


  # Filter down the list of all todo items that are finished.
  completed: ->
    @filter (todo) ->
      todo.get "completed"

  remaining: ->
    @without.apply this, @completed()

  # We keep the Todos in sequential order, despite being saved by unordered
  # GUID in the database. This generates the next order number for new items.
  nextOrder: ->
    return 1  unless @length
    @last().get("order") + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo) ->
    todo.get "order"