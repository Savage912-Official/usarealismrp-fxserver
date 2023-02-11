;(() => {
    const videoPlayerVolume = 0.5
    const videoWidth = 300
    const videoHeight = 543
    const thumbnailWidth = 100
    const thumbnailHeight = 100

    const cameraCropWidthFront = 0.20
    const cameraCropWidthBack = 0.45
    const cameraCropHeight = 0.0

    const experimentalCameraCropWidthFront = 0.35
    const experimentalCameraCropWidthBack = 0.45
    const experimentalCameraCropHeight = 0.0

    window.CS_STORIES = {
        documentHooked: false,
        isAnimating: false
    }

    jQuery(document).ready(function() {
        jQuery('head').append('<style>#cs-stories-self-video,#cs-stories-video-clone,#cs-stories-virtual-video,#cs-stories-thumbnail-generator{display:none}</style>')

        let times = []
        let entries = []
        let lang = {}

        let hookingDocument = false
        let unhookingDocument = false
        let isRendering = false
        let isRecorded = false
        let isUploading = false
        let isVisible = false
        let isBecomingVisible = false
        let isViewing = false
        let faceTracking = false
        let backCamera = false
        let keyLabels = false
        let experimentalMode = false

        let bottomToTop = '0px'
        let topToBottom = '0px'

        let currentFilter = 0
        let fps = 0
        let notchOffset = 0
        let lastVideoDuration = 0
        let cameraScale = 0.3
    
        let storyTimeInterval = null
        let fpsInterval = null
        let fpsElement = null
        let storiesContainer = null
        let storiesButton = null
        let cloneCanvas = null
        let cloneCanvasContext = null
        let cloneCanvasStream = null
        let selfVideoCanvas = null
        let selfVideoCanvasContext = null
        let selfVideoCanvasStream = null
        let virtualVideo = null
        let videoPlayer = null
        let videoTime = null
        let scene = null
        let camera = null
        let texture = null
        let lastThumbnail = null
        let thumbnailGeneratorCanvas = null
        let thumbnailGeneratorCanvasContext = null
        let faceTrackingInterval = null
        let lastFilterPositions = null
        let lastFilterPositionsEmptyAt = null
        let videoPlayingInterval = null
        let pendingUploadVideo = null
        let pendingUploadVideoDuration = null
        let pendingUploadThumbnail = null

        let width = window.innerWidth
        let height = window.innerHeight
        let pixelRatio = window.devicePixelRatio

        let baseUrl = null
        let resourceName = null
        let accessKey = null
        let homeLimit = null
        let maxDuration = null
        let animatingTimeout = null
        let recordingTimeout = null
        let recordingInterval = null
        let activeAudioTrack = null
        let audioDevices = null
        let dogFilter = null
        let catFilter = null
        let isRecording = false
        let playerTalking = false

        navigator.mediaDevices.getUserMedia({
            audio: true,
            video: false
        }).then(devices => {
            audioDevices = devices
        }).catch(e => {})

        const cTracker = new clm.tracker({
            useWebGL: true
        })
    
        const gameTexture = new cfxThree.Texture()
    
        const material = new cfxThree.ShaderMaterial({
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
        `})
    
        const renderer = new cfxThree.WebGLRenderer()

        gameTexture.image = {
            data: new Uint8Array(3),
            width: 1,
            height: 1
        }

        gameTexture.magFilter = cfxThree.NearestFilter
        gameTexture.minFilter = cfxThree.NearestFilter
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

            while (((width * cameraScale) < videoWidth) || ((height * cameraScale) < videoHeight))
                cameraScale += 0.1

            scene = new cfxThree.Scene()
            camera = new cfxThree.OrthographicCamera(width / -2, width / 2, height / 2, height / -2, -10000, 10000)

            const plane = new cfxThree.PlaneBufferGeometry(width, height)
            const quad = new cfxThree.Mesh(plane, material)
        
            camera.position.z = 100
            camera.zoom = cameraScale
        
            camera.updateProjectionMatrix()
        
            quad.position.z = -100
        
            scene.add(quad)
    
            renderer.setPixelRatio(pixelRatio)
            renderer.setSize(width, height)
    
            texture = new cfxThree.WebGLRenderTarget(width, height, {
                minFilter: cfxThree.NearestFilter,
                magFilter: cfxThree.NearestFilter
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
    
            if (fpsElement !== null)
                jQuery(fpsElement).hide()
    
            clearInterval(fpsInterval)
                
            fpsElement = null
            isRendering = false
            fps = 0
            times = []
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
        
                    videoWidth, videoHeight)
    
            ctx.putImageData(imageData,
                ((width / 2) * (1.0 + cameraScale)) - width - (width * cameraScale * (backCamera ? (experimentalMode ? experimentalCameraCropWidthBack : cameraCropWidthBack) : (experimentalMode ? experimentalCameraCropWidthFront : cameraCropWidthFront))),
                ((height / 2) * (1.0 + cameraScale)) - height - (height * cameraScale * (experimentalMode ? experimentalCameraCropHeight : cameraCropHeight)),
        
                width - ((width / 2) * (1.0 + cameraScale)) + (width * cameraScale * (backCamera ? (experimentalMode ? experimentalCameraCropWidthBack : cameraCropWidthBack) : (experimentalMode ? experimentalCameraCropWidthFront : cameraCropWidthFront))),
                height - ((height / 2) * (1.0 + cameraScale)) + (height * cameraScale * (experimentalMode ? experimentalCameraCropHeight : cameraCropHeight)),

                videoWidth, videoHeight)

            if (fpsElement !== null)
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

            if (lastThumbnail === null) {
                thumbnailGeneratorCanvasContext.drawImage(ctx.canvas, 0, -35 , ctx.canvas.width / 3, ctx.canvas.height / 3)
                lastThumbnail = thumbnailGeneratorCanvas.toDataURL('image/jpeg', 0.8)
            }

            setTimeout(() => {
                if (isRendering)
                    requestAnimationFrame(() => animate(ctx))
            }, 1)
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
    
            virtualVideo.pause()

            clearInterval(faceTrackingInterval)

            cTracker.stop()
            cTracker.reset()

            virtualVideo.pause()
        }

        clearVideoThumbnail = () => lastThumbnail = null
        getVideoThumbnail = () => lastThumbnail

        const swapRecording = () => {
            if (window.CS_STORIES.isAnimating)
                return

            if (jQuery('[data-action="cs-stories-open-record"]', storiesContainer).is(':visible') && (!isRendering) && (!isRecorded))
                jQuery('[data-action="cs-stories-open-record"]', storiesContainer).click()
            else if (jQuery('[data-action="cs-stories-record-video"]', storiesContainer).is(':visible') && isRendering)
                jQuery('[data-action="cs-stories-record-video"]', storiesContainer).click()
            else if (jQuery('.cs-stories-progress-ring', storiesContainer).is(':visible') && isRecording)
                jQuery('.cs-stories-progress-ring', storiesContainer).click()
            else if (jQuery('[data-action="cs-stories-upload-video"]', storiesContainer).is(':visible') && isRecorded)
                jQuery('[data-action="cs-stories-upload-video"]', storiesContainer).click()
        }

        const swapFilter = () => {
            if ((!jQuery('[data-action="cs-stories-swap-filter"]', storiesContainer).is(':visible')) || window.CS_STORIES.isAnimating)
                return

            advanceVideoFilter()
        }

        const swapCamera = () => {
            if ((!jQuery('[data-action="cs-stories-swap-camera"]', storiesContainer).is(':visible')) || window.CS_STORIES.isAnimating)
                return

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)
    
            jQuery(selfVideoCanvas).css('opacity', '0')
    
            const videoTracks = cloneCanvasStream.getVideoTracks()
    
            for (let index = 0; index < videoTracks.length; index++)
                videoTracks[index].enabled = false
    
            setTimeout(() => jQuery(selfVideoCanvas).animate({
                opacity: '0.85'
            }, 500, () => {
                for (let index = 0; index < videoTracks.length; index++)
                    videoTracks[index].enabled = true
            }), 250)

            animatingTimeout = setTimeout(() => {
                window.CS_STORIES.isAnimating = false
            }, 750)
    
            fetch(`https://${GetParentResourceName()}/cs-stories:swapCamera`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(error => {})
        }

        const showStories = () => {
            if (window.CS_STORIES.isAnimating)
                return

            if (window.CS_STORIES.onShowStories)
                window.CS_STORIES.onShowStories()

            cancelAndReset()

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            storiesContainer.fadeIn(500)
            isBecomingVisible = true
            
            jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                top: bottomToTop
            }, 500)
    
            animatingTimeout = setTimeout(() => {
                window.CS_STORIES.isAnimating = false
                isBecomingVisible = false
                isVisible = true
            }, 500)
        }

        const cancelAndReset = () => {
            clearTimeout(animatingTimeout)
            clearInterval(recordingInterval)
            clearInterval(videoPlayingInterval)
            clearTimeout(recordingTimeout)

            if (window.CS_STORIES.isRecording())
                stopRecording(true)

            if (videoPlayer) {
                videoPlayer.pause()
                videoPlayer.src = ''
                videoPlayer.volume = videoPlayerVolume
                videoPlayer.currentTime = 0

                jQuery('span', jQuery(videoTime)).css('width', '0%')
                jQuery(videoPlayer).hide()
                jQuery(videoTime).hide()
            }

            if (selfVideoCanvas)
                jQuery(selfVideoCanvas).hide()

            if (storiesContainer) {
                jQuery('.cs-stories-loading-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-progress-ring', storiesContainer).hide()
                jQuery('.cs-stories-video-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-upload-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-video-delete-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-info-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-play-indicator', storiesContainer).hide()
                jQuery('.cs-stories-close-video-wrapper', storiesContainer).show()
                jQuery('.cs-stories-close-record-wrapper', storiesContainer).show()
                jQuery('.cs-stories-record-wrapper', storiesContainer).show()

                jQuery('[data-action="cs-stories-record-video"]', storiesContainer).show()
                jQuery('[data-action="cs-stories-swap-filter"]', storiesContainer).show()
                jQuery('[data-action="cs-stories-swap-camera"]', storiesContainer).show()

                jQuery('.cs-stories-home-wrapper', storiesContainer).css('top', '250px')
                jQuery('.cs-stories-record-wrapper', storiesContainer).css('top', '250px')
                jQuery('.cs-stories-video-delete-wrapper', storiesContainer).css('top', '250px')
                jQuery('.cs-stories-close-video-wrapper', storiesContainer).css('top', '250px')
                jQuery('.cs-stories-close-record-wrapper', storiesContainer).css('top', '-250px')
                jQuery('.cs-stories-wrapper', storiesContainer).show()

                storiesContainer.hide()
            }

            isVisible = false
            isBecomingVisible = false
            isRecording = false
            isRecorded = false
            isViewing = false

            window.CS_STORIES.isAnimating = false

            closeVideo()
        }

        const closeVideo = () => {
            videoClosed = true

            stopVideoRendering()

            if (storiesContainer)
                storiesContainer.removeClass('cs-stories-cs-video-call-video-active')

            fetch(`https://${GetParentResourceName()}/cs-stories:videoOff`, {
                method: 'POST',
                body: JSON.stringify({})
            }).catch(error => {})
        }

        const dataURLtoBlob = dataURL => {
            const dataArr = dataURL.split('base64,')
            const dataBinary = atob(dataArr[1])
            const dataUintArr = new Uint8Array(dataBinary.length)

            let mime = dataArr[0].replace('data:', '').split(';')

            mime.pop()
            mime = mime.join(';')

            let dataLength = dataBinary.length

            while (dataLength--)
                dataUintArr[dataLength] = dataBinary.charCodeAt(dataLength)

            return new Blob([dataUintArr], {
                type: mime
            })
        }

        const stopRecording = discard => {
            if (!isRecording)
                return

            clearTimeout(recordingTimeout)

            isRecorded = true
            isRecording = false
            clearInterval(recordingInterval)

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            if (discard) {
                recorder.stop(blob => {})

                isRecorded = false
                window.CS_STORIES.isAnimating = false

                jQuery('.cs-stories-progress-ring', storiesContainer).hide()
                jQuery('[data-action="cs-stories-record-video"]', storiesContainer).show()

                return
            }

            stopVideoRendering()

            jQuery('.cs-stories-record-wrapper', storiesContainer).fadeOut(500)
            jQuery('.cs-stories-close-record-wrapper', storiesContainer).fadeOut(500)

            jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeIn(500, () => {
                closeVideo()

                animatingTimeout = setTimeout(() => {
                    window.CS_STORIES.isAnimating = false
                }, 1000)

                jQuery(selfVideoCanvas).hide()
                jQuery(videoPlayer).show()
                jQuery(videoTime).show()

                videoPlayer.currentTime = 0

                jQuery('span', jQuery(videoTime)).css('width', '0%')

                jQuery('.cs-stories-upload-wrapper', storiesContainer).show()
                jQuery('.cs-stories-play-indicator', storiesContainer).show()

                recorder.stop(blob => {
                    if (!jQuery(videoPlayer).is(':visible'))
                        return

                    setTimeout(() => {
                        jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(500)
                    }, 500)

                    videoPlayer.src = URL.createObjectURL(blob)
                    videoPlayer.volume = videoPlayerVolume

                    jQuery('[data-action="cs-stories-upload-video"]', storiesContainer).off('click').on('click', event => {
                        if (isUploading || window.CS_STORIES.isAnimating)
                            return

                        isRecorded = false
                        isUploading = true

                        pendingUploadVideoDuration = videoPlayer.duration

                        window.CS_STORIES.isAnimating = true
                        clearTimeout(animatingTimeout)

                        videoPlayer.pause()

                        jQuery('.cs-stories-play-indicator', storiesContainer).fadeOut(500)
                        jQuery('.cs-stories-upload-wrapper', storiesContainer).fadeOut(500)

                        jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeIn(500, () => {
                            videoPlayer.src = ''
                            videoPlayer.volume = videoPlayerVolume
                            videoPlayer.currentTime = 0

                            jQuery(videoPlayer).hide()
                            jQuery(videoTime).hide()

                            jQuery('.cs-stories-wrapper', storiesContainer).fadeIn(500)

                            jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                                top: bottomToTop
                            }, 500)

                            animatingTimeout = setTimeout(() => {
                                window.CS_STORIES.isAnimating = false
                            }, 500)

                            jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(500, () => {
                                const reader = new FileReader()

                                reader.onloadend = e => {
                                    pendingUploadThumbnail = getVideoThumbnail()
                                    pendingUploadVideo = reader.result

                                    fetch(`https://${GetParentResourceName()}/cs-stories:storyPreUpload`, {
                                        method: 'POST',
                                        body: JSON.stringify({})
                                    }).catch(error => {})
                                }

                                reader.onerror = e => {
                                    isUploading = false

                                    fetch(`https://${GetParentResourceName()}/cs-stories:storyUploadFailed`, {
                                        method: 'POST',
                                        body: JSON.stringify({})
                                    }).catch(error => {})
                                }

                                reader.onabort = e => {
                                    isUploading = false

                                    fetch(`https://${GetParentResourceName()}/cs-stories:storyUploadFailed`, {
                                        method: 'POST',
                                        body: JSON.stringify({})
                                    }).catch(error => {})
                                }

                                reader.readAsDataURL(blob)
                            })
                        })
                    })
                })
            })
        }

        const renderKeyLabels = () => {
            if ((!storiesContainer) || (!lang.controls))
                return

            jQuery('[data-action="cs-stories-delete-video"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.delete) ? '' : lang.controls.delete)
            jQuery('[data-action="cs-stories-delete-video-confirm"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.delete) ? '' : lang.controls.delete)
            jQuery('[data-action="cs-stories-delete-video-cancel"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.backspace) ? '' : lang.controls.backspace)
            jQuery('[data-action="cs-stories-close-video"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.backspace) ? '' : lang.controls.backspace)
            jQuery('[data-action="cs-stories-discard-video"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.backspace) ? '' : lang.controls.backspace)
            jQuery('[data-action="cs-stories-close-record"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.backspace) ? '' : lang.controls.backspace)
            jQuery('[data-action="cs-stories-close-home"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.backspace) ? '' : lang.controls.backspace)
            jQuery('[data-action="cs-stories-swap-filter"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.swapFilterControl) ? '' : lang.controls.swapFilterControl)
            jQuery('[data-action="cs-stories-swap-camera"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.swapCameraControl) ? '' : lang.controls.swapCameraControl)
            jQuery('[data-action="cs-stories-open-record"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.swapRecordingControl) ? '' : lang.controls.swapRecordingControl)
            jQuery('[data-action="cs-stories-record-video"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.swapRecordingControl) ? '' : lang.controls.swapRecordingControl)
            jQuery('[data-action="cs-stories-upload-video"]', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.swapRecordingControl) ? '' : lang.controls.swapRecordingControl)
            jQuery('.cs-stories-progress-ring', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.swapRecordingControl) ? '' : lang.controls.swapRecordingControl)
            jQuery('.cs-stories-play-indicator', storiesContainer).attr('data-cs-stories-key-label', (!lang.controls.spacebar) ? '' : lang.controls.spacebar)

            jQuery('.cs-stories-key-label', storiesContainer).remove()

            const labels = jQuery('[data-cs-stories-key-label]', storiesContainer)

            for (let index = 0; index < labels.length; index++)
                jQuery(labels[index]).append(`<span class="cs-stories-key-label">${jQuery(labels[index]).attr('data-cs-stories-key-label')}</span>`)
        }

        const updateKeyLabels = () => {
            if (!storiesContainer)
                return

            if (!keyLabels) {
                storiesContainer.removeClass('cs-stories-key-labels')
                jQuery('.cs-stories-key-label', storiesContainer).css('visibility', 'hidden')
            } else {
                storiesContainer.addClass('cs-stories-key-labels')
                
                jQuery('.cs-stories-key-label', storiesContainer).each(function() {
                    if (jQuery(this).html().trim() !== '')
                        jQuery(this).css('visibility', 'visible')
                    else
                        jQuery(this).html('&nbsp;').css('visibility', 'hidden')
                })
            }
        }

        const renderStoryOrStories = story => {
            if (story) {
                jQuery('.cs-stories-no-stories', storiesContainer).hide()

                const template = jQuery(window.CS_STORIES.getStoryTemplate(story, lang))
                jQuery('img.cs-stories-story-thumbnail', template).attr('onerror', 'this.onerror=null;this.src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAMAAAD04JH5AAAAAXNSR0IB2cksfwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAjRQTFRFAAAA////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////nRJgAAAAALx0Uk5TAAEUSEMMat3ZUgf/4NjrPPBPBlHq3lkQOu9pTfVTDVd+CWj0/CJiQfJ4bGNQ5sUvfNz71jlY8eX+/el0Ck7jrKauwBb3VAjf9sPCgYBVayZ1ln0y8yU0IbPJXHFtxhwFQtFhcMRn+IYL1zDtqARHc1bsbwPLMX9ltefbvYoSzy49yOLhQAIZ+u7BqivkTB43G5y4q9Ugg0ToWyPOvIfTxx+pt0oz0vl6RqO0JNDaLDYoXbaxETh3LRo/WknbuLVhAAAF9klEQVR4nO2a6V8TRxjHNwiEZTiSLElQYGMgaAohiBVdhAWRAIKAQgMolGJFaWxLpQrUWgUVotJiT631KPa0lV629vaf6zybA9lsIMke86L7e5N8mN3Ml+eZ55lnDorSpUuXLl26dOnSFSND2qb0DJIAaZnGLDqbIMAmI0I5NEGA9FyEUF4+OYAMOgcTmMwWYgQWpgATWG12YgRU4WawwRZyAFQRHoiouIQlBmBxgA2sW53ECOylZQi5jDYSfZdv227AH7TRhZD7uQoFVVmeEICnyluNCdgdNdgLrp0KqsqTEAAOwud34U9n7W6krAqYRAHQHgd4wex1wXtcnRJKDmBvPQA08BCNqLFpn3w1700KYH+L8NXC+yAaaQXyQcv+VAAoql7IiRXkANhW8IKPaSMFgGcmsEE7LzcnpgxAsZkHcDroKCEGgDOTFXJiiTwbyAFo4zuxF4wHZdUHcgAoJ4Nzoqs9sdfVAMB/q8Fe8FXIyAcyAZxdVsgHdOp1okwAyu45ADmxmxgARfWYwAYbV+uHDvf2vRAbMfIBWBq84Devu2Yy9PfC7OHqGBA7Sz4AZWkFG1jNDeu8O3iEC039R4cMigPgat0PNhiO/2rGi1yk+Bh5SQUAygwzk9s2Gu/VYy9Hqx+TaLwqA5DNuyEnxl0vHC+LAnBb1QCgGsYgJ56INzOdHF8tAF9RBYCiaqFaL+al5wWmMdr/+EmVAEbpDqgPugJSjYO90UF46lU1ACC02JJi7AWrWao9m3kt3L/vddE4UQJg4o3OWkDg28ELp6VsMDEJsxaqe/NMmqhFAYCzhVOcdxp/sc9ANOZJ7iM53zqX+/b5dy5cFDfIB3Bun8XdZhViGwR4CLecbslovDh3abolNlPIBzheEB5c4IXhgg1youIAdsYfHl6XYdUWYGAfyV0SNycqDcBeuBKN8PkFCmYmyIntHsloVB7AUNoYDXDENQ0GMRLkxLrOhHcwZAFcHbv27Cqb8wrd0la84i0uSrBOlANQvu+6aKG/J38C50TzItQHM4kRyAAIHjRxIgD0LpRmAQfsI1mL1AUIvjci7h20ZINovCHMTLbVkWh4v8l/9IOgggCGDz+K+fdD42AOt7J9kBM7PdFotPdhoo8PKQiQ/4lPqn+smwuwk3UDe6GuPVIf3PpU2FY61x9rg9QARm9/Fqd7rPk7kPAdizgW3MPCSLwL38E897bFEKQEMFp9P37/CN27AznRLFTr3dnYW5/XRZqWY2yQEsDkA9d6AKGcOEqD2XPowBdfmlabvvpagbJ814b7hDfnoJsxyMp5p5vXjNbcb+QCBCq/3ah/hIScyLbCzPRQ1DR7d40NkgY4+12BZPytFbcEOTF0wiHWke8nZABc5ecT6B/rUTV+JTBcFtviX/khdYAfHyXUO0K7J0MbeEVGifE6O7AaC0kCPByP/TkpNc6EzWxxXJZo/mkhOg6SBEhQ1w/fwi/8/Avuxs5LeAGtPI7YQBWAzb/i/z94e2neET3hEGu20qAegKsZ+3+i/zeEHggnHMLMJNZyOBrVADAN4aePPdmJv4ZOOGxuiaeehAjUALh2hqJ+Dz+cNS1U636Jx+7/oRYAWhr+czHy/UQtFT3hEGn2sUGtKHhGOCca4IRDygsrC0H1AfBw+wu8IJz6inV+QAsAbsoGQd8q6YWBv9UHwPWB4AVG0gZDixoAcE3/4PfZHqkycsSqAQC2gVCtCyccEtIAgPPC6t3eVUMKAKFTsIMhnHAQAkCN/4IXmE4JL2gDgKYgHzh5KzEAbjkdE7QJJxxEACI5MTMmH2gGwE3BOGAZcU7UDACPxMIg7COJbKAhAGqCVRtbvzYnagmAcyL8Fr+mTkwQwFOlyI0V6yX8W5Yir9C1K5lLLOWVitzZ6REWrg0eyImulWSu8SisWtg/L95C7maccwdEo8lG7nYgS8OaSfqEQyOVCjdhCN7RtDvin3BoIwsP20c5DMHbwoWQ3XLTyQFQcMJhfEoQIJvJNVbEPY3UQhnpT1sMGz+mS5cuXbp06dL1/9N/AlXbZFuLXd0AAAAASUVORK5CYII="')
                jQuery('.cs-stories-wrapper', storiesContainer).prepend(template)

                while (jQuery('.cs-stories-story-entry', storiesContainer).length > homeLimit)
                    jQuery('.cs-stories-wrapper .cs-stories-story-entry:last-child', storiesContainer).remove()

                if (jQuery('.cs-stories-story-entry.cs-stories-selected', storiesContainer).length === 0)
                    jQuery('.cs-stories-story-entry:first', storiesContainer).addClass('cs-stories-selected')
            } else if (entries.length === 0)
                jQuery('.cs-stories-wrapper', storiesContainer).html(`<p class="cs-stories-no-stories">${lang.noStoriesPosted}</p>`)
            else {
                jQuery('.cs-stories-wrapper', storiesContainer).html('')

                for (let index = 0; index < entries.length; index++) {
                    const template = jQuery(window.CS_STORIES.getStoryTemplate(entries[index], lang))
                    jQuery('img.cs-stories-story-thumbnail', template).attr('onerror', 'this.onerror=null;this.src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAMAAAD04JH5AAAAAXNSR0IB2cksfwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAjRQTFRFAAAA////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////nRJgAAAAALx0Uk5TAAEUSEMMat3ZUgf/4NjrPPBPBlHq3lkQOu9pTfVTDVd+CWj0/CJiQfJ4bGNQ5sUvfNz71jlY8eX+/el0Ck7jrKauwBb3VAjf9sPCgYBVayZ1ln0y8yU0IbPJXHFtxhwFQtFhcMRn+IYL1zDtqARHc1bsbwPLMX9ltefbvYoSzy49yOLhQAIZ+u7BqivkTB43G5y4q9Ugg0ToWyPOvIfTxx+pt0oz0vl6RqO0JNDaLDYoXbaxETh3LRo/WknbuLVhAAAF9klEQVR4nO2a6V8TRxjHNwiEZTiSLElQYGMgaAohiBVdhAWRAIKAQgMolGJFaWxLpQrUWgUVotJiT631KPa0lV629vaf6zybA9lsIMke86L7e5N8mN3Ml+eZ55lnDorSpUuXLl26dOnSFSND2qb0DJIAaZnGLDqbIMAmI0I5NEGA9FyEUF4+OYAMOgcTmMwWYgQWpgATWG12YgRU4WawwRZyAFQRHoiouIQlBmBxgA2sW53ECOylZQi5jDYSfZdv227AH7TRhZD7uQoFVVmeEICnyluNCdgdNdgLrp0KqsqTEAAOwud34U9n7W6krAqYRAHQHgd4wex1wXtcnRJKDmBvPQA08BCNqLFpn3w1700KYH+L8NXC+yAaaQXyQcv+VAAoql7IiRXkANhW8IKPaSMFgGcmsEE7LzcnpgxAsZkHcDroKCEGgDOTFXJiiTwbyAFo4zuxF4wHZdUHcgAoJ4Nzoqs9sdfVAMB/q8Fe8FXIyAcyAZxdVsgHdOp1okwAyu45ADmxmxgARfWYwAYbV+uHDvf2vRAbMfIBWBq84Devu2Yy9PfC7OHqGBA7Sz4AZWkFG1jNDeu8O3iEC039R4cMigPgat0PNhiO/2rGi1yk+Bh5SQUAygwzk9s2Gu/VYy9Hqx+TaLwqA5DNuyEnxl0vHC+LAnBb1QCgGsYgJ56INzOdHF8tAF9RBYCiaqFaL+al5wWmMdr/+EmVAEbpDqgPugJSjYO90UF46lU1ACC02JJi7AWrWao9m3kt3L/vddE4UQJg4o3OWkDg28ELp6VsMDEJsxaqe/NMmqhFAYCzhVOcdxp/sc9ANOZJ7iM53zqX+/b5dy5cFDfIB3Bun8XdZhViGwR4CLecbslovDh3abolNlPIBzheEB5c4IXhgg1youIAdsYfHl6XYdUWYGAfyV0SNycqDcBeuBKN8PkFCmYmyIntHsloVB7AUNoYDXDENQ0GMRLkxLrOhHcwZAFcHbv27Cqb8wrd0la84i0uSrBOlANQvu+6aKG/J38C50TzItQHM4kRyAAIHjRxIgD0LpRmAQfsI1mL1AUIvjci7h20ZINovCHMTLbVkWh4v8l/9IOgggCGDz+K+fdD42AOt7J9kBM7PdFotPdhoo8PKQiQ/4lPqn+smwuwk3UDe6GuPVIf3PpU2FY61x9rg9QARm9/Fqd7rPk7kPAdizgW3MPCSLwL38E897bFEKQEMFp9P37/CN27AznRLFTr3dnYW5/XRZqWY2yQEsDkA9d6AKGcOEqD2XPowBdfmlabvvpagbJ814b7hDfnoJsxyMp5p5vXjNbcb+QCBCq/3ah/hIScyLbCzPRQ1DR7d40NkgY4+12BZPytFbcEOTF0wiHWke8nZABc5ecT6B/rUTV+JTBcFtviX/khdYAfHyXUO0K7J0MbeEVGifE6O7AaC0kCPByP/TkpNc6EzWxxXJZo/mkhOg6SBEhQ1w/fwi/8/Avuxs5LeAGtPI7YQBWAzb/i/z94e2neET3hEGu20qAegKsZ+3+i/zeEHggnHMLMJNZyOBrVADAN4aePPdmJv4ZOOGxuiaeehAjUALh2hqJ+Dz+cNS1U636Jx+7/oRYAWhr+czHy/UQtFT3hEGn2sUGtKHhGOCca4IRDygsrC0H1AfBw+wu8IJz6inV+QAsAbsoGQd8q6YWBv9UHwPWB4AVG0gZDixoAcE3/4PfZHqkycsSqAQC2gVCtCyccEtIAgPPC6t3eVUMKAKFTsIMhnHAQAkCN/4IXmE4JL2gDgKYgHzh5KzEAbjkdE7QJJxxEACI5MTMmH2gGwE3BOGAZcU7UDACPxMIg7COJbKAhAGqCVRtbvzYnagmAcyL8Fr+mTkwQwFOlyI0V6yX8W5Yir9C1K5lLLOWVitzZ6REWrg0eyImulWSu8SisWtg/L95C7maccwdEo8lG7nYgS8OaSfqEQyOVCjdhCN7RtDvin3BoIwsP20c5DMHbwoWQ3XLTyQFQcMJhfEoQIJvJNVbEPY3UQhnpT1sMGz+mS5cuXbp06dL1/9N/AlXbZFuLXd0AAAAASUVORK5CYII="')
                    jQuery('.cs-stories-wrapper', storiesContainer).append(template)
                }

                jQuery('.cs-stories-story-entry:first', storiesContainer).addClass('cs-stories-selected')
            }

            updateKeyLabels()
        }

        const onSpace = () => {
            if ((!window.CS_STORIES.documentHooked) || (!isVisible) || ((!isViewing) && (!isRecorded)) || window.CS_STORIES.isAnimating)
                return

            videoPlayer.click()
        }

        const onEnter = () => {
            if ((!window.CS_STORIES.isHome()) || window.CS_STORIES.isAnimating)
                return

            if (jQuery('.cs-stories-story-entry.cs-stories-selected', storiesContainer).is(':visible'))
                jQuery('.cs-stories-story-entry.cs-stories-selected', storiesContainer).click()
        }

        const onArrowUp = () => {
            if (!window.CS_STORIES.isHome(true))
                return

            const selected = jQuery('.cs-stories-story-entry.cs-stories-selected', storiesContainer)
            const previous = selected.prev()

            if (previous.is('.cs-stories-story-entry')) {
                selected.removeClass('cs-stories-selected')
                previous.addClass('cs-stories-selected')

                if (previous.next().get(0))
                    previous.next().get(0).scrollIntoView(false, {
                        behavior: 'smooth',
                        block: 'start'
                    })
            }
        }

        const onArrowDown = () => {
            if (!window.CS_STORIES.isHome(true))
                return

            const selected = jQuery('.cs-stories-story-entry.cs-stories-selected', storiesContainer)
            const next = selected.next()

            if (next.is('.cs-stories-story-entry')) {
                selected.removeClass('cs-stories-selected')
                next.addClass('cs-stories-selected')

                if (next.next().get(0))
                    next.next().get(0).scrollIntoView(false, {
                        behavior: 'smooth',
                        block: 'start'
                    })
            }
        }

        const onDelete = () => {
            if (!window.CS_STORIES.isViewing())
                return

            if (jQuery('[data-action="cs-stories-delete-video"]', storiesContainer).is(':visible'))
                jQuery('[data-action="cs-stories-delete-video"]', storiesContainer).click()
            else if (jQuery('[data-action="cs-stories-delete-video-confirm"]', storiesContainer).is(':visible'))
                jQuery('[data-action="cs-stories-delete-video-confirm"]', storiesContainer).click()
        }

        const getVideoDuration = () => new Promise((resolve, reject) => fetch(videoPlayer.src, {
            method: 'HEAD'
        }).then(response => resolve(response.headers.get('X-Video-Duration'))).catch(e => reject(e)))

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-swap-filter"]', event => swapFilter())
        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-swap-camera"]', event => swapCamera())

        jQuery('body').on('click', '.cs-stories-button', event => {
            event.preventDefault()
            event.stopPropagation()
            showStories()
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-open-record"]', event => {
            if (window.CS_STORIES.isAnimating)
                return

            videoClosed = false

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)
    
            jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                top: '250px'
            }, 500)

            jQuery('.cs-stories-close-record-wrapper', storiesContainer).animate({
                top: topToBottom
            }, 500)

            jQuery('.cs-stories-record-wrapper', storiesContainer).animate({
                top: bottomToTop
            }, 500)

            jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeIn(500, () => {
                if (videoClosed) {
                    jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(500, () => {
                        window.CS_STORIES.isAnimating = false
                        jQuery('[data-action="cs-stories-close-record"]', storiesContainer).click()
                    })

                    return
                }

                resetVideoFilter()

                jQuery(selfVideoCanvas).show()

                videoPlayer.pause()
                videoPlayer.src = ''
                videoPlayer.volume = videoPlayerVolume
                videoPlayer.currentTime = 0

                jQuery('.cs-stories-upload-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-play-indicator', storiesContainer).hide()
                jQuery('.cs-stories-close-record-wrapper', storiesContainer).show()
                jQuery('.cs-stories-record-wrapper', storiesContainer).show()

                jQuery(videoPlayer).hide()
                jQuery(videoTime).hide()

                jQuery('.cs-stories-progress-ring', storiesContainer).hide()
                jQuery('[data-action="cs-stories-record-video"]', storiesContainer).show()
                jQuery('[data-action="cs-stories-swap-filter"]', storiesContainer).show()
                jQuery('[data-action="cs-stories-swap-camera"]', storiesContainer).show()

                animateVideo(selfVideoCanvasContext)

                fetch(`https://${GetParentResourceName()}/cs-stories:videoOn`, {
                    method: 'POST',
                    body: JSON.stringify({})
                }).catch(error => {})
    
                animatingTimeout = setTimeout(() => {
                    window.CS_STORIES.isAnimating = false
                }, 1000)
    
                jQuery('.cs-stories-wrapper', storiesContainer).fadeOut(500)
    
                setTimeout(() => {
                    jQuery('.cs-stories-video-wrapper', storiesContainer).fadeIn(500)
                    jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(500)
                    storiesContainer.addClass('cs-stories-cs-video-call-video-active')
                }, 500)
            })
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-close-home"]', event => {
            if (!window.CS_STORIES.isHome())
                return

            if (window.CS_STORIES.onHideStories)
                window.CS_STORIES.onHideStories()

            cancelAndReset()
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-close-record"]', event => {
            if (window.CS_STORIES.isAnimating)
                return

            if (window.CS_STORIES.isRecording()) {
                stopRecording(true)
                return
            }

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            stopVideoRendering()
            stopRecording(true)
    
            jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                top: bottomToTop
            }, 500)

            jQuery('.cs-stories-close-record-wrapper', storiesContainer).animate({
                top: '-250px'
            }, 500)

            jQuery('.cs-stories-record-wrapper', storiesContainer).animate({
                top: '250px'
            }, 500)

            jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeIn(500, () => {
                closeVideo()
                jQuery(selfVideoCanvas).hide()
    
                animatingTimeout = setTimeout(() => {
                    window.CS_STORIES.isAnimating = false
                }, 1000)

                setTimeout(() => {
                    jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(500)
                    jQuery('.cs-stories-wrapper', storiesContainer).fadeIn(500)
                }, 500)

            })
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-close-video"]', event => {
            if (window.CS_STORIES.isAnimating)
                return

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            isViewing = false
    
            jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                top: bottomToTop
            }, 500)

            jQuery('.cs-stories-close-video-wrapper', storiesContainer).animate({
                top: '250px'
            }, 500)

            videoPlayer.pause()
            videoPlayer.src = ''
            videoPlayer.volume = videoPlayerVolume
            videoPlayer.currentTime = 0

            jQuery(videoPlayer).hide()
            jQuery(videoTime).hide()

            jQuery('.cs-stories-info-wrapper', storiesContainer).hide()
            jQuery('.cs-stories-play-indicator', storiesContainer).hide()

            animatingTimeout = setTimeout(() => {
                jQuery('.cs-stories-close-video-wrapper', storiesContainer).hide()
                window.CS_STORIES.isAnimating = false
            }, 500)

            jQuery('.cs-stories-wrapper', storiesContainer).show()
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-discard-video"]', event => {
            if (window.CS_STORIES.isAnimating)
                return

            videoPlayer.pause()

            jQuery('.cs-stories-play-indicator', storiesContainer).fadeOut(500)
            jQuery('.cs-stories-upload-wrapper', storiesContainer).fadeOut(500)
            jQuery('[data-action="cs-stories-open-record"]', storiesContainer).click()

            isRecorded = false
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-record-video"]', event => {
            if (window.CS_STORIES.isAnimating)
                return

            const circle = jQuery('.cs-stories-progress-ring > svg > circle', storiesContainer).get(0)
            const radius = circle.r.baseVal.value
            const circumference = radius * 2 * Math.PI

            circle.style.strokeDasharray = `${circumference} ${circumference}`
            circle.style.strokeDashoffset = `${circumference}`

            clearVideoThumbnail()
            isRecording = true

            const stream = new MediaStream()

            selfVideoCanvasStream.getVideoTracks().forEach(track => stream.addTrack(track))

            if (audioDevices !== null)
                audioDevices.getAudioTracks().forEach(track => {
                    activeAudioTrack = track
                    activeAudioTrack.enabled = playerTalking
                    stream.addTrack(activeAudioTrack)
                })

            recorder = new MediaStreamRecorder(stream, {
                mimeType: 'video/webm; codecs=vp8',
                audioBitsPerSecond: 128000,
                videoBitsPerSecond: 256 * 8 * 1024,
                checkForInactiveTracks: true,
                disableLogs: true
            })

            jQuery('[data-action="cs-stories-record-video"]', storiesContainer).hide()
            jQuery('.cs-stories-progress-ring', storiesContainer).css('display', 'inline-block')

            recorder.record()

            let timeRecordedMs = 0

            recordingInterval = setInterval(() => {
                timeRecordedMs += 100
                lastVideoDuration = timeRecordedMs / 1000
                circle.style.strokeDashoffset = circumference - (Math.round(100 * (timeRecordedMs / (maxDuration * 1000)))) / 100 * circumference
            }, 100)

            recordingTimeout = setTimeout(stopRecording, maxDuration * 1000)

            jQuery('.cs-stories-progress-ring', storiesContainer).off('click').on('click', () => {
                if (window.CS_STORIES.isAnimating)
                    return

                jQuery('.cs-stories-progress-ring', storiesContainer).off('click')
                stopRecording(false)
            })
        })

        jQuery('body').on('click', '.cs-stories-container .cs-stories-story-entry', function() {
            if (window.CS_STORIES.isAnimating)
                return
    
            isViewing = true

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            jQuery('.cs-stories-story-entry.cs-stories-selected', storiesContainer).removeClass('cs-stories-selected')
            jQuery(this).addClass('cs-stories-selected')

            jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                top: '250px'
            }, 500)

            videoPlayer.src = `${baseUrl}video/${accessKey}/${jQuery(this).attr('data-uuid')}.webm`
            videoPlayer.volume = videoPlayerVolume

            jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeIn(0, () => {
                jQuery('.cs-stories-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-video-wrapper', storiesContainer).show()

                jQuery(videoPlayer).show()

                getVideoDuration().then(duration => {
                    lastVideoDuration = duration

                    jQuery('span', jQuery(videoTime)).css('width', '0%')

                    videoPlayer.currentTime = 0
                    videoPlayer.play()

                    jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(100, () => {
                        jQuery(videoTime).fadeIn(500)

                        jQuery('.cs-stories-close-video-wrapper', storiesContainer).show().animate({
                            top: bottomToTop
                        }, 500)

                        animatingTimeout = setTimeout(() => {
                            window.CS_STORIES.isAnimating = false
                        }, 500)
            
                        const deletable = jQuery(this).attr('data-deletable') === 'true'
            
                        if (deletable)
                            jQuery('[data-action="cs-stories-delete-video"]', storiesContainer).show()
                        else
                            jQuery('[data-action="cs-stories-delete-video"]', storiesContainer).hide()
            
                        jQuery('.cs-stories-info-wrapper', storiesContainer).html(`
                            <div class="cs-stories-story-data" style="padding-top: ${notchOffset || 0}" data-tempId="${jQuery(this).attr('data-tempId')}" data-deletable="${deletable}">
                                <div class="cs-stories-story-inner">
                                    <div class="cs-stories-story-author">${jQuery(this).attr('data-author')}</div>
                                    <div class="cs-stories-story-time" data-timestamp="${jQuery(this).attr('data-timestamp')}">${moment.utc(parseInt(jQuery(this).attr('data-timestamp'))).fromNow()}</div>
                                    <div class="cs-stories-story-location">${jQuery(this).attr('data-location')}</div>
                                    <div class="cs-stories-story-identifier">#${jQuery(this).attr('data-tempId')}</div>
                                </div>
                            </div>
                        `).fadeIn(500)
                    })
                }).catch(e => {
                    cancelAndReset()
                    showStories()
                })
            })
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-delete-video"]', function() {
            if (window.CS_STORIES.isAnimating)
                return
    
            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            jQuery('.cs-stories-video-delete-wrapper', storiesContainer).show().animate({
                top: bottomToTop
            }, 500)

            jQuery('.cs-stories-close-video-wrapper', storiesContainer).animate({
                top: '250px'
            }, 500)

            animatingTimeout = setTimeout(() => {
                jQuery('.cs-stories-close-video-wrapper', storiesContainer).hide()
                window.CS_STORIES.isAnimating = false
            }, 500)
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-delete-video-confirm"]', function() {
            if (window.CS_STORIES.isAnimating)
                return

            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            isViewing = false
            videoPlayer.pause()

            jQuery('.cs-stories-play-indicator', storiesContainer).fadeOut(500)
            jQuery('.cs-stories-video-delete-wrapper', storiesContainer).fadeOut(500)

            jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeIn(500, () => {
                fetch(`https://${GetParentResourceName()}/cs-stories:delete`, {
                    method: 'POST',
                    body: JSON.stringify({
                        tempId: parseInt(jQuery('.cs-stories-info-wrapper > .cs-stories-story-data', storiesContainer).attr('data-tempId'))
                    })
                }).catch(error => {})

                jQuery('.cs-stories-video-delete-wrapper', storiesContainer).css('top', '250px')
        
                jQuery('.cs-stories-home-wrapper', storiesContainer).animate({
                    top: bottomToTop
                }, 500)

                jQuery('.cs-stories-loading-wrapper', storiesContainer).fadeOut(500)
                jQuery('.cs-stories-info-wrapper', storiesContainer).hide()
                jQuery('.cs-stories-wrapper', storiesContainer).show()

                jQuery(videoPlayer).hide()
                jQuery(videoTime).hide()

                videoPlayer.src = ''
                videoPlayer.volume = videoPlayerVolume
                videoPlayer.currentTime = 0

                animatingTimeout = setTimeout(() => {
                    window.CS_STORIES.isAnimating = false
                }, 500)
            })
        })

        jQuery('body').on('click', '.cs-stories-container [data-action="cs-stories-delete-video-cancel"]', function() {
            if (window.CS_STORIES.isAnimating)
                return
    
            window.CS_STORIES.isAnimating = true
            clearTimeout(animatingTimeout)

            jQuery('.cs-stories-video-delete-wrapper', storiesContainer).show().animate({
                top: '250px'
            }, 500)

            jQuery('.cs-stories-close-video-wrapper', storiesContainer).show().animate({
                top: bottomToTop
            }, 500)

            animatingTimeout = setTimeout(() => {
                jQuery('.cs-stories-video-delete-wrapper', storiesContainer).hide()
                window.CS_STORIES.isAnimating = false
            }, 500)
        })

        window.CS_STORIES.isHome = becoming => window.CS_STORIES.documentHooked && (becoming ? (isBecomingVisible || isVisible) : isVisible) && (!isRendering) && (!isRecording) && (!isRecorded) && (!isViewing)
        window.CS_STORIES.isPreparing = () => window.CS_STORIES.documentHooked && isVisible && isRendering && (!isRecording) && (!isRecorded)
        window.CS_STORIES.isRecording = () => window.CS_STORIES.documentHooked && isVisible && isRecording
        window.CS_STORIES.isRecorded = () => window.CS_STORIES.documentHooked && isVisible && isRecorded
        window.CS_STORIES.isViewing = () => window.CS_STORIES.documentHooked && isVisible && isViewing
        window.CS_STORIES.isVisible = () => window.CS_STORIES.documentHooked && isVisible

        window.CS_STORIES.hookDocument = () => {
            if (window.CS_STORIES.documentHooked || hookingDocument || unhookingDocument)
                return

            window.CS_STORIES.documentHooked = true
            hookingDocument = true

            const hook = window.CS_STORIES.hookInterface()

            storiesContainer = hook.container
            storiesButton = hook.button

            selfVideoCanvas = jQuery('#cs-stories-self-video').get(0)
            cloneCanvas = jQuery('#cs-stories-video-clone').get(0)
            thumbnailGeneratorCanvas = jQuery('#cs-stories-thumbnail-generator').get(0)
            virtualVideo = jQuery('#cs-stories-virtual-video').get(0)
            videoPlayer = jQuery('#cs-stories-video-player').get(0)
            videoTime = jQuery('#cs-stories-video-time').get(0)

            selfVideoCanvasContext = selfVideoCanvas.getContext('2d')
            selfVideoCanvasStream = selfVideoCanvas.captureStream()
            cloneCanvasContext = cloneCanvas.getContext('2d')
            cloneCanvasStream = cloneCanvas.captureStream()
            thumbnailGeneratorCanvasContext = thumbnailGeneratorCanvas.getContext('2d')

            storiesContainer.addClass('cs-stories-container')
            storiesButton.addClass('cs-stories-button')

            virtualVideo.width = videoWidth
            virtualVideo.height = videoHeight
            virtualVideo.srcObject = cloneCanvasStream

            cloneCanvas.width = videoWidth
            cloneCanvas.height = videoHeight

            selfVideoCanvas.width = videoWidth
            selfVideoCanvas.height = videoHeight

            thumbnailGeneratorCanvas.width = thumbnailWidth
            thumbnailGeneratorCanvas.height = thumbnailHeight

            jQuery(videoPlayer).on('click', event => {
                if (jQuery(videoPlayer).is(':visible') && (!window.CS_STORIES.isAnimating))
                    if (videoPlayer.paused) {
                        videoPlayer.play()
                        jQuery('.cs-stories-play-indicator', storiesContainer).fadeOut(500)
                    } else {
                        videoPlayer.pause()
                        jQuery('.cs-stories-play-indicator', storiesContainer).fadeIn(500)
                    }
            })

            jQuery(videoPlayer).on('play', event => {
                jQuery('.cs-stories-play-indicator', storiesContainer).fadeOut(500)
                clearInterval(videoPlayingInterval)
                videoPlayingInterval = setInterval(() => jQuery('span', jQuery(videoTime)).css('width', `${(videoPlayer.currentTime / lastVideoDuration) * 100}%`), 100)
            })

            jQuery(videoPlayer).on('pause', event => {
                clearInterval(videoPlayingInterval)
                jQuery('span', jQuery(videoTime)).css('width', `${(videoPlayer.currentTime / lastVideoDuration) * 100}%`)
            })

            jQuery(videoPlayer).on('loadedmetadata', event => {
                if (jQuery(videoPlayer).is(':visible') && videoPlayer.paused)
                    jQuery('.cs-stories-play-indicator', storiesContainer).fadeIn(500)
            })

            jQuery(videoPlayer).on('ended', event => {
                if (jQuery(videoPlayer).is(':visible'))
                    jQuery('.cs-stories-play-indicator', storiesContainer).fadeIn(500)

                clearInterval(videoPlayingInterval)
                jQuery('span', jQuery(videoTime)).css('width', `${(videoPlayer.currentTime / lastVideoDuration) * 100}%`)
            })

            renderKeyLabels()
            updateKeyLabels()

            if (baseUrl)
                renderStoryOrStories()

            bottomToTop = hook.bottomToTop
            topToBottom = hook.topToBottom

            jQuery('.cs-stories-upload-wrapper', storiesContainer).css('top', bottomToTop)

            notchOffset = hook.notchOffset

            if (notchOffset) {
                jQuery('.cs-stories-wrapper', storiesContainer).css('padding-top', notchOffset)
                jQuery('.cs-stories-close-record-wrapper', storiesContainer).css('padding-top', notchOffset)
                jQuery(videoTime).css('margin-top', notchOffset)
            }

            storyTimeInterval = setInterval(() => {
                jQuery('.cs-stories-story-time[data-timestamp]', storiesContainer).each(function() {
                    jQuery(this).html(`${moment.utc(parseInt(jQuery(this).attr('data-timestamp'))).fromNow()}`)
                })
            }, 5000)

            hookingDocument = false
        }

        window.CS_STORIES.unhookDocument = () => {
            if ((!window.CS_STORIES.documentHooked) || unhookingDocument || hookingDocument)
                return

            unhookingDocument = true

            clearInterval(storyTimeInterval)

            cancelAndReset()

            storiesContainer.remove()
            storiesButton.remove()

            window.CS_STORIES.documentHooked = false
            unhookingDocument = false
        }

        window.CS_STORIES.onHome = () => {
            if ((!window.CS_STORIES.documentHooked) || (!isVisible))
                return

            cancelAndReset()
        }

        window.CS_STORIES.onBack = internal => {
            if ((!window.CS_STORIES.documentHooked) || (!isVisible) || (internal && window.CS_STORIES.isAnimating))
                return

            if (window.CS_STORIES.isPreparing() || window.CS_STORIES.isRecording())
                jQuery('[data-action="cs-stories-close-record"]', storiesContainer).click()
            else if (window.CS_STORIES.isRecorded())
                jQuery('[data-action="cs-stories-discard-video"]', storiesContainer).click()
            else if (window.CS_STORIES.isViewing())
                if (jQuery('[data-action="cs-stories-delete-video-cancel"]', storiesContainer).is(':visible'))
                    jQuery('[data-action="cs-stories-delete-video-cancel"]', storiesContainer).click()
                else
                    jQuery('[data-action="cs-stories-close-video"]', storiesContainer).click()
        }

        window.CS_STORIES.show = () => showStories()

        window.CS_STORIES.hide = () => {
            if (window.CS_STORIES.onHideStories)
                window.CS_STORIES.onHideStories()

            cancelAndReset()
        }

        window.CS_STORIES.setUsingMouse = state => {
            fetch(`https://${GetParentResourceName()}/cs-stories:usingMouse`, {
                method: 'POST',
                body: JSON.stringify({
                    state
                })
            }).catch(error => {})
        }

        window.addEventListener('message', event => {
            const data = event.data

            if (data.type && data.type.startsWith('cs-stories:'))
                switch (data.type) {
                    case 'cs-stories:initialize':
                        jQuery('head').append(`<style>${data.hookFiles.style}</style>`)
                        jQuery('body').append(`<script>${data.hookFiles.dom}</script>`)

                        baseUrl = data.baseUrl
                        resourceName = data.resourceName
                        accessKey = data.accessKey
                        homeLimit = data.homeLimit
                        maxDuration = data.maxDuration
                        entries = data.entries
                        lang = data.lang
                        experimentalMode = data.experimentalMode

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

                        moment.updateLocale('en', {
                            relativeTime: lang.time
                        })
            
                        moment.locale('en')

                        renderKeyLabels()
                        updateKeyLabels()
                        renderStoryOrStories()

                        break

                    case 'cs-stories:new':
                        entries.unshift(data.entry)
                        entries = entries.slice(-homeLimit)

                        renderStoryOrStories(data.entry)

                        break

                    case 'cs-stories:delete':
                        for (let index = 0; index < entries.length; index++)
                            if (entries[index].tempId === data.entry.tempId) {
                                entries.splice(index, 1)
                                jQuery(`.cs-stories-story-entry[data-tempId="${data.entry.tempId}"]`, storiesContainer).remove()
                                break
                            }

                        if (jQuery(`.cs-stories-story-data[data-tempId="${data.entry.tempId}"]`, storiesContainer).is(':visible'))
                            jQuery('[data-action="cs-stories-close-video"]', storiesContainer).click()

                        renderStoryOrStories()

                        break

                    case 'cs-stories:swap-recording':
                        swapRecording()
                        break

                    case 'cs-stories:swap-filter':
                        swapFilter()
                        break

                    case 'cs-stories:swap-camera':
                        swapCamera()
                        break

                    case 'cs-stories:update':
                        accessKey = data.accessKey
                        break

                    case 'cs-stories:key':
                        switch (data.code) {
                            case 'spacebar':
                                onSpace()
                                break

                            case 'arrowUp':
                                onArrowUp()
                                break

                            case 'arrowDown':
                                onArrowDown()
                                break

                            case 'enter':
                                onEnter()
                                break

                            case 'rightClick':
                            case 'backspace':
                                window.CS_STORIES.onBack(true)
                                break
                            
                            case 'delete':
                                onDelete()
                        }

                        break

                    case 'cs-stories:close':
                        cancelAndReset()
                        break

                    case 'cs-stories:experimental-mode':
                        experimentalMode = data.state
                        break

                    case 'cs-stories:back-camera':
                        backCamera = data.active
                        break

                    case 'cs-stories:labels':
                        keyLabels = data.state
                        updateKeyLabels()
                        break

                    case 'cs-stories:talking':
                        playerTalking = data.state
    
                        if (activeAudioTrack !== null)
                            activeAudioTrack.enabled = playerTalking

                        break

                    case 'cs-stories:ready':
                        if ((!isUploading) || (!baseUrl))
                            return

                        const formData = new FormData()

                        formData.append('files', dataURLtoBlob(pendingUploadThumbnail), 'thumbnail')
                        formData.append('files', dataURLtoBlob(pendingUploadVideo), 'video')

                        pendingUploadThumbnail = null
                        pendingUploadVideo = null

                        fetch(`${baseUrl}upload/${accessKey}/${pendingUploadVideoDuration || 0}`, {
                            method: 'POST',
                            body: formData
                        })
                        .then(response => response.json())
                        .then(response => {
                            fetch(`https://${GetParentResourceName()}/cs-stories:storyUpload`, {
                                method: 'POST',
                                body: JSON.stringify({
                                    uuid: response.uuid
                                })
                            }).catch(error => {})

                            isUploading = false
                        }).catch(e => {
                            fetch(`https://${GetParentResourceName()}/cs-stories:storyUploadFailed`, {
                                method: 'POST',
                                body: JSON.stringify({})
                            }).catch(error => {})

                            isUploading = false
                        })

                        break
                }
        })

        window.addEventListener('resize', event => resize())

        fetch(`https://${GetParentResourceName()}/cs-stories:jsReady`, {
            method: 'POST',
            body: JSON.stringify({})
        }).catch(error => {})
    })
}) ();
