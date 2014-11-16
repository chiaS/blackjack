class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    #@on 'reveal', ()->alert 'i hope reveal can be caught by other objs...'
    return

  hit: ->
    card = @deck.pop()
    @add(card)
    card.value

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


  stand: ->
    #disable hit button
    @trigger 'reveal', @


  flipFirst: ->
    console.log @at(0)
    @at(0).set 'revealed', false
    @at(0).flip()
    console.log @at(0)

  finalScore: ->
    scores = @scores()
    max = Math.max(scores[0], scores[1])
    min = Math.min(scores[0], scores[1])
    if max > 21
      return min
    if max <= 21
      return max


