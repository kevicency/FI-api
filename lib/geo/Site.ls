require! '../azure'

module.exports = azure.createEntityClass do
  table: \sites
  partitionKey: \allSites
