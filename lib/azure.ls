require! azure
require! './config'

client = azure.createTableService(config.STORAGE_ACCOUNT, config.STORAGE_SECRET)

module.exports =
  client: client
  createEntityClass: (options = {}) -> class
    @table = options.table
    @partitionKey = options.partitionKey
    @client = client
    @fields = options.fields ? []

    @all = (callback) ->
      query = azure.TableQuery.select @fields.join ', ' .from @table
      err, rows <~ @client.queryEntities query
      entities = [new @(row) for row in rows] unless err?
      callback err, entities

    @get = (id, callback) ->
      err, row <~ @client.queryEntity @table, id
      entity = new @(row) unless err?
      callback err, entity

    (row) ->
      this <<< row
      @id = row.RowKey
      delete @RowKey
      delete @_
