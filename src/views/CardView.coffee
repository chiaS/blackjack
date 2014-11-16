class window.CardView extends Backbone.View
  #@model = App=> playerHand or dealerHand =>Card
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
   # @$el.html @template @model.attributes
  
    if @model.get 'revealed'
      @$el.css('background-image', 'url("img/cards/' + 
      (@model.get 'rankName') + '-' + (@model.get 'suitName') + '.png")')
    else
      @$el.addClass 'covered' 