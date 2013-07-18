require! 'lib/app'

describe \app, ->
  _it '#createServer', ->
    app.createServer.should.exist
