chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hubot-reaction', ->
  beforeEach ->
    @robot =
      hear: sinon.spy()

    require('../src/hubot-reaction')(@robot)

  it 'registers a respond listener for "!reply"', ->
    expect(@robot.hear).to.have.been.calledWith(/!reply/)
  it 'registers a respond listener for "?reply"', ->
    expect(@robot.hear).to.have.been.calledWith(/\?reply/)

  # testing tag parsing
  # (for supporting transforming Tag names to their URL)
  it 'works for the case of Winnie-the-Pooh', ->
    tag_text = @robot.parseReplyGifTag('Winnie-the-Pooh')
    expect(tag_text).to.equal('winnie-the-pooh')
  it 'works for the case of Patrick J. Adams', ->
    tag_text = @robot.parseReplyGifTag('Patrick J. Adams')
    expect(tag_text).to.equal('patrick-j-adams')
  it 'works for the case of `Don\'t Trust the B---- in Apartment 23`', ->
    tag_text = @robot.parseReplyGifTag('Don\'t Trust the B---- in Apartment 23')
    expect(tag_text).to.equal('dont-trust-the-b-in-apartment-23')
  it 'works for the case of Gareth David-Lloyd', ->
    tag_text = @robot.parseReplyGifTag('Gareth David-Lloyd')
    expect(tag_text).to.equal('gareth-david-lloyd')
  it 'works for the case of `are you kidding me?`', ->
    tag_text = @robot.parseReplyGifTag('are you kidding me?')
    expect(tag_text).to.equal('are-you-kidding-me')
  it 'works for the case of `Married... with Children`', ->
    tag_text = @robot.parseReplyGifTag('Married... with Children')
    expect(tag_text).to.equal('married-with-children')
