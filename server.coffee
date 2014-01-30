
http = require('http')
onm = require('onm')

scdlModel = new onm.Model(require('onmd-scdl').DataModel)
scdlStore = new onm.Store(scdlModel)

scdlAddressRoot = scdlModel.createRootAddress()
scdlAddressNewCatalogue = scdlModel.createPathAddress("scdl.catalogues.catalogue");

#listenIp =   process.env.OPENSHIFT_INTERNAL_IP or LOCALHOST
listenPort = process.env.OPENSHIFT_INTERNAL_PORT or 1031

connectionCount = 0

console.log("onm data store service started.")
console.log("... listening for connections on port #{listenPort}")

http.createServer( (req,res) ->

    reqAgent = req.headers['user-agent']
    reqHost = req.headers['host']

    console.log("#{connectionCount++}: #{reqHost} via #{reqAgent}")
    
    res.writeHead(200, {'Content-Type': 'text/json'})
    catalogueNamespace = scdlStore.createComponent(scdlAddressNewCatalogue)
    res.end(scdlStore.toJSON())
    console.log(catalogueNamespace.toJSON())
    console.log("---")
    console.log("---")
    scdlStore.removeComponent(catalogueNamespace.getResolvedAddress())

).listen(listenPort)








