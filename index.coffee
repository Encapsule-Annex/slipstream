
http = require('http')

onm = require('onm')

scdlDataModelLibrary = require('onmd-scdl')

scdlDataModel = new onm.Model(scdlDataModelLibrary.DataModel)
scdlDataStore = new onm.Store(scdlDataModel)


http.createServer( (req,res) ->
    res.writeHead(200, {'Content-Type': 'text/json'})
    res.end(scdlDataStore.toJSON(undefined, 2))
).listen(9615)






