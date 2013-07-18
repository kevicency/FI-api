require! '../../assets/borders'

module.exports =
  all: (callback) ->
    callback void, [{id, parts} for id, parts of borders]

  get: (id, callback) ->
    id .= toLowerCase()
    if borders[id]
      callback void, id: id, parts: that
    else
      callback 'not found'
