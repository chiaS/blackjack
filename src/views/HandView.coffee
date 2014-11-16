class window.HandView extends Backbone.View
  #@collection = App.playerHand or App.dealerHand
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>Your<% } %> Score: <span class="score"></span></h2>'

  initialize: ->
    @collection.on 'reveal add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.finalScore()

