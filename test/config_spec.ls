require! '../lib/config'

describe \config, ->

  _it 'has storage keys', ->
    config.STORAGE_ACCOUNT.should.be.equal 'figeodata'
    config.STORAGE_SECRET.should.be.equal 'c2VjcmV0'
