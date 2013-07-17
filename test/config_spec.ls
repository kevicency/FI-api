require! '../lib/config'

describe \config, ->

  _it 'has storage keys', ->
    config.STORAGE_ACCOUNT.should.be.equal 'storage_account'
    config.STORAGE_SECRET.should.be.equal 'storage_secret'
