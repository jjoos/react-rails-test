###* @jsx React.DOM ###

window.TodoFooter = React.createClass(render: ->
  activeTodoWord = Utils.pluralize(@props.count, "todo")
  clearButton = null
  if @props.completedCount > 0
    clearButton =
     `<button id="clear-completed" onClick={this.props.onClearCompleted}>
          Clear completed ({this.props.completedCount})
      </button>`

   `<footer id="footer">
      <span id="todo-count">
        <strong>{this.props.count}</strong>{' '}
        {activeTodoWord}{' '}left
      </span>
      {clearButton}
    </footer>`
)