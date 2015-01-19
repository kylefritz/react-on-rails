converter = new Showdown.converter()

@Comment = React.createClass
  render: ->
    rawMarkup = converter.makeHtml(@props.children)

    <div className="Comment">
      <h6>{@props.author}</h6>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
    </div>

@CommentList = React.createClass
  render: ->
    comments = @props.comments.map (comment) ->
      <Comment author={comment.author}>{comment.text}</Comment>
    <div className="CommentList">
      <h4>Comments</h4>
      {comments}
    </div>

@CommentForm = React.createClass
  handleSubmit: (event) ->
    event.preventDefault()
    author = @refs.author.getDOMNode().value.trim()
    text = @refs.text.getDOMNode().value.trim()

    @refs.author.getDOMNode().value = ''
    @refs.text.getDOMNode().value = ''

  render: ->
    <form className="CommentForm" onSubmit={@handleSubmit}>
      <div class="input-group">
        <input type="text" class="form-control" ref="author" placeholder="Your name"/>
      </div>
      <div class="input-group">
        <input type="text" class="form-control" ref="text" placeholder="Say something..."/>
      </div>
      <br/>
      <input type="submit" value="Post" class="btn btn-default"/>
    </form>

@CommentBox = React.createClass
  getInitialState: ->
    data: []
  componentDidMount: ->
    @loadComments()
    setInterval(@loadComments, @props.pollInterval)
  loadComments: ->
    $.ajax
      url: @props.url
      dataType: 'json'
      success: (data) => @setState({data})
      error: (xhr, status, err) =>
        console.error(@props.url, status, err.toString())
  handleCommentSubmit: ->

  render: ->
    <div className="commentBox">
      Comment box ftw!!
      <CommentList comments={@state.data} />
      <CommentForm onCommentSubmit={@handleCommentSubmit} />
    </div>
