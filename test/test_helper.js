require('LiveScript');

var chai = require("chai");
var sinonChai = require("sinon-chai");

chai.use(sinonChai);
require('chai').should();
expect = require('chai').expect;
sinon = require('sinon');
_it = it;

process.env['FI_API__STORAGE_ACCOUNT']='figeodata';
process.env['FI_API__STORAGE_SECRET']=new Buffer('secret').toString('base64');
