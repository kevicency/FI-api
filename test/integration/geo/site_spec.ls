require! 'lib/geo/Site'

describe \Site, ->
  _it '.get(id, callback)', (done) ->
    err, site <- Site.get 100
    should.not.exist err
    site.should.have.property \id, '100'
    done!

  _it '.all(callback)', (done) ->
    err, sites <- Site.all
    should.not.exist err
    sites.should.not.be.empty
    sites[0].should.have.property \id
    done!
