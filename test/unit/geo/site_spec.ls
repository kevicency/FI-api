require! 'lib/geo/Site'

describe \Site, ->
  _it '.table', ->
    Site.table.should.be.equal \sites
  _it '.partitionKey', ->
    Site.partitionKey.should.be.equal \allSites

