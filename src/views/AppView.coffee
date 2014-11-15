class window.AppView extends Backbone.View
  #model: @model = App
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': () ->
        @model.get('playerHand').stand()
        @dealerPlay()
        console.log @model.get("dealerHand").finalScore()+' vs '+ @model.get("playerHand").finalScore()
        return
    

  initialize: ->
    @render()
    return

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  dealerPlay: ->  
    @model.get('dealerHand').flipFirst()
    while  @model.get('dealerHand').scores()[0]<17 and  @model.get('dealerHand').scores()[1] < 17
       @model.get('dealerHand').hit() 
    return