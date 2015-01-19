@Product = React.createClass
  render: ->
    name = if @props.product.stocked
      @props.product.name
    else
      <span style={{color:'red'}}>{@props.product.name}</span>
    <tr>
      <td>{name}</td>
      <td>{@props.product.price}</td>
    </tr>

@ProductCategory = React.createClass
  render: ->
    products = _.compact @props.products.map (product) =>
      if not @props.inStockOnly || product.stocked
        <Product key={product.name} product={product}  />

    <tbody>
      <tr>
        <th colSpan='42'>{@props.name}</th>
      </tr>
      {products}
    </tbody>

@ProductFilter = React.createClass
  handleChange: ->
    # I can call any function I like on @props, I can send it any arguments I like
    @props.onFilterChanged
      filterText: @refs.filterTextInput.getDOMNode().value
      inStockOnly: @refs.inStockOnlyInput.getDOMNode().checked
  render: ->
    <div>
      <input placeholder="Search..." value={@props.filterText} ref="filterTextInput" onChange={@handleChange} /><br/>
      <label><input type="checkbox" checked={@props.inStockOnly} ref="inStockOnlyInput" onChange={@handleChange}/> Only show products in stock</label>
    </div>

@Products = React.createClass
  getInitialState: ->
    filterText: ''
    inStockOnly: false
  writeFilterToState: ({filterText, inStockOnly})->
    @setState({filterText, inStockOnly})
  render: ->
    byCategory = _.groupBy(@props.products, (p)->p.category)
    if (filterText = @state.filterText)
      byCategory = _.pick byCategory, (products, category) ->
        (///#{filterText}///gi).test(category)

    categories = _.map byCategory, (products, category) =>
      <ProductCategory key={category} name={category} products={products} inStockOnly={@state.inStockOnly} />

    <div className="products-list">
      <ProductFilter inStockOnly={@state.inStockOnly}
                     filterText={@state.filterText}
                     onFilterChanged={@writeFilterToState} />
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Price</th>
          </tr>
        </thead>

        {categories}
      </table>
    </div>
