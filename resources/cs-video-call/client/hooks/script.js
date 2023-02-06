;(() => {
    const videoCallWidth = 300
    const videoCallHeight = 543

    const cameraCropWidthFront = 0.20
    const cameraCropWidthBack = 0.45
    const cameraCropHeight = 0.0

    const experimentalCameraCropWidthFront = 0.35
    const experimentalCameraCropWidthBack = 0.45
    const experimentalCameraCropHeight = 0.0

    const pendingVideoTransmissionIntervalMs = 500
    const useRecorder = true // Set this to false for better performance if you get a lot of video glitches. However note that this may crash in certain GPUs, please test it within your community!

    let isTransmitting = false
    let selfVideoCanvasStream = null
    let peerData = null
    let turnUsername = null
    let turnPassword = null

    class PeerData {
        constructor(incomingTrackCallback, incomingConnectionCallback, proxyIpAddress, proxyPort, serverEndpoint) {
            this.onIncomingTrackCallback = incomingTrackCallback
            this.onIncomingConnectionCallback = incomingConnectionCallback

            this.serverEmitListeners = {}
            this.emitServerParser = this.parseEmitFromServer.bind(this)
            this.pendingOutgoingConnection = null
            this.incomingConnection = null
            this.outgoingConnection = null
            this.remotePeerConnected = false
            this.proxyIpAddress = proxyIpAddress
            this.proxyPort = proxyPort
            this.serverEndpoint = serverEndpoint

            window.addEventListener('message', this.emitServerParser)

            this.listenEmitFromServer('stream-stop', () => this.stopIncomingConnection(false))
            this.listenEmitFromServer('stream-ice-candidate', data => this.incomingConnection && this.incomingConnection.addIceCandidate(new RTCIceCandidate(data.candidate)).catch(error => this.fatalError(error)))

            this.listenEmitFromServer('stream-offer', data => {
                this.startIncomingConnection(this.incomingConnection !== null)

                this.incomingConnection.setRemoteDescription(new RTCSessionDescription(data.offer))
                .then(response => this.incomingConnection.createAnswer())
                .then(answer => new Promise((resolve, reject) => this.incomingConnection.setLocalDescription(new RTCSessionDescription(answer)).then(() => resolve(answer)).catch(error => reject(error))))
                .then(answer => this.emitToServer('stream-answer', {
                    answer
                })).catch(error => this.fatalError(error))
            })

            this.listenEmitFromServer('transmission-ice-candidate', data => this.outgoingConnection && this.outgoingConnection.addIceCandidate(new RTCIceCandidate(data.candidate)).catch(error => this.fatalError(error)))
            this.listenEmitFromServer('transmission-answer', data => this.outgoingConnection && this.outgoingConnection.setRemoteDescription(new RTCSessionDescription(data.answer)).catch(error => this.fatalError(error)))

            this.listenEmitFromServer('remote-peer-connected', () => {
                this.remotePeerConnected = true

                if (this.pendingOutgoingConnection)
                    this.transmitToOutgoingConnection(this.pendingOutgoingConnection.tracks, this.pendingOutgoingConnection.stream)
            })

            this.listenEmitFromServer('transmission-rejected', () => {
                this.close()

                fetch(`https://${GetParentResourceName()}/cs-video-call:transmissionRejectedFromExhaustion`, {
                    method: 'POST',
                    body: JSON.stringify({})
                }).catch(error => {})
            })

            this.listenEmitFromServer('peer-disconnect', () => this.close())

            this.listenEmitFromServer('remote-peer-disconnected', () => {
                this.remotePeerConnected = false
            })

            this.emitToServer('peer-connect')
        }

        emitToServer(name, data) {
            fetch(`https://${GetParentResourceName()}/cs-video-call:emitToServer`, {
                method: 'POST',
                body: JSON.stringify({
                    name,
                    data
                })
            }).catch(error => {})
        }

        listenEmitFromServer(name, cb) {
            if (!this.serverEmitListeners[name])
                this.serverEmitListeners[name] = []
    
            this.serverEmitListeners[name].push(cb)
        }

        parseEmitFromServer(event) {
            const message = event.data

            if (message.type && message.type === 'cs-video-call:emitToClient' && this.serverEmitListeners[message.name])
                for (let index = 0; index < this.serverEmitListeners[message.name].length; index++)
                    this.serverEmitListeners[message.name][index](message.data)
        }
    
        startIncomingConnection(isRestarting) {
            this.stopIncomingConnection(isRestarting)
    
            this.incomingConnection = new RTCPeerConnection({
                iceServers: [
                    {
                        'urls': `stun:${this.proxyIpAddress ? this.proxyIpAddress : this.serverEndpoint.split(':')[0]}:${this.proxyPort}`
                    },

                    {
                        'urls': `turn:${this.proxyIpAddress ? this.proxyIpAddress : this.serverEndpoint.split(':')[0]}:${this.proxyPort}`,
                        'username': turnUsername,
                        'credential': turnPassword
                    }
                ],

                iceTransportPolicy: 'relay'
            })
    
            this.incomingConnection.ontrack = event => {
                for (let index = 0; index < event.streams.length; index++) {
                    const videoTracks = event.streams[index].getVideoTracks()

                    for (let ii = 0; ii < videoTracks.length; ii++)
                        this.onIncomingTrackCallback(videoTracks[ii])
                }
            }
    
            this.incomingConnection.onicecandidate = event => event.candidate && this.emitToServer('stream-ice-candidate', {
                candidate: event.candidate
            })

            this.incomingConnection.onicecandidateerror = event => this.fatalError(event)
        }
    
        startOutgoingConnection() {
            this.stopOutgoingConnection()
    
            this.outgoingConnection = new RTCPeerConnection({
                iceServers: [
                    {
                        'urls': `stun:${this.proxyIpAddress ? this.proxyIpAddress : this.serverEndpoint.split(':')[0]}:${this.proxyPort}`
                    },

                    {
                        'urls': `turn:${this.proxyIpAddress ? this.proxyIpAddress : this.serverEndpoint.split(':')[0]}:${this.proxyPort}`,
                        'username': turnUsername,
                        'credential': turnPassword
                    }
                ],

                iceTransportPolicy: 'relay'
            })

            this.outgoingConnection.onicecandidate = event => event.candidate && this.emitToServer('transmission-ice-candidate', {
                candidate: event.candidate
            })

            this.outgoingConnection.onicecandidateerror = event => this.fatalError(event)
            this.outgoingConnection.onconnectionstatechange = event => this.outgoingConnection.connectionState === 'failed' && this.transmitToOutgoingConnection(selfVideoCanvasStream.getVideoTracks(), selfVideoCanvasStream)
        }
    
        stopIncomingConnection(isRestarting) {
            if (this.incomingConnection) {
                this.incomingConnection.ontrack = null
                this.incomingConnection.onicecandidate = null
                this.incomingConnection.onicecandidateerror = null
                this.incomingConnection.close()
                this.onIncomingConnectionCallback(isRestarting)
            }

            this.incomingConnection = null
        }
    
        stopOutgoingConnection() {
            this.pendingOutgoingConnection = null
    
            if (this.outgoingConnection) {
                this.outgoingConnection.onicecandidate = null
                this.outgoingConnection.onicecandidateerror = null
                this.outgoingConnection.onconnectionstatechange = null
                this.outgoingConnection.close()
            }
    
            this.outgoingConnection = null
        }
    
        transmitToOutgoingConnection(tracks, stream) {
            if (!this.remotePeerConnected)
                this.pendingOutgoingConnection = {
                    tracks,
                    stream
                }
            else {
                this.startOutgoingConnection()
    
                tracks.forEach(track => this.outgoingConnection.addTrack(track, stream))
    
                this.outgoingConnection.createOffer()
                .then(offer => new Promise((resolve, reject) => this.outgoingConnection.setLocalDescription(new RTCSessionDescription(offer)).then(() => resolve(offer)).catch(error => reject(error))))
                .then(offer => this.emitToServer('transmission-offer', {
                    offer
                }))
                .catch(error => this.fatalError(error))
            }
        }
    
        fatalError(error) {
            if (typeof(error) ==='object' && error.type === 'icecandidateerror' && error.errorCode === 701)
                return

            this.close()
        }
    
        close() {
            this.emitToServer('peer-disconnect')

            this.remotePeerConnected = false

            this.stopIncomingConnection(false)
            this.stopOutgoingConnection()

            window.removeEventListener('message', this.emitServerParser)

            peerData = null
        }
    }
    
    window.CS_VIDEO_CALL = {}
    
    jQuery(document).ready(function() {
        $('head').append('<style>#cs-video-call-video-clone,#cs-video-call-virtual-video,.cs-video-call-incoming-call-container #cs-video-call-self-video-container{display:none}</style>')
    
        let times = []
        let activeTracks = []
        let lang = {}
    
        let callActive = false
        let isAnimating = false
        let isRendering = false
        let faceTracking = false
        let documentHooked = false
        let hookingDocument = false
        let unhookingDocument = false
        let backCamera = false
        let keyLabels = false
        let experimentalMode = false
        let pendingVideoTransmission = false
    
        let currentFilter = 0
        let fps = 0
        let cameraScale = 0.3
    
        let socket = null
        let transmitTimeout = null
        let fpsInterval = null
        let fpsElement = null
        let remoteVideo = null
        let selfVideoCanvas = null
        let selfVideoCanvasContext = null
        let remoteMediaRecorder = null
        let callContainer = null
        let cloneCanvas = null
        let cloneCanvasContext = null
        let virtualVideo = null
        let scene = null
        let camera = null
        let texture = null
        let proxyIpAddress = null
        let proxyPort = null
        let serverEndpoint = null
        let lastDataCheckInterval = null
        let faceTrackingInterval = null
        let lastFilterPositions = null
        let lastFilterPositionsEmptyAt = null
        let resourceName = null
        let dogFilter = null
        let catFilter = null

        let width = window.innerWidth
        let height = window.innerHeight
        let pixelRatio = window.devicePixelRatio

        const cTracker = new clm.tracker({
            useWebGL: true
        })
    
        const gameTexture = new cs_cfxThree.Texture()
    
        const material = new cs_cfxThree.ShaderMaterial({
            uniforms: {
                'tDiffuse': {
                    type: 't',
                    value: gameTexture
                }
            },
    
            vertexShader: `
                varying vec2 vUv;
        
                void main() {
                    vUv = vec2(uv.x, 1.0 - uv.y);
                    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
                }
            `,

            fragmentShader: `
                varying vec2 vUv;
                uniform sampler2D tDiffuse;
        
                void main() {
                    gl_FragColor = texture2D(tDiffuse, vUv);
                }
            `
        })
    
        const renderer = new cs_cfxThree.WebGLRenderer()
    
        gameTexture.image = {
            data: new Uint8Array(3),
            width: 1,
            height: 1
        }
    
        gameTexture.magFilter = cs_cfxThree.NearestFilter
        gameTexture.minFilter = cs_cfxThree.NearestFilter
        gameTexture.generateMipmaps = false
        gameTexture.flipY = false
        gameTexture.unpackAlignment = 1
        gameTexture.isDataTexture = true
        gameTexture.isCfxTexture = true
        gameTexture.needsUpdate = true
    
        cTracker.init()
    
        const resize = () => {
            width = window.innerWidth
            height = window.innerHeight
            pixelRatio = window.devicePixelRatio
    
            cameraScale = 0.3
    
            while (((width * cameraScale) < videoCallWidth) || ((height * cameraScale) < videoCallHeight))
                cameraScale += 0.1
    
            scene = new cs_cfxThree.Scene()
            camera = new cs_cfxThree.OrthographicCamera(width / -2, width / 2, height / 2, height / -2, -10000, 10000)
    
            const plane = new cs_cfxThree.PlaneBufferGeometry(width, height)
            const quad = new cs_cfxThree.Mesh(plane, material)
        
            camera.position.z = 100
            camera.zoom = cameraScale
        
            camera.updateProjectionMatrix()
        
            quad.position.z = -100
        
            scene.add(quad)
    
            renderer.setPixelRatio(pixelRatio)
            renderer.setSize(width, height)
    
            texture = new cs_cfxThree.WebGLRenderTarget(width, height, {
                minFilter: cs_cfxThree.NearestFilter,
                magFilter: cs_cfxThree.NearestFilter
            })
    
            renderer.setRenderTarget(texture)
        }
    
        resize()
    
        const refreshLoop = () => {
            const now = performance.now()
    
            while (times.length > 0 && times[0] <= (now - 1000))
                times.shift()
    
            times.push(now)
    
            fps = times.length
        }
    
        const animateVideo = (ctx, elements = {}) => {
            isRendering = true
    
            requestAnimationFrame(() => animate(ctx))
    
            if (elements.fps) {
                fpsElement = elements.fps
                fpsInterval = setInterval(() => jQuery(fpsElement).text(`${fps} FPS`), 1000)
                jQuery(fpsElement).text(`${fps} FPS`).show()
            }
        }
    
        const advanceVideoFilter = () => {
            currentFilter++

            if (currentFilter >= 8)
                currentFilter = 0

            if (currentFilter >= 6 && !faceTracking)
                startFaceTracking()
            else if (currentFilter <= 5 && faceTracking)
                stopFaceTracking()
        }
    
        const resetVideoFilter = () => currentFilter -= currentFilter

        const stopVideoRendering = () => {
            stopFaceTracking()

            if (fpsElement)
                jQuery(fpsElement).hide()
    
            clearInterval(fpsInterval)
                
            fpsElement = null
            isRendering = false
            fps = 0
            times = []
        }
    
        const onConditionsChanged = () => {
            if (!callActive) {
                if (isTransmitting)
                    stopVideoTransmission()
    
                if (peerData)
                    peerData.close()
    
                jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).hide()
                pendingVideoTransmission = false
            } else {
                if (peerData === null) {
                    if (isTransmitting)
                        stopVideoTransmission()

                    peerData = new PeerData(track => {
                        activeTracks.push(track)

                        if (remoteVideo) {
                            if (!useRecorder) {
                                remoteVideo.srcObject = new MediaStream()
                                remoteVideo.srcObject.addTrack(track)
                            } else {
                                if (remoteMediaRecorder) {
                                    remoteMediaRecorder.ondataavailable = null

                                    if (remoteMediaRecorder.state !== 'inactive')
                                        remoteMediaRecorder.stop()

                                    remoteMediaRecorder = null
                                }

                                const remoteMediaSource = new MediaSource()

                                remoteVideo.src = URL.createObjectURL(remoteMediaSource)

                                remoteMediaSource.addEventListener('sourceopen', e => {
                                    const remoteVideoBuffer = remoteMediaSource.addSourceBuffer('video/webm;codecs=vp8')
                                    const remoteVideoTempStream = new MediaStream()
                                    const remoteVideoReader = new FileReader()

                                    remoteVideoReader.onloadend = () => {
                                        try {
                                            remoteVideoBuffer.appendBuffer(new Uint8Array(remoteVideoReader.result))
                                        } catch (e) { }
                                    }

                                    remoteVideoTempStream.addTrack(track)

                                    remoteMediaRecorder = new MediaRecorder(remoteVideoTempStream, {
                                        mimeType: 'video/webm;codecs=vp8'
                                    })

                                    lastDataAvailableAt = new Date().getTime()

                                    remoteMediaRecorder.ondataavailable = e => {
                                        lastDataAvailableAt = new Date().getTime()

                                        try {
                                            if (!remoteVideoBuffer.updating)
                                                remoteVideoReader.readAsArrayBuffer(e.data)
                                        } catch (e) {}
                                    }

                                    remoteMediaRecorder.start(250)
                                }, false)
                            }

                            remoteVideo.play().catch(e => { })
                        }
                    }, isRestarting => {
                        activeTracks = []

                        if ((!isRestarting) && callContainer)
                            callContainer.removeClass('cs-video-call-remote-video-active')

                        if (remoteVideo && (!isRestarting))
                            jQuery(remoteVideo).fadeOut(750)

                        if (!isRestarting)
                            if (remoteMediaRecorder) {
                                remoteMediaRecorder.ondataavailable = null

                                if (remoteMediaRecorder.state !== 'inactive')
                                    remoteMediaRecorder.stop()

                                remoteMediaRecorder = null
                            }
                    }, proxyIpAddress, proxyPort, serverEndpoint)
                }

                jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).show()
            }
        }

        const renderKeyLabels = () => {
            if ((!callContainer) || (!lang.controls))
                return

            jQuery('[data-action="cs-video-call-swap-filter"]', callContainer).attr('data-cs-video-call-key-label', (!lang.controls.swapFilter) ? '' : lang.controls.swapFilter)
            jQuery('[data-action="cs-video-call-swap-camera"]', callContainer).attr('data-cs-video-call-key-label', (!lang.controls.swapCamera) ? '' : lang.controls.swapCamera)
            jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).attr('data-cs-video-call-key-label', (!lang.controls.swapTransmission) ? '' : lang.controls.swapTransmission)
            jQuery('[data-action="cs-video-call-swap-elements"]', callContainer).attr('data-cs-video-call-key-label', (!lang.controls.swapElements) ? '' : lang.controls.swapElements)
    
            jQuery('.cs-video-call-key-label', callContainer).remove()

            const labels = jQuery('[data-cs-video-call-key-label]', callContainer)

            for (let index = 0; index < labels.length; index++)
                jQuery(labels[index]).append(`<span class="cs-video-call-key-label" style="display: none">${jQuery(labels[index]).attr('data-cs-video-call-key-label')}</span>`)
        }

        const updateKeyLabels = () => {
            if (!callContainer)
                return

            if (!keyLabels) {
                callContainer.removeClass('cs-video-call-key-labels')
                jQuery('.cs-video-call-key-label', callContainer).css('visibility', 'hidden')
            } else {
                callContainer.addClass('cs-video-call-key-labels')
                
                jQuery('.cs-video-call-key-label', callContainer).each(function() {
                    if (jQuery(this).html().trim() !== '')
                        jQuery(this).css('visibility', 'visible')
                    else
                        jQuery(this).html('&nbsp;').css('visibility', 'hidden')
                })
            }
        }

        window.CS_VIDEO_CALL.setUsingMouse = state => {
            fetch(`https://${GetParentResourceName()}/cs-video-call:usingMouse`, {
                method: 'POST',
                body: JSON.stringify({
                    state
                })
            }).catch(error => {})
        }

        window.CS_VIDEO_CALL.setPendingVideoTransmission = () => {
            pendingVideoTransmission = true
        }

        window.CS_VIDEO_CALL.hookDocument = () => {
            if (documentHooked || hookingDocument || unhookingDocument)
                return

            documentHooked = true
            hookingDocument = true

            callContainer = window.CS_VIDEO_CALL.hookInterface()

            cloneCanvas = jQuery('#cs-video-call-video-clone', callContainer).get(0)
            virtualVideo = jQuery('#cs-video-call-virtual-video', callContainer).get(0)

            cloneCanvasContext = cloneCanvas.getContext('2d')

            callContainer.addClass('cs-video-call-incoming-call-container')

            virtualVideo.width = videoCallWidth
            virtualVideo.height = videoCallHeight
            virtualVideo.srcObject = cloneCanvas.captureStream()

            cloneCanvas.width = videoCallWidth
            cloneCanvas.height = videoCallHeight

            remoteVideo = jQuery('#cs-video-call-remote-video', callContainer).get(0)
            selfVideoCanvas = jQuery('#cs-video-call-self-video', callContainer).get(0)
            selfVideoCanvasContext = selfVideoCanvas.getContext('2d')
            selfVideoCanvasStream = selfVideoCanvas.captureStream()

            selfVideoCanvas.width = videoCallWidth
            selfVideoCanvas.height = videoCallHeight

            remoteVideo.onplay = event => {
                callContainer.addClass('cs-video-call-remote-video-active')
                jQuery(remoteVideo).fadeIn(750)
            }

            remoteVideo.onloadedmetadata = event => remoteVideo.play()

            if (remoteMediaRecorder) {
                remoteMediaRecorder.ondataavailable = null

                if (remoteMediaRecorder.state !== 'inactive')
                    remoteMediaRecorder.stop()
                
                remoteMediaRecorder = null
            }

            if (activeTracks.length > 0) {
                if (!useRecorder) {
                    remoteVideo.srcObject = new MediaStream()
    
                    for (let index = 0; index < activeTracks.length; index++)
                        remoteVideo.srcObject.addTrack(activeTracks[index])
                } else {
                    const remoteMediaSource = new MediaSource()
    
                    remoteVideo.src = URL.createObjectURL(remoteMediaSource)
    
                    remoteMediaSource.addEventListener('sourceopen', e => {
                        const remoteVideoBuffer = remoteMediaSource.addSourceBuffer('video/webm;codecs=vp8')
                        const remoteVideoTempStream = new MediaStream()
                        const remoteVideoReader = new FileReader()
    
                        remoteVideoReader.onloadend = () => {
                            try {
                                remoteVideoBuffer.appendBuffer(new Uint8Array(remoteVideoReader.result))
                            } catch (e) { }
                        }
    
                        for (let index = 0; index < activeTracks.length; index++)
                            remoteVideoTempStream.addTrack(activeTracks[index])
    
                        remoteMediaRecorder = new MediaRecorder(remoteVideoTempStream, {
                            mimeType: 'video/webm;codecs=vp8'
                        })
    
                        lastDataAvailableAt = new Date().getTime()
    
                        remoteMediaRecorder.ondataavailable = e => {
                            lastDataAvailableAt = new Date().getTime()
    
                            try {
                                if (!remoteVideoBuffer.updating)
                                    remoteVideoReader.readAsArrayBuffer(e.data)
                            } catch (e) {}
                        }
    
                        remoteMediaRecorder.start(250)
                    }, false)
                }

                remoteVideo.play().catch(e => { })
            }

            onConditionsChanged()
            renderKeyLabels()
            updateKeyLabels()

            if (useRecorder)
                lastDataCheckInterval = setInterval(() => {
                    const now = new Date().getTime()

                    if (remoteMediaRecorder && ((now - lastDataAvailableAt) / 1000) > 3) {
                        lastDataAvailableAt = now
                        console.error('[criticalscripts.shop] cs-video-call could not retrieve the remote feed. Make sure the required inbound UDP port is open and consult the package\'s store page for further information.')
                    }
                }, 250)

            hookingDocument = false
        }

        window.CS_VIDEO_CALL.unhookDocument = () => {
            if ((!documentHooked) || unhookingDocument || hookingDocument)
                return

            unhookingDocument = true

            if (isTransmitting)
                stopVideoTransmission()

            jQuery('#cs-video-call-video-clone', callContainer).remove()
            jQuery('#cs-video-call-virtual-video', callContainer).remove()
            jQuery('#cs-video-call-self-video-container', callContainer).remove()
            jQuery('#cs-video-call-remote-video', callContainer).remove()
            jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).remove()

            clearInterval(lastDataCheckInterval)

            lastDataCheckInterval =  null

            documentHooked = false
            unhookingDocument = false
        }

        const animate = ctx =>  {
            renderer.render(scene, camera)

            const read = new Uint8Array(width * height * 4)

            renderer.readRenderTargetPixels(texture, 0, 0, width, height, read)
    
            const imageData = new ImageData(new Uint8ClampedArray(read.buffer), width, height)

            switch (currentFilter) {
                case 1:
                    imageDataFilters.grayscale(imageData, {
                        amount: 1.0
                    })
    
                    break
    
                case 2:
                    imageDataFilters.sepia(imageData, {
                        amount: 1.0
                    })
    
                    break
    
                case 3:
                    imageDataFilters.invert(imageData, {
                        amount: 0.75
                    })
    
                    break
    
                case 4:
                    imageDataFilters.saturate(imageData, {
                        amount: 2.5
                    })
    
                    break
    
                case 5:
                    imageDataFilters.hueRotate(imageData, {
                        amount: 180
                    })
    
                    break
            }
    
            if (faceTracking)
                cloneCanvasContext.putImageData(imageData,
                    ((width / 2) * (1.0 + cameraScale)) - width - (width * cameraScale * (backCamera ? (experimentalMode ? experimentalCameraCropWidthBack : cameraCropWidthBack) : (experimentalMode ? experimentalCameraCropWidthFront : cameraCropWidthFront))),
                    ((height / 2) * (1.0 + cameraScale)) - height - (height * cameraScale * (experimentalMode ? experimentalCameraCropHeight : cameraCropHeight)),
            
                    width - ((width / 2) * (1.0 + cameraScale)) + (width * cameraScale * (backCamera ? (experimentalMode ? experimentalCameraCropWidthBack : cameraCropWidthBack) : (experimentalMode ? experimentalCameraCropWidthFront : cameraCropWidthFront))),
                    height - ((height / 2) * (1.0 + cameraScale)) + (height * cameraScale * (experimentalMode ? experimentalCameraCropHeight : cameraCropHeight)),
        
                    videoCallWidth, videoCallHeight)
    
            ctx.putImageData(imageData,
                ((width / 2) * (1.0 + cameraScale)) - width - (width * cameraScale * (backCamera ? (experimentalMode ? experimentalCameraCropWidthBack : cameraCropWidthBack) : (experimentalMode ? experimentalCameraCropWidthFront : cameraCropWidthFront))),
                ((height / 2) * (1.0 + cameraScale)) - height - (height * cameraScale * (experimentalMode ? experimentalCameraCropHeight : cameraCropHeight)),
        
                width - ((width / 2) * (1.0 + cameraScale)) + (width * cameraScale * (backCamera ? (experimentalMode ? experimentalCameraCropWidthBack : cameraCropWidthBack) : (experimentalMode ? experimentalCameraCropWidthFront : cameraCropWidthFront))),
                height - ((height / 2) * (1.0 + cameraScale)) + (height * cameraScale * (experimentalMode ? experimentalCameraCropHeight : cameraCropHeight)),

                videoCallWidth, videoCallHeight)

            if (fpsElement)
                refreshLoop()

            if (faceTracking && lastFilterPositions)
                switch (currentFilter) {
                    case 6:
                        dogFilter.apply(ctx, lastFilterPositions)
                        break
                        
                    case 7:
                        catFilter.apply(ctx, lastFilterPositions)
                        break
                }

            setTimeout(() => {
                if (isRendering)
                    requestAnimationFrame(() => animate(ctx))
            }, 1)
        }

        const startVideoTransmission = () => {
            if (!canTransmit) {
                fetch(`https://${GetParentResourceName()}/cs-video-call:transmissionRejectedFromExport`, {
                    method: 'POST',
                    body: JSON.stringify({})
                }).catch(error => {})

                return
            }

            callContainer.addClass('cs-video-call-video-active')
            isTransmitting = true
            transmitTimeout = setTimeout(() => jQuery('#cs-video-call-self-video-container', callContainer).fadeIn(500, () => peerData && peerData.transmitToOutgoingConnection(selfVideoCanvasStream.getVideoTracks(), selfVideoCanvasStream)), 500)
    
            resetVideoFilter()
            animateVideo(selfVideoCanvasContext)
    
            fetch(`https://${GetParentResourceName()}/cs-video-call:videoOn`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(error => {})
        }

        const stopVideoTransmission = () => {
            clearTimeout(transmitTimeout)
    
            isTransmitting = false
    
            if (peerData) {
                peerData.stopOutgoingConnection()
                peerData.emitToServer('transmission-stop')
            }
    
            if (jQuery('#cs-video-call-self-video-container', callContainer).length > 0)
                jQuery('#cs-video-call-self-video-container', callContainer).fadeOut(500, () => callContainer.removeClass('cs-video-call-video-active').removeClass('cs-video-call-swapped'))
            else
                callContainer.removeClass('cs-video-call-video-active').removeClass('cs-video-call-swapped')
    
            stopVideoRendering()
    
            fetch(`https://${GetParentResourceName()}/cs-video-call:videoOff`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(error => {})
        }
    
        const startFaceTracking = () => {
            if (faceTracking)
                return
    
            faceTracking = true
    
            virtualVideo.play().catch(e => {})

            faceTrackingInterval = setInterval(() => {
                cTracker.start(virtualVideo)

                const pos = cTracker.track(virtualVideo)

                if (pos) {
                    lastFilterPositions = pos
                    lastFilterPositionsEmptyAt = null
                } else {
                    const now = new Date().getTime()

                    if (!lastFilterPositionsEmptyAt)
                        lastFilterPositionsEmptyAt = now

                    if (((now - lastFilterPositionsEmptyAt) / 1000) > 1)
                        lastFilterPositions = null
                }

                cTracker.stop()
                cTracker.reset()
            }, 50)
        }

        const stopFaceTracking = () => {
            if (!faceTracking)
                return

            faceTracking = false
            lastFilterPositions = null
            lastFilterPositionsEmptyAt = null

            clearInterval(faceTrackingInterval)

            cTracker.stop()
            cTracker.reset()

            virtualVideo.pause()
        }

        const swapFilter = () => {
            if (!jQuery('[data-action="cs-video-call-swap-filter"]', callContainer).is(':visible'))
                return
    
            if (isAnimating)
                return
    
            advanceVideoFilter()
        }

        const swapCamera = () => {
            if (!jQuery('[data-action="cs-video-call-swap-camera"]', callContainer).is(':visible'))
                return
    
            if (isAnimating)
                return
    
            jQuery(selfVideoCanvas).css('opacity', '0')

            let wasFaceTracking = faceTracking

            if (faceTracking)
                stopFaceTracking()
    
            const videoTracks = selfVideoCanvasStream.getVideoTracks()
    
            for (let index = 0; index < videoTracks.length; index++)
                videoTracks[index].enabled = false
    
            setTimeout(() => jQuery(selfVideoCanvas).animate({
                opacity: callContainer.hasClass('cs-video-call-opaque') ? '1.0' : '0.85'
            }, 500, () => {
                for (let index = 0; index < videoTracks.length; index++)
                    videoTracks[index].enabled = true
                
                if (wasFaceTracking)
                    startFaceTracking()
            }), 250)
    
            fetch(`https://${GetParentResourceName()}/cs-video-call:swapCamera`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(error => {})
        }
    
        const swapElements = () => {
            if (!jQuery('[data-action="cs-video-call-swap-elements"]', callContainer).is(':visible'))
                return
    
            if (isAnimating)
                return

            callContainer.toggleClass('cs-video-call-swapped')
        }
    
        const swapTransmission = () => {
            if (!jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).is(':visible'))
                return
    
            if (isAnimating)
                return
    
            isAnimating = true
    
            setTimeout(() => isAnimating = false, 750)

            if (isTransmitting)
                stopVideoTransmission()
            else
                startVideoTransmission()
        }
    
        jQuery('body').on('click', '.cs-video-call-incoming-call-container [data-action="cs-video-call-swap-filter"]', event => swapFilter())
        jQuery('body').on('click', '.cs-video-call-incoming-call-container [data-action="cs-video-call-swap-camera"]', event => swapCamera())
        jQuery('body').on('click', '.cs-video-call-incoming-call-container [data-action="cs-video-call-swap-elements"]', event => swapElements())
        jQuery('body').on('click', '.cs-video-call-incoming-call-container [data-action="cs-video-call-swap-transmission"]', event => swapTransmission())
        
        setInterval(() => {
            if (pendingVideoTransmission && jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).is(':visible')) {
                pendingVideoTransmission = false
                jQuery('[data-action="cs-video-call-swap-transmission"]', callContainer).click()
            }
        }, pendingVideoTransmissionIntervalMs)
    
        window.addEventListener('message', event => {
            const data = event.data
    
            if (data.type && data.type.startsWith('cs-video-call:'))
                switch (data.type) {
                    case 'cs-video-call:initialize':
                        $('head').append(`<style>${data.hookFiles.style}</style>`)
                        $('body').append(`<script>${data.hookFiles.dom}</script>`)
    
                        proxyIpAddress = data.proxyIpAddress
                        serverEndpoint = data.serverEndpoint
                        proxyPort = data.proxyPort
                        canTransmit = data.canTransmit
                        lang = data.lang
                        experimentalMode = data.experimentalMode
                        resourceName = data.resourceName
                        turnUsername = data.turnUsername
                        turnPassword = data.turnPassword

                        dogFilter = {
                            rightEar: jQuery(`<img src="nui://${resourceName}/client/filters/dog-ear-r.png" />`).get(0),
                            leftEar: jQuery(`<img src="nui://${resourceName}/client/filters/dog-ear-l.png" />`).get(0),
                            nose: jQuery(`<img src="nui://${resourceName}/client/filters/dog-m.png" />`).get(0),
                    
                            apply: (ctx, positions) => {
                                if (positions.length >= 20) {
                                    ctx.save()
                                    ctx.translate(-83, -75)
                                    ctx.drawImage(dogFilter.rightEar, positions[20][0], positions[20][1], dogFilter.rightEar.width / 2, dogFilter.rightEar.height / 2)
                                    ctx.restore()
                                }
                    
                                if (positions.length >= 16) {
                                    ctx.save()
                                    ctx.translate(-53, -75)
                                    ctx.drawImage(dogFilter.leftEar, positions[16][0], positions[16][1], dogFilter.leftEar.width / 2, dogFilter.leftEar.height / 2)
                                    ctx.restore()
                                }
                    
                                if (positions.length >= 62) {
                                    ctx.save()
                                    ctx.translate(-55, -20)
                                    ctx.drawImage(dogFilter.nose, positions[62][0], positions[62][1], dogFilter.nose.width / 2, dogFilter.nose.height / 2)
                                    ctx.restore()
                                }
                            }
                        }
                    
                        catFilter = {
                            rightEar: jQuery(`<img src="nui://${resourceName}/client/filters/cat-ear-r.png" />`).get(0),
                            leftEar: jQuery(`<img src="nui://${resourceName}/client/filters/cat-ear-l.png" />`).get(0),
                            nose: jQuery(`<img src="nui://${resourceName}/client/filters/cat-m.png" />`).get(0),
                    
                            apply: (ctx, positions) => {
                                if (positions.length >= 20) {
                                    ctx.save()
                                    ctx.translate(-83, -125)
                                    ctx.drawImage(catFilter.rightEar, positions[20][0], positions[20][1], catFilter.rightEar.width / 2, catFilter.rightEar.height / 2)
                                    ctx.restore()
                                }
                    
                                if (positions.length >= 16) {
                                    ctx.save()
                                    ctx.translate(-53, -125)
                                    ctx.drawImage(catFilter.leftEar, positions[16][0], positions[16][1], catFilter.leftEar.width / 2, catFilter.leftEar.height / 2)
                                    ctx.restore()
                                }
                    
                                if (positions.length >= 62) {
                                    ctx.save()
                                    ctx.translate(-80, -15)
                                    ctx.drawImage(catFilter.nose, positions[62][0], positions[62][1], catFilter.nose.width / 2, catFilter.nose.height / 2)
                                    ctx.restore()
                                }
                            }
                        }
    
                        if (!socket)
                            return

                        renderKeyLabels()
                        updateKeyLabels()
    
                        break
    
                    case 'cs-video-call:call-state':
                        callActive = data.active
    
                        onConditionsChanged()

                        break

                    case 'cs-video-call:experimental-mode':
                        experimentalMode = data.state
                        break

                    case 'cs-video-call:swap-filter':
                        swapFilter()
                        break

                    case 'cs-video-call:swap-camera':
                        swapCamera()
                        break

                    case 'cs-video-call:swap-elements':
                        swapElements()
                        break

                    case 'cs-video-call:swap-transmission':
                        swapTransmission()
                        break

                    case 'cs-video-call:back-camera':
                        backCamera = data.active
                        break

                    case 'cs-video-call:can-transmit':
                        canTransmit = data.state

                        if (isTransmitting)
                            stopVideoTransmission()

                        break

                    case 'cs-video-call:labels':
                        keyLabels = data.state
                        updateKeyLabels()

                        break

                    case 'cs-video-call:stop-transmission':
                        if (isTransmitting)
                            stopVideoTransmission()

                        break
                }
        })

        window.addEventListener('resize', event => resize())

        fetch(`https://${GetParentResourceName()}/cs-video-call:jsReady`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(error => {})
    })
}) ()
