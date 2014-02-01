###* @jsx React.DOM ###

window.TodoItem = React.createClass(
  handleSubmit: (event) ->
    val = @refs.editField.getDOMNode().value.trim()
    if val
      @props.onSave val
    else
      @props.onDestroy()
    false

  onEdit: ->
    @props.onEdit()
    @refs.editField.getDOMNode().focus()

  render: ->
    classes = Utils.stringifyObjKeys(
      completed: @props.todo.get("completed")
      editing: @props.editing
    )
    `<li className={classes}>
      <div className="view">
        <input
          className="toggle"
          type="checkbox"
          checked={this.props.todo.get('completed')}
          onChange={this.props.onToggle}
          key={this.props.key}
        />
        <label onDoubleClick={this.onEdit}>
          {this.props.todo.get('title')}
        </label>
        <button className="destroy" onClick={this.props.onDestroy} />
      </div>
      <form onSubmit={this.handleSubmit}>
        <input
          ref="editField"
          className="edit"
          defaultValue={this.props.todo.get('title')}
          onBlur={this.handleSubmit}
          autoFocus="autofocus"
        />
      </form>
    </li>`
)
