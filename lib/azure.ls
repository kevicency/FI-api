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
      err, row <~ @client.queryEntity @table, @partitionKey, "#id"
      entity = new @(row) unless err?
      callback err, entity

    (row) ->
      this <<< row
      @id = row.RowKey
      for crap in <[RowKey PartitionKey Timestamp _]>
        delete @[crap]

  ensureTable: (name, callback) ->
    err <~ client.createTableIfNotExists(name)

    callback err, 'ok' unless err?
