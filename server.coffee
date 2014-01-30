
http = require('http')
onm = require('onm')

scdlModel = new onm.Model(require('onmd-scdl').DataModel)
scdlStore = new onm.Store(scdlModel)

scdlAddressRoot = scdlModel.createRootAddress()
scdlAddressNewCatalogue = scdlModel.createPathAddress("scdl.catalogues.catalogue");

listenIpAddress = process.env.OPENSHIFT_NODEJS_IP or "127.0.0.1"
listenIpPort = process.env.OPENSHIFT_NODEJS_PORT or 1031

console.log("onm data store service started.")
console.log("... initializing socket listener on #{listenIpAddress}:#{listenIpPort} ...")

localCatalogueCache = []

http.createServer( (req,res) ->

    reqAgent = req.headers['user-agent']
    reqHost = req.headers['host']
    reqAddr = req.connection.remoteAddress

    console.log("#{localCatalogueCache.length}: #{reqHost} #{reqAddr} #{reqAgent}")
    
    catalogueNamespace = scdlStore.createComponent(scdlAddressNewCatalogue)
    localCatalogueCache.push catalogueNamespace

    catalogueJSON = catalogueNamespace.toJSON()
    storeJSON = scdlStore.toJSON()

    res.writeHead(200, {'Content-Type': 'text/json'})
    res.end(storeJSON)

    console.log(catalogueNamespace.toJSON())
    console.log("---")

    if (localCatalogueCache.length > 9)
        console.log("Clearing in-memory catalogue memory...")
        for catalogue in localCatalogueCache
            scdlStore.removeComponent(catalogue.getResolvedAddress())
        localCatalogueCache = []
        console.log("... complete. Listening for requests...")

).listen(listenIpPort, listenIpAddress, ->
    console.log("... listening for connections on #{listenIpAddress}:#{listenIpPort}");
)








