class window.CardView extends Backbone.View
  #@model = App=> playerHand or dealerHand =>Card
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    if not @model.get 'revealed'
        @$el.removeClass 'covered'

