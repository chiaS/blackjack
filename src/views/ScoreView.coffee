class window.ScoreView extends Backbone.View
  template: _.template '<h2>Result</h2><div class="result"></div>'  
  
  initialize: -> 
  	@render()
  	@listenTo (@model.get 'dealerHand'), 'reveal', @findResult

  render: -> 
  	@$el.children().detach()
  	@$el.html @template
  	@$('.result').text(@score)
  
  findResult: ->
  	playerScore = @model.get("playerHand").finalScore()
  	dealerScore = @model.get("dealerHand").finalScore()
  	if playerScore > 21 or (dealerScore < 22 and dealerScore > playerScore)
      @score = 'You Lost' 
    else
      @score = 'You Won' 
    $(".hit-button, .stand-button").attr('disabled', true); 
    @render()