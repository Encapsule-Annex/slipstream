
http = require('http')
onm = require('onm')

scdlModel = new onm.Model(require('onmd-scdl').DataModel)
scdlStore = new onm.Store(scdlModel)

scdlAddressRoot = scdlModel.createRootAddress()
scdlAddressNewCatalogue = scdlModel.createPathAddress("scdl.catalogues.catalogue");


http.createServer( (req,res) ->
    
    res.writeHead(200, {'Content-Type': 'text/json'})

    catalogueNamespace = scdlStore.createComponent(scdlAddressNewCatalogue)
    res.end(scdlStore.toJSON())

    console.log(catalogueNamespace.toJSON(undefined,2))
    scdlStore.removeComponent(catalogueNamespace.getResolvedAddress())

).listen(1031)






