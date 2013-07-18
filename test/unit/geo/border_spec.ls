require! 'assets/borders'
require! 'lib/geo/Border'

describe \Border, ->
  _it '.all(callback)', (done) ->
    err, all <- Border.all

    should.not.exist err
    all.should.have.lengthOf(Object.keys borders .length)
    all.0
      ..should.have.property \id
      ..should.have.property \parts
    done!

  describe '.get(id, callback)', ->
    _it 'returns border with id', (done) ->
      key = Object.keys borders .0

      err, border <- Border.get key

      should.not.exist err
      border
        ..should.have.property \id, key
        ..should.have.property \parts
      done!

    _it 'throws when no border is found', (done) ->
      key = Object.keys borders .0

      err, border <- Border.get \foo

      err.should.exist
      done!
