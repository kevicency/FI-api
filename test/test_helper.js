require('LiveScript');

var chai = require("chai");
var sinonChai = require("sinon-chai");

chai.use(sinonChai);
require('chai').should();
expect = require('chai').expect;
sinon = require('sinon');
_it = it;

process.env['FI_API_STORAGE_ACCOUNT'] = 'storage_account';
process.env['FI_API_STORAGE_SECRET'] = 'storage_secret';
