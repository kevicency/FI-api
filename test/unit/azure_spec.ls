require! 'lib/config'
require! 'lib/azure'
require! azureAPI: 'azure'

_it = it

describe \azure, ->
  describe \#client, ->
    _it 'uses credentials from config', ->
      azure.client.should.have.deep.property \authenticationProvider.storageAccount,
        config.STORAGE_ACCOUNT
      azure.client.should.have.deep.property \authenticationProvider.storageAccessKey,
        config.STORAGE_SECRET

    _it 'returns a azureAPI.TableService instance', ->
      azure.client@@should.be.equal azureAPI.TableService

  describe '#createEntityClass(options{table, partitionKey, client})', ->
    _it 'returns a constructor function', ->
      azure.createEntityClass().prototype.should.have.property \constructor

    _it 'sets #table on constructor', ->
      azure.createEntityClass table: \entities .should.have.property \table, \entities
    _it 'sets #partitionKey on constructor', ->
      azure.createEntityClass partitionKey: \allEntities .should.have.property \partitionKey, \allEntities
    _it 'sets #client on constructor', ->
      azure.createEntityClass client: azure.client .should.have.property \client, azure.client
    _it 'sets #fields on constructor', ->
      fields = <[foo bar]>
      azure.createEntityClass fields: fields .should.have.property \fields, fields
    _it 'defaults #fields to `all`', ->
      azure.createEntityClass().fields.should.be.empty

    describe 'EntityClass', ->
      var EntityClass
      beforeEach ->
        EntityClass := azure.createEntityClass do
          table: \entities
          partitionKey: \allEntities
          fields: <[foo bar]>

      describe \.all, ->
        beforeEach ->
          @cb = sinon.spy!
          sinon.stub EntityClass.client, \queryEntities
        afterEach -> EntityClass.client.queryEntities.restore!

        _it 'fetches entities from from azure table', ->
          query = azureAPI.TableQuery.select 'foo, bar' .from 'entities'

          EntityClass.all @cb

          azure.client.queryEntities.should.have.been.calledWith query

        _it 'creates entities and invokes callback with them', ->
          EntityClass.client.queryEntities.yields void, [
            * RowKey: 1
            * RowKey: 2
            * RowKey: 3
          ]

          EntityClass.all @cb

          @cb.should.have.been.calledOnce.and.calledWith void, [
            sinon.match.instanceOf(EntityClass),
            sinon.match.instanceOf(EntityClass),
            sinon.match.instanceOf(EntityClass)
          ]

      describe \.get, ->
        beforeEach ->
          @cb = sinon.spy!
          sinon.stub EntityClass.client, \queryEntity
        afterEach -> EntityClass.client.queryEntity.restore!

        _it 'fetches entity from azure table', ->
          EntityClass.get 1, @cb

          azure.client.queryEntity.should.have.been.calledWith 'entities', 'allEntities', '1'

        _it 'creates entity and invokes callback with it', ->
          EntityClass.client.queryEntity.yields void, RowKey: 1

          EntityClass.get 1, @cb

          @cb.should.have.been.calledOnce.and.calledWith void, sinon.match.instanceOf(EntityClass)

      describe '.ctor(row)', ->
        _it 'uses row.RowKey as id', ->
          entity = new EntityClass RowKey: 1

          entity.should.have.property \id, 1
          entity.should.not.have.property \RowKey

        _it 'doesnt copy azure metadata', ->
          entity = new EntityClass _: azure: \metadata

          entity.should.not.have.property \_

        _it 'foo', ->
          entity = new EntityClass foo: \bar

          entity.should.have.property \foo, \bar

