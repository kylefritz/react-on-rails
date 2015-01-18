@Product = React.createClass
  render: ->
    name = if @props.product.stocked
      this.props.product.name
    else
      `<span style={{color:'red'}}>{this.props.product.name}</span>`
    `<tr>
      <td>{name}</td>
      <td>{this.props.product.price}</td>
    </tr>`

@ProductCategory = React.createClass
  render: ->
    products = _.compact @props.products.map (product) =>
      if not @props.inStockOnly || product.stocked
        `<Product key={product.name} product={product}  />`

    `<tbody>
      <tr>
        <th colSpan='42'>{this.props.name}</th>
      </tr>
      {products}
    </tbody>`

@ProductFilter = React.createClass
  handleChange: ->
    @props.onUserInput(
      @refs.filterTextInput.getDOMNode().value,
      @refs.inStockOnlyInput.getDOMNode().checked)
  render: ->
    `<div>
      <input placeholder="Search..." value={this.props.filterText} ref="filterTextInput" onChange={this.handleChange} /><br/>
      <label><input type="checkbox" checked={this.props.inStockOnly} ref="inStockOnlyInput" onChange={this.handleChange}/> Only show products in stock</label>
    </div>`

@Products = React.createClass
  getInitialState: ->
    filterText: ''
    inStockOnly: false
  handleUserInput: (filterText, inStockOnly)->
    this.setState({filterText, inStockOnly})
  render: ->
    byCategory = _.groupBy(@props.products, (p)->p.category)
    if (filterText = @state.filterText)
      byCategory = _.pick byCategory, (products, category) ->
        (///#{filterText}///gi).test(category)

    categories = _.map byCategory, (products, category) =>
      inStockOnly = @state.inStockOnly #jsx doesn't understand coffescript =>
      `<ProductCategory key={category} name={category} products={products} inStockOnly={inStockOnly} />`

    `<div className="products-list">
      <ProductFilter inStockOnly={this.state.inStockOnly}
                     filterText={this.state.filterText}
                     onUserInput={this.handleUserInput} />
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
    `
