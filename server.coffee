
http = require('http')
onm = require('onm')

scdlModel = new onm.Model(require('onmd-scdl').DataModel)
scdlStore = new onm.Store(scdlModel)

scdlAddressRoot = scdlModel.createRootAddress()
scdlAddressNewCatalogue = scdlModel.createPathAddress("scdl.catalogues.catalogue");

listenIpAddress = process.env.OPENSHIFT_NODEJS_IP or "127.0.0.1"
listenIpPort = process.env.OPENSHIFT_NODEJS_PORT or 1031

connectionCount = 0

console.log("onm data store service started.")
console.log("... initializing socket listener on #{listenIpAddress}:#{listenIpPort} ...")

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

).listen(listenIpPort, listenIpAddress, ->
    console.log("... listening for connections on #{listenIpAddress}:#{listenIpPort}");
)








