class window.AppView extends Backbone.View
  #model: @model = App
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="restart">Restart</button>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <section class="scoreSection"></section>'

  events:
    'click .hit-button':() ->
        @model.get('playerHand').hit()
        @playerPlay()
    'click .stand-button': () -> 
        $(".hit-button, .stand-button").attr('disabled', true);
        @model.get('dealerHand').stand()
        @dealerPlay()   
    'click .restart': () -> 
        @remove()
        new AppView(model: new App()).$el.appendTo 'body'

  initialize: ->
    @scoreView = new ScoreView(model: @model)
    @playerView = new HandView(collection: @model.get 'playerHand').el
    @dealerView = new HandView(collection: @model.get 'dealerHand').el
    @render()
     

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html @dealerView
    @$('.player-hand-container').html @playerView
    @$('.scoreSection').html @scoreView.el
      
    
  dealerPlay: ->
    while  @model.get('dealerHand').scores()[0]<17 and  @model.get('dealerHand').scores()[1] < 17
      @model.get('dealerHand').hit()
    return

  playerPlay: ->
     if @model.get("playerHand").finalScore() > 21
       @scoreView.findResult()
     return  

