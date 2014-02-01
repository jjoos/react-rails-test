###* @jsx React.DOM ###

window.TodoApp = React.createClass(
  mixins: [window.BackboneMixin]
  getInitialState: ->
    editing: null

  componentDidMount: ->

    # Additional functionality for todomvc: fetch() the collection on init
    @props.todos.fetch()
    @refs.newField.getDOMNode().focus()

  componentDidUpdate: ->

    # If saving were expensive we'd listen for mutation events on Backbone and
    # do this manually. however, since saving isn't expensive this is an
    # elegant way to keep it reactively up-to-date.
    @props.todos.forEach (todo) ->
      todo.save()

  getBackboneModels: ->
    [@props.todos]

  handleSubmit: (event) ->
    event.preventDefault()
    val = @refs.newField.getDOMNode().value.trim()
    if val
      @props.todos.create
        title: val
        completed: false
        order: @props.todos.nextOrder()

      @refs.newField.getDOMNode().value = ""

  toggleAll: (event) ->
    checked = event.nativeEvent.target.checked
    @props.todos.forEach (todo) ->
      todo.set "completed", checked

  edit: (todo) ->
    @setState editing: todo.get("id")

  save: (todo, text) ->
    todo.set "title", text
    @setState editing: null

  clearCompleted: ->
    @props.todos.completed().forEach (todo) ->
      todo.destroy()

  render: ->
    footer = null
    main = null
    todoItems = @props.todos.map((todo) ->
      `<TodoItem
          key={todo.cid}
          todo={todo}
          onToggle={todo.toggle.bind(todo)}
          onDestroy={todo.destroy.bind(todo)}
          onEdit={this.edit.bind(this, todo)}
          editing={this.state.editing === todo.get('id')}
          onSave={this.save.bind(this, todo)}
        />`
    , this)
    activeTodoCount = @props.todos.remaining().length
    completedCount = todoItems.length - activeTodoCount
    if activeTodoCount or completedCount
      footer = `<TodoFooter
          count={activeTodoCount}
          completedCount={completedCount}
          onClearCompleted={this.clearCompleted}
        />`
    if todoItems.length
      main = ` <section id="main">
          <input id="toggle-all" type="checkbox" onChange={this.toggleAll} />
          <ul id="todo-list">
            {todoItems}
          </ul>
        </section>`

    `<div>
        <section id="todoapp">
          <header id="header">
            <h1>todos</h1>
            <form onSubmit={this.handleSubmit}>
              <input
                ref="newField"
                id="new-todo"
                placeholder="What needs to be done?"
              />
            </form>
          </header>
          {main}
          {footer}
        </section>
        <footer id="info">
          <p>Double-click to edit a todo</p>
          <p>
            Created by{' '}
            <a href="http://github.com/petehunt/">petehunt</a>
          </p>
          <p>Part of{' '}<a href="http://todomvc.com">TodoMVC</a></p>
        </footer>
      </div>`
)


$(document).ready(() ->
  React.renderComponent TodoApp(todos: new window.TodoList()), document.getElementById("container"))