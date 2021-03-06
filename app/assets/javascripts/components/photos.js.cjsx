@Photo = React.createClass
  toggleLiked: ->
    @setState(liked: not @state.liked)

  getInitialState: ->
    liked: false

  render: ->
    buttonClass = if @state.liked then 'active' else ''

    <div className='photo'>
      <span>{@props.caption}</span>
      <br />
      <button onClick={@toggleLiked} className={buttonClass}>
        ♥
      </button>
      <br />
      <img src={@props.imageUrl} />
    </div>

@PhotoGallery = React.createClass
  render: ->
    photos = @props.images.map (img) ->
      <Photo imageUrl={img.imageUrl} caption={img.caption} />

    <div className="photo-gallery">{photos}</div>
