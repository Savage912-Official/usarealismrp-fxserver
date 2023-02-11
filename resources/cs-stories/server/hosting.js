process.env.NODE_ENV = 'production'

let serverRunning = false

const accessKeys = []

global.on('cs-stories:runInternalHostingServer', (config, keys, keeping) => {
    for (let index = 0; index < keys.length; index++)
        if (!accessKeys.includes(keys[index]))
            accessKeys.push(keys[index])

    if (serverRunning)
        return

    serverRunning = true

    const origWarning = process.emitWarning

    process.emitWarning = (...args) => { // A dirty hack to suppress busboy deprecation warning regarding Buffer since we cannot really overcome it.
        if (args[2] !== 'DEP0005')
            return origWarning.apply(process, args)
    }

    const fs = require('fs')
    const path = require('path')
    const crypto = require('crypto')
    const express = require('express')
    const fileUpload = require('express-fileupload')
    const app = express()
    const storagePath = path.join(GetResourcePath(GetCurrentResourceName()), 'storage')
    const metaPath = path.join(storagePath, 'meta')
    const thumbnailsPath = path.join(storagePath, 'thumbnails')
    const videosPath = path.join(storagePath, 'videos')

    if ((!fs.existsSync(storagePath)) || (!fs.existsSync(metaPath)) || (!fs.existsSync(thumbnailsPath)) || (!fs.existsSync(videosPath)))
        throw new Error('[criticalscripts.shop] The storage directory of cs-stories is either missing or invalid.')

    global.on('cs-stories:addHostingServerAccessKey', (key, old) => {
        if (accessKeys.includes(old))
            accessKeys.splice(accessKeys.indexOf(old), 1)
    
        if (!accessKeys.includes(key))
            accessKeys.push(key)
    })
    
    global.on('cs-stories:removeHostingServerAccessKey', key => {
        if (accessKeys.includes(key))
            accessKeys.splice(accessKeys.indexOf(key), 1)
    })
    
    global.on('cs-stories:deleteHostingServerStory', uuid => {
        const thumbnailPath = path.join(thumbnailsPath, `${uuid}.jpg`)
        const videoPath = path.join(videosPath, `${uuid}.webm`)
        const mPath = path.join(metaPath, `${uuid}.json`)

        if (fs.existsSync(thumbnailPath))
            fs.unlinkSync(thumbnailPath)

        if (fs.existsSync(videoPath))
            fs.unlinkSync(videoPath)

        if (fs.existsSync(mPath))
            fs.unlinkSync(mPath)
    })

    const storageDir = fs.opendirSync(metaPath)

    let storedStoriesCount = 0
    let dirFile = null

    while ((dirFile = storageDir.readSync()) !== null)
        if (dirFile.isFile() && dirFile.name.endsWith('.json')) {
            const uuid = dirFile.name.replace('.json', '')

            if (!keeping.includes(uuid)) {
                const thumbnailPath = path.join(thumbnailsPath, `${uuid}.jpg`)
                const videoPath = path.join(videosPath, `${uuid}.webm`)
        
                if (fs.existsSync(thumbnailPath))
                    fs.unlinkSync(thumbnailPath)
        
                if (fs.existsSync(videoPath))
                    fs.unlinkSync(videoPath)

                fs.unlinkSync(path.join(metaPath, dirFile.name))
            } else
                storedStoriesCount++
        }

    storageDir.closeSync()

    app.use(fileUpload({
        limits: {
            fileSize: config.maxSize * 1024 * 1024,
            files: 2
        },

        safeFileNames: true
    }))

    app.get('/', (req, res) => res.redirect(301, 'https://criticalscripts.shop'))

    app.get('/thumbnail/:uuid.jpg', (req, res) => {
        const thumbnailPath = path.join(thumbnailsPath, `${req.params.uuid}.jpg`)

        if (thumbnailPath.indexOf(thumbnailsPath) !== 0) {
            res.status(400).send()
            return
        } else if (!fs.existsSync(thumbnailPath)) {
            res.status(404).send()
            return
        }

        res.sendFile(thumbnailPath)
    })

    app.get('/video/:key/:uuid.webm', (req, res) => {
        if (!accessKeys.includes(req.params.key)) {
            res.status(401).send()
            return
        }

        if (req.method === 'HEAD') {
            const mPath = path.join(metaPath, `${req.params.uuid}.json`)
    
            if (mPath.indexOf(metaPath) !== 0) {
                res.status(400).send()
                return
            } else if (!fs.existsSync(mPath)) {
                res.status(404).send()
                return
            }

            res.header('X-Video-Duration', JSON.parse(fs.readFileSync(mPath)).duration).send()
        } else {
            const videoPath = path.join(videosPath, `${req.params.uuid}.webm`)
    
            if (videoPath.indexOf(videosPath) !== 0) {
                res.status(400).send()
                return
            } else if (!fs.existsSync(videoPath)) {
                res.status(404).send()
                return
            }

            res.sendFile(videoPath)
        }
    })

    app.post('/upload/:key/:duration', (req, res) => {
        if (!accessKeys.includes(req.params.key)) {
            res.status(401).send()
            return
        } else if (storedStoriesCount + 1 > config.maximumStoriesStored) {
            res.status(503).send()
            return
        }

        const uuid = crypto.randomUUID()

        let video = null
        let thumbnail = null

        for (const key in req.files.files)
            if (req.files.files[key].name === 'video')
                video = req.files.files[key]
            else if (req.files.files[key].name === 'thumbnail')
                thumbnail = req.files.files[key]

        if (video && thumbnail && (!video.truncated) && (!thumbnail.truncated)) {
            fs.writeFileSync(path.join(thumbnailsPath, `${uuid}.jpg`), thumbnail.data)
            fs.writeFileSync(path.join(videosPath, `${uuid}.webm`), video.data)

            fs.writeFileSync(path.join(metaPath, `${uuid}.json`), JSON.stringify({
                timestamp: Date.now(),
                duration: isNaN(req.params.duration) ? 0 : parseFloat(req.params.duration)
            }))

            storedStoriesCount++

            res.json({
                uuid
            })
        } else
            res.status(413).send()
    })

    app.listen(config.hostingServerPort, config.hostingServerListeningIpAddress, () => console.log(`[criticalscripts.shop] Stories Hosting Server | Listening (${config.hostingServerListeningIpAddress || '0.0.0.0'}:${config.hostingServerPort})`))
})

global.emit('cs-stories:internalHostingServerReady')
