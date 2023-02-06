process.env.NODE_ENV = 'production'

let proxyRunning = false
let turnServer = null

global.on('cs-video-call:runInternalTurnServer', (config, credentials) => {
    if (turnServer)
        for (const source in credentials)
            turnServer.addUser(credentials[source].username, credentials[source].password)

    if (proxyRunning)
        return

    proxyRunning = true

    turnServer = new (require('node-turn'))({
        authMech: 'long-term',
        realm: 'criticalscripts.shop',
        listeningPort: config.proxyPort,
        listeningIps: config.proxyListeningIpAddress ? [config.proxyListeningIpAddress] : null,
        relayIps: config.proxyIpAddress ? [config.proxyIpAddress] : null,
        externalIps: config.proxyIpAddress ? [config.proxyIpAddress] : null
    })

    if (config.debugTurnPair)
        turnServer.addUser('criticalscripts', 'criticalscripts')

    global.on('cs-video-call:addTurnUser', (username, password) => turnServer.addUser(username, password))
    global.on('cs-video-call:removeTurnUser', username => turnServer.removeUser(username))

    turnServer.start()

    console.log(`[criticalscripts.shop] Video Call TURN Server | Listening (${config.proxyListeningIpAddress || '0.0.0.0'}:${config.proxyPort})`)
})

global.emit('cs-video-call:internalTurnServerReady')
