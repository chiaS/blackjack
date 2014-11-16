class window.ScoreView extends Backbone.View
  template: _.template '<h2>Result</h2><div class="result"></div>'  
  
  initialize: -> 
  	@render()
  	@listenTo (@model.get 'dealerHand'), 'reveal:dealer', @findResult

  render: -> 
  	@$el.children().detach()
  	@$el.html @template
  	@$('.result').text(@score)
  
  findResult: ->
    $(".hit-button, .stand-button").attr('disabled', true); 
    playerScore = @model.get("playerHand").finalScore()
    dealerScore = @model.get("dealerHand").finalScore()
    console.log 'dealer:'+dealerScore+' vs player: '+playerScore
    if dealerScore == 21 or playerScore > 21 or (dealerScore < 22 and dealerScore > playerScore)
      @score = 'You Lost' 
    else @score = 'You Won'     
    @score = 'PUSH' if playerScore == dealerScore
    @render()

  earlyResult: ->
    $(".hit-button, .stand-button").attr('disabled', true); 
    playerScore = @model.get("playerHand").finalScore()
    @score = 'You Lost' if playerScore > 21
    @score = 'You Won' if playerScore == 21
    @render()