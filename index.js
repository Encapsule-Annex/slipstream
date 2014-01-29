// Generated by CoffeeScript 1.6.3
(function() {
  var http, onm, scdlDataModel, scdlDataModelLibrary, scdlDataStore;

  http = require('http');

  onm = require('onm');

  scdlDataModelLibrary = require('onmd-scdl');

  scdlDataModel = new onm.Model(scdlDataModelLibrary.DataModel);

  scdlDataStore = new onm.Store(scdlDataModel);

  http.createServer(function(req, res) {
    res.writeHead(200, {
      'Content-Type': 'text/json'
    });
    return res.end(scdlDataStore.toJSON(void 0, 2));
  }).listen(9615);

}).call(this);
