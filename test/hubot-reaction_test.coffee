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
    expect(@robot.hear).to.have.been.calledWith(/!reply woo/)
  it 'registers a respond listener for "?reply"', ->
    expect(@robot.hear).to.have.been.calledWith(/\?reply/)
