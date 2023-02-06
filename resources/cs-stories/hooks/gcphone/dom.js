const _CSS_routeToBack = 'menu' // Usually the "menu" route is what is being used in most gcphone resources along with "home", you may specify which one you want to go to when hiding cs-stories.
const _CSS_notchOffset = '1%' // If your phone is using a skin with a notch you can specify the top distance it takes here.
const _CSS_bottomToTop = '45px' // The distance from bottom to top to animate the bottom elements to.
const _CSS_topToBottom = '15px' // The distance from top to bottom to animate the top elements to.

if ((!window.APP) || (!window.APP.$phoneAPI) || (!window.APP.$router) || (!window.APP.$bus))
    throw new Error('[criticalscripts.shop] cs-stories could not be hooked to your phone. Make sure you are using the correct hook.')

jQuery('body').on('click', '.phone-go-home', () => window.CS_STORIES.onHome()) // Calling this if the phone directs us to go back to the home view.
jQuery('body').on('click', '.phone-go-back', () => window.CS_STORIES.onBack()) // Calling this if the phone directs us to go back on the previous view.

window.CS_STORIES.hookInterface = () => {
    const _CSS_container = jQuery(`
        <div style="display: none">
            <div class="cs-stories-inner-container">
                <div class="cs-stories-info-wrapper"></div>

                <div class="cs-stories-close-record-wrapper">
                    <span data-action="cs-stories-close-record">
                        <button class="cs-stories-bg-grey"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21,3H3v18h18V3z M17,15.59L15.59,17L12,13.41L8.41,17L7,15.59L10.59,12L7,8.41L8.41,7L12,10.59L15.59,7L17,8.41L13.41,12 L17,15.59z"></path></svg></button>
                    </span>
                </div>

                <div class="cs-stories-play-indicator">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50"><path d="M 10 5.25 L 10 44.746094 L 43.570313 25 Z"></path></svg>
                </div>

                <div class="cs-stories-loading-wrapper">
                    <div class="cs-stories-loading-indicator">
                        <svg class="cs-stories-spinner">
                            <circle cx="20" cy="20" r="18"></circle>
                        </svg>
                    </div>
                </div>

                <div class="cs-stories-video-wrapper">
                    <canvas id="cs-stories-self-video"></canvas>
                    <canvas id="cs-stories-video-clone"></canvas>
                    <canvas id="cs-stories-thumbnail-generator"></canvas>
                    <video id="cs-stories-video-player" preload="none"></video>

                    <div id="cs-stories-video-time">
                        <span></span>
                    </div>

                    <video id="cs-stories-virtual-video"></video>
                </div>

                <div class="cs-stories-wrapper"></div>

                <div class="cs-stories-bar-wrapper">
                    <div class="cs-stories-home-wrapper">
                        <span data-action="cs-stories-open-record">
                            <button class="cs-stories-bg-orange"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M 12 2 A 2 2 0 0 0 10 4 A 2 2 0 0 0 12 6 A 2 2 0 0 0 14 4 A 2 2 0 0 0 12 2 z M 12 7 C 9.269 7 7 7.9087969 7 9.2167969 L 7 10 L 4 10 L 4 11 L 4 22 L 20 22 L 20 10 L 17 10 L 17 9.2167969 C 17 7.9087969 14.731 7 12 7 z M 6 12 L 18 12 L 18 20 L 15.962891 20 C 15.77054 18.812134 14.05927 18 12 18 C 9.9407301 18 8.2294596 18.812134 8.0371094 20 L 6 20 L 6 12 z M 12 13 A 2 2 0 0 0 10 15 A 2 2 0 0 0 12 17 A 2 2 0 0 0 14 15 A 2 2 0 0 0 12 13 z"></path></svg></button>
                        </span>

                        <span data-action="cs-stories-close-home">
                            <button class="cs-stories-bg-grey"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21,3H3v18h18V3z M17,15.59L15.59,17L12,13.41L8.41,17L7,15.59L10.59,12L7,8.41L8.41,7L12,10.59L15.59,7L17,8.41L13.41,12 L17,15.59z"></path></svg></button>
                        </span>
                    </div>

                    <div class="cs-stories-close-video-wrapper">
                        <span data-action="cs-stories-delete-video">
                            <button class="cs-stories-bg-orange"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M 10 2 L 9 3 L 4 3 L 4 5 L 5 5 L 5 20 C 5 20.522222 5.1913289 21.05461 5.5683594 21.431641 C 5.9453899 21.808671 6.4777778 22 7 22 L 17 22 C 17.522222 22 18.05461 21.808671 18.431641 21.431641 C 18.808671 21.05461 19 20.522222 19 20 L 19 5 L 20 5 L 20 3 L 15 3 L 14 2 L 10 2 z M 7 5 L 17 5 L 17 20 L 7 20 L 7 5 z M 9 7 L 9 18 L 11 18 L 11 7 L 9 7 z M 13 7 L 13 18 L 15 18 L 15 7 L 13 7 z"></path></svg></button>
                        </span>

                        <span data-action="cs-stories-close-video">
                            <button class="cs-stories-bg-grey"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21,3H3v18h18V3z M17,15.59L15.59,17L12,13.41L8.41,17L7,15.59L10.59,12L7,8.41L8.41,7L12,10.59L15.59,7L17,8.41L13.41,12 L17,15.59z"></path></svg></button>
                        </span>
                    </div>

                    <div class="cs-stories-video-delete-wrapper">
                        <span data-action="cs-stories-delete-video-confirm">
                            <button class="cs-stories-bg-green"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><path d="M 14 4 C 13.477778 4 12.94539 4.1913289 12.568359 4.5683594 C 12.191329 4.9453899 12 5.4777778 12 6 L 12 7 L 7 7 L 6 7 L 6 9 L 7 9 L 7 25 C 7 26.645455 8.3545455 28 10 28 L 17 28 L 17 27.855469 C 18.367249 30.320181 20.996209 32 24 32 C 28.4 32 32 28.4 32 24 C 32 19.939374 28.931363 16.567445 25 16.070312 L 25 9 L 26 9 L 26 7 L 25 7 L 20 7 L 20 6 C 20 5.4777778 19.808671 4.9453899 19.431641 4.5683594 C 19.05461 4.1913289 18.522222 4 18 4 L 14 4 z M 14 6 L 18 6 L 18 7 L 14 7 L 14 6 z M 9 9 L 23 9 L 23 16.070312 C 22.301956 16.158582 21.631165 16.334117 21 16.591797 L 21 12 L 19 12 L 19 17.771484 C 18.18962 18.424016 17.507605 19.229482 17 20.144531 L 17 12 L 15 12 L 15 23 L 16.070312 23 C 16.028764 23.32857 16 23.660626 16 24 C 16 24.691044 16.098874 25.35927 16.265625 26 L 10 26 C 9.4454545 26 9 25.554545 9 25 L 9 9 z M 11 12 L 11 23 L 13 23 L 13 12 L 11 12 z M 24 18 C 27.3 18 30 20.7 30 24 C 30 27.3 27.3 30 24 30 C 20.7 30 18 27.3 18 24 C 18 20.7 20.7 18 24 18 z M 21.699219 20.300781 L 20.300781 21.699219 L 22.599609 24 L 20.300781 26.300781 L 21.699219 27.699219 L 24 25.400391 L 26.300781 27.699219 L 27.699219 26.300781 L 25.400391 24 L 27.699219 21.699219 L 26.300781 20.300781 L 24 22.599609 L 21.699219 20.300781 z"></path></svg></button>
                        </span>

                        <span data-action="cs-stories-delete-video-cancel">
                            <button class="cs-stories-bg-red"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21,3H3v18h18V3z M17,15.59L15.59,17L12,13.41L8.41,17L7,15.59L10.59,12L7,8.41L8.41,7L12,10.59L15.59,7L17,8.41L13.41,12 L17,15.59z"></path></svg></button>
                        </span>
                    </div>

                    <div class="cs-stories-record-wrapper">
                        <span data-action="cs-stories-swap-filter">
                            <button class="cs-stories-bg-teal"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50"><path d="M 4 2 C 3.398438 2 3 2.398438 3 3 L 3 6 C 3 6.300781 3.113281 6.488281 3.3125 6.6875 L 19.3125 23.6875 C 19.511719 23.886719 19.800781 24 20 24 L 30 24 C 30.300781 24 30.488281 23.886719 30.6875 23.6875 L 46.6875 6.6875 C 46.886719 6.488281 47 6.300781 47 6 L 47 3 C 47 2.398438 46.601563 2 46 2 Z M 19 26 L 19 41 C 19 41.398438 19.199219 41.707031 19.5 41.90625 L 29.5 47.90625 C 29.601563 48.007813 29.800781 48 30 48 C 30.199219 48 30.300781 48.007813 30.5 47.90625 C 30.800781 47.707031 31 47.398438 31 47 L 31 26 Z"></path></svg></button>
                        </span>

                        <span data-action="cs-stories-record-video">
                            <button class="cs-stories-bg-red"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path d="M 2 6 C 0.895 6 0 6.895 0 8 L 0 22 C 0 23.105 0.895 24 2 24 L 19 24 C 20.105 24 21 23.105 21 22 L 21 8 C 21 6.895 20.105 6 19 6 L 2 6 z M 29 8 A 1 1 0 0 0 28.302734 8.2832031 L 23 13 L 23 15 L 23 17 L 28.324219 21.736328 L 28.339844 21.75 A 1 1 0 0 0 29 22 A 1 1 0 0 0 30 21 L 30 15 L 30 9 A 1 1 0 0 0 29 8 z"></path></svg></button>
                        </span>

                        <span class="cs-stories-progress-ring">
                            <svg width="120" height="120">
                                <circle class="cs-stories-progress-ring-circle" stroke="white" stroke-width="4" fill="transparent" r="52" cx="60" cy="60" />
                            </svg>
                        </span>

                        <span data-action="cs-stories-swap-camera">
                            <button class="cs-stories-bg-purple"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M16 15L24 15 20 20zM8 9L0 9 4 4z"></path><path d="M21 6c0-1.654-1.346-3-3-3H7.161l1.6 2H18c.551 0 1 .448 1 1v10h2V6zM3 18c0 1.654 1.346 3 3 3h10.839l-1.6-2H6c-.551 0-1-.448-1-1V8H3V18z"></path></svg></button>
                        </span>
                    </div>

                    <div class="cs-stories-upload-wrapper">
                        <span data-action="cs-stories-upload-video">
                            <button class="cs-stories-bg-green"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path d="M 6 4 C 4.895 4 4 4.895 4 6 L 4 20 C 4 21.105 4.895 22 6 22 L 20 22 C 21.105 22 22 21.105 22 20 L 22 6 C 22 4.895 21.104 4 20 4 L 6 4 z M 19 8 C 19.25575 8 19.511531 8.0974688 19.707031 8.2929688 C 20.098031 8.6839688 20.098031 9.3160312 19.707031 9.7070312 L 12.146484 17.267578 C 11.958484 17.455578 11.704453 17.560547 11.439453 17.560547 C 11.174453 17.560547 10.919422 17.455578 10.732422 17.267578 L 7.2792969 13.814453 C 6.8882969 13.423453 6.8882969 12.791391 7.2792969 12.400391 C 7.6702969 12.009391 8.3023594 12.009391 8.6933594 12.400391 L 11.439453 15.146484 L 18.292969 8.2929688 C 18.488469 8.0974688 18.74425 8 19 8 z M 24 8 L 24 20 C 24 22.209 22.209 24 20 24 L 8 24 C 8 25.105 8.895 26 10 26 L 24 26 C 25.105 26 26 25.105 26 24 L 26 10 C 26 8.895 25.104 8 24 8 z"></path></svg></button>
                        </span>

                        <span data-action="cs-stories-discard-video">
                            <button class="cs-stories-bg-red"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21,3H3v18h18V3z M17,15.59L15.59,17L12,13.41L8.41,17L7,15.59L10.59,12L7,8.41L8.41,7L12,10.59L15.59,7L17,8.41L13.41,12 L17,15.59z"></path></svg></button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    `)

    if (jQuery('.mainScreen').length > 0)
        jQuery('.mainScreen').prepend(_CSS_container)
    else
        jQuery('.phone_screen').prepend(_CSS_container)

    const _CSS_button = jQuery(`<div style="display:none"></div>`)

    jQuery('body').append(_CSS_button)

    return {
        container: _CSS_container,
        button: _CSS_button,
        notchOffset: _CSS_notchOffset,
        bottomToTop: _CSS_bottomToTop,
        topToBottom: _CSS_topToBottom
    }
}

window.CS_STORIES.onShowStories = () => {} // What to do when cs-stories is shown.

window.CS_STORIES.onHideStories = () => window.APP.$router.push({ // What to do when cs-stories is hidden.
    name: _CSS_routeToBack
})

window.CS_STORIES.getStoryTemplate = (story, lang) => { // Each individual story's template.
    return `
        <div class="cs-stories-story-entry" data-uuid="${story.uuid}" data-tempId="${story.tempId}" data-location="${story.location}" data-timestamp="${story.timestamp}" data-author="${story.author}" data-deletable="${story.deletable}">
            <img src="${story.thumbnail}" alt="${story.uuid}.jpg" class="cs-stories-story-thumbnail" />

            <div class="cs-stories-story-data">
                <div class="cs-stories-story-inner">
                    <div class="cs-stories-story-author">${story.author}</div>
                    <div class="cs-stories-story-time" data-timestamp="${story.timestamp}">${moment(story.timestamp).fromNow()}</div>
                    <div class="cs-stories-story-location">${story.location}</div>
                </div>
            </div>

            <span class="cs-stories-key-label cs-stories-go-up">${(!lang.controls) || lang.controls.arrowUp === null ? '' : `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M 12 2.9296875 L 4.9296875 10 L 6.4296875 11.5 L 11 6.9296875 L 11 21 L 13 21 L 13 6.9296875 L 17.570312 11.5 L 19.070312 10 L 12 2.9296875 z"></path></svg>${lang.controls.arrowUp ? `&nbsp;${lang.controls.arrowUp}` : ''}`}</span>
            <span class="cs-stories-key-label cs-stories-view">${(!lang.controls) || lang.controls.enter === null ? '' : `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path d="M 15 5 C 6.081703 5 0.32098813 14.21118 0.21679688 14.378906 A 1 1 0 0 0 0 15 A 1 1 0 0 0 0.16210938 15.544922 A 1 1 0 0 0 0.16601562 15.550781 C 0.18320928 15.586261 5.0188313 25 15 25 C 24.938822 25 29.767326 15.678741 29.826172 15.564453 A 1 1 0 0 0 29.837891 15.544922 A 1 1 0 0 0 30 15 A 1 1 0 0 0 29.785156 14.380859 A 1 1 0 0 0 29.783203 14.378906 C 29.679012 14.21118 23.918297 5 15 5 z M 15 8 C 18.866 8 22 11.134 22 15 C 22 18.866 18.866 22 15 22 C 11.134 22 8 18.866 8 15 C 8 11.134 11.134 8 15 8 z M 15 12 A 3 3 0 0 0 12 15 A 3 3 0 0 0 15 18 A 3 3 0 0 0 18 15 A 3 3 0 0 0 15 12 z"></path></svg>${lang.controls.enter ? `&nbsp;${lang.controls.enter}` : ''}`}</span>
            <span class="cs-stories-key-label cs-stories-go-down">${(!lang.controls) || lang.controls.arrowDown === null ? '' : `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M 11 3 L 11 17.070312 L 6.4296875 12.5 L 4.9296875 14 L 12 21.070312 L 19.070312 14 L 17.570312 12.5 L 13 17.070312 L 13 3 L 11 3 z"></path></svg>${lang.controls.arrowDown ? `&nbsp;${lang.controls.arrowDown}` : ''}`}</span>
        </div>
    `
}

if (window.APP.$phoneAPI.config.AppStore) {
    window.APP.$phoneAPI.config.AppStore.push({ // If you want to edit the app's position, name, icon or color you may do so here.
        MenuPage: true,
        allowjob: [],
        blockedjobs: [],
        name: 'Stories',
        en_US__name: 'Stories',
        intlName: 'Stories',
        detail: 'Share your special moments with the world!',
        menuTitle: 'visible',
        icons: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMAAAADACAYAAABS3GwHAAAUoUlEQVR4nO2daZCV1ZnHf9000M3aDS00DbLTNLJvKosxYxJF1ERlxnGWJJaz+nGqMuPky6Qqs2QmNZ8zS5maLFWZVJyIZkGjRmNEiQYw7CDI1ux7szb71L/PudA0vdx7+7z3vu97n1/VrW6geftdnv97znnOs5RdL/syMWIwMA2YDjQA44GRwB1ANdAPqADK4nTSxg2uA1eA88Ap4CiwH9gJfAxsADYBzf5ni06xBTAAWAA8DHwamAJUxuHGGJFxEdgMvAP8AlgJnC3W7S6GAHoDS4GngSX+zW6ULs1eCP8LrAAuFfJOFFIAo4HngGeAukL9UiNRHAa+C3wL2FOIEy+EABqBrwJP2fTGyBJNk34EfAPYEuVNK4/w2PXAC8A64Etm/EYO9AW+6G3n294REglRCKAP8DywFfgz/2fDyAetF5/1o8DfR2FLoQUwF1gF/CswMPCxjdJloJ8O/QaYF/IuhBKAjvN33qU1J9AxDaM9s4F3/QwjiO2GOMgQ4GXg32yebxSASj/D+AkwtKe/rqcCaPRTnsfsyRsF5hHgfb95mjc9EcAiPxw12JM3ioRs79feFvMiXwE8CLwG1NqTN4pMrd9Jfiif08hHADL+5T6OxzDiQH/gpXxEkKsANNT82EdlGkackE3+X67ToVwE0Oi9PfbmN+LKAG+jjdmeX7YCGOoPbHN+I+7IRl/x7vluyUYA+pnvAJPt0RsJocFHlXZr39kI4CvAo/bkjYTxqLfdLukuHHquD2+wHV4jibQAi4E1nZ17VyOAIu/+24zfSDCV3oY7jSLtSgB/Y4FtRgqY4225QzqbAtX7eH4LaTbSwBnvGj3Q/lo6GwH+0YzfSBGy5a93dDkdCUDRdX9qT99IGV/saIOsIwF81dIYjRTSx9v2LbQXwBjgD+zpGynlKV+e5wbtBfCcuT2NFFPpbfwGbQWgISJWhUINIwKe8dUmWmkrgKVWsc0oAeq8rbfSVgBP29M3SoQbtp4RwABfqNYwSoGHM3ktGQEs8rX5DaMUkK0vbCsAe/sbpUarzWe6rdxvjz8iystgUBVMHA7zx8HccTC5DuoGQ/++7neeuwiHmmHbIVi9E1bvhh2H4fQFuBaLRipp5D68AAb3tLiQ0QUDKmHcHTB9FDTWw8RhMLYW7hgIfSrc/7t0BSp7w9VrcLYFWi677yWCMy12d6Nhqmxf0aCLfNKLERoZ/+emwpPzYOFEqOnv3vq9e3X8iy5fdaPBiXPw3nZYvhre2OT+zoiCBRW+IZ0RmhHV8OhMeGIe3DsBqrOoJCNh6Of0qekHtQOgdiD8fB0cPGWPKDzTK6y0YQTIgB+YAs9+CuaNg1551B/TaPHgNPdVI8CKddB8If7XniymlPtWpEYo+lbApxth2XyYNSY/48+g/ztrtDvW/Y3u2EZIxpVH2X6mJBk+GD47Fe5rCGOwWhzrWJ+ZCsMGlfrdDc3Ict+E2giBDH7aSJg9BoYGLKAnj9GcMTB15E3PkRHkzpZbn96AjB4KCybBnVkVJcsNHfveie6rEYrqcit0G5BRQ9ycfUgE5VOH9HfHHlVTvOtLH/3K/WaYEQK5LrXJ1S+CjFLtH2hDTV4hIxS9y30ohBGCfn3dmzoqtC+QCZ8wQlAWZaPs0qOiHPr2ju6ydewKe2QhsbsZEgWuXbka3fEVKqEYISMYJoCQKIjtdIS7tTq2focRDBNASGSgB065N3VoFDG674SFQwTGBBASBaxt2OeiOUOjY+rYFhQXFBNASPYchw8+gcPN4Y99+LQ7tn6HEQwTQEhOnYeP9sDmA3DhUrgD61ib98Pv9ka7xihBTACh0Rv67c3OWEN4bHSMtXvg7S3QdCJmF5t8bBc4NEppfHOz27FVZOj4HsYa7j4Gr6yFNze5YxtBMQFEwa6jsGK9iwl6ZCZMGp57FKe8PtsPw89+B6+ud0IwgmMCiIqtB+G/3oZDp1xOsDLDKrPcJZav/8Od8NJq+MlHsO9kAm9AMlBSvNXdiBKFL98zHu6Z4KpCaDQYWXN7wNz5S87Pr7f+lgNOAPL62Lw/UkwAhaCszIUxK1FGn0l1MHzQrXWB5ObcfgjW7HYL6P0n4bo9mqgxARQSvfUH93OGr+yxTL6wPD0XrzghNJ93o4FREGwNUEhk2GbcscL2AYySxgRglDQmAKOksTVAaFTesKKXW+D2KvNf/afMZ5+Wec9Quf+zEmnk8ZE74rr/Xn+nxXHrx3+vZJsoQq1LGBNAKFQIt77alT1XXvBgX9+zWt9XOc9PH+/5yaROtq0OffHyzYwvfT170QW+nToHJ88775BCohUOfbDZwiICYQLIB7kz62tcwSoVwFItUBm+Yn9UvU1/HlR50/gHVd2sCl3eTQ2CjADkLZIAmr0ITre4aFOFWh857YSgPx8/C0fPuD+bhylnTADZojAG+e5l4FPq3YZW4wi3qTViMAysdG/38nJn5JlPWY5FNzLTJf0+jSSZ6dCNj58WqW+Ass92+J1jhWFvOQhHT7tQCu0rGN1iG2HZoO4u88bCjNHQ4Lu7aCdXpcv1hi8mmVFAHWY0CiiUYn2T21GWOIwusRGgM/S2VyGqySNca6P5411lNk174kSmn8CEYe6kND1a1+Q60iieaNtB2HXMrTOM27ARoCP0Vp87FpbOhN+bAuOHQVXv5BSmlbFfuOxGACXSqLeApkiWUH8bNgK0R6UN1dbosdkwc3Q0hW6jRkLVRyLWiKW1ymsb4PWNNi1qhwkggwxGxv/YLBe/v2BiPM6rpygcW586v1BfvsYl7Nh+QismgAyaQ//xAnhyrlv0pg2tX+SK1ecHq1zCjmECaEXTBHVhkfHLxZlGtDuta1s2D5qOw7GzcOxMOq81BywWSFMfzfXVgkguzrSja3zgLpgxqvN2rSWECUBTAqUsasHYk4Z2SUHXqPxkdZuxUusmgNYdV+3mllLnFXWy0UiQbZJ+ijEB6I0ov38pNZ/TJp+uucKmQCaAMkqz86KiUa03kAmglVwD1ozUYAJQyECUXV3iiq75gjXbMAGUcu0dqzuU4o2wEdUuBGDYQBcCoHl+R4u+TGvTUkPX/Ox9LtusPRodlE+gnAMl2+w9ntrGHOmKBs14dOTWVPz+3RNgcp0TQ6YYVXs0/29bpKpUyBTj6mgU0N8r5VI5BgqZUFj16l0ukE75B9fSYzLpEoCytJZMh0UNMGaoM3y94W2Rmx8Sh/KQJQT1PVi5zUWVqnRjSkjHFEhvdxn/E3NdDP/kEghpKAR6cSjnWZ+pI12vA2XB6X4rvyAFOcjJF4CmLnPGwF8/AJ+5K34ZW2lCLxblKddVw3++Bat2JL5vcbIFoKRzvfkfn+uSWGrN+CNFI4KKAuheq+/B+YtuOpTgNUGyBaDaO3oYD88w4y8kGmWXzHAeIuUbn4ygLWyBSLbrQ80mtOAthTDmuKHp0OIGmDgs0ZeRbAEojFki6K7YlBEerb1071UtI8EkWwC6+bUDYnAiJYqmnSoZk2CSLQDV7NE6wCgOqkekihMJJtkCUHU2m/4UD917uUQTTLK9QLmk9F24BHtPONed0Tn9+sLoIVDVJ7ubNCDZaZXJFkBHsT2doa38r78M2w4V+CQThrw7//B49lObXJ5BDEn4RlgOMzhFNn6w0xWFMjpHwW5ncug9kMsziCHJPvtc4tnltlPNfqNrBlXmFhmb8JyC0okBLkv+26og6B6VkF/BLMIoaaw0YiFRVlqmzHpruyT//rnm2yKprLlCjK1wbcEwARQKxdTPuNN91HhDAWX9vKtRRt8aWHYU1u2FDftc1xcjckwAUaPwYXVrUTnCaaNcYomy1Wr63/qLFVEpV+2m/bChyaUgSghHrYBtlJgAokKx83rLPzITls2Heye4TSNNfTpK0ZQgFFpwV71L61SyyUur4efrXCVnq+AQCSaAqBhXC0/dDZ+f46Y9/bLYWZUwtD7QdEmtmfRVrVdf/BB22v5FFJgAokDdWB6aDn+y0E158kFhHupSo5Iu2px6eQ0cPp2u+xQDzA0aGsXQfHaqa7MUIjlfEa86lvKds43PMbLGBBCakTXOWO8eH6b6stYMSvx5YCrUJzvyMo6YAEKiacvMO523Z2DAsItBVc6TlO1awsgaE0BI5N5U55Uo3tQaWe6ZAGNKsIxjhJgAQlJf40aAIRGkaaoej45t06CgmABCIj++2g9FESOvdkYq9lttKaAhMQGERHE+7Xd4Q6KRxdYAQTEBhERx9FG2HtWxS62KdcTY3QzJ1WvRRnIqWvRKsmtxxg0TQEjUcijKMoEqVX4h+RWZ44QJICQKWWg6AS0R9N7SMZuOu99hBMMEEJIDJ108/4kIRgHlB6gS8/6TRbzA9GECCIni+X+zIxojPXAKPvjE9esygmECCMm5i7B+n0tkOX0h3IGbL8D6JnfcFHRliRMmgNDo7f/WJleDKIRHSMfQqPLLTW4UMIJi+QChkZfml5thYJXLC1AQW0/YcgCWr4G3tpgHKAJMAFGgxJU3NrqWrV/wGWG51DHFT6fWNcEra+CNTXDEkmGiwAQQFWod9D/vOjEsm3czu6uznGChXlua8py5AKs+gR//FlastwoREWICiAolsauiw4p1zn+/8uM2VSFqXXRnW+Q63X3MVYXYqKoQu92i95hVhYgSE0DUSASav2s6IwHMzNQFGtSuLtBp2HnE/dzGfdHsJRi3YQIoFJrGvL/dNZhWuLTSJTPNPTT1uXIVLl5xC12rDFcwTACFRIZ9OeD+gNFjbB/AKGlMAEZJYwIwShpbA0RFphR6X18OvU+vmxldKouuBbA+cpde9wthJdTcKJXuy6VfvOzyDPS9ERwTQGhk4CphMv4OuHOIq+2phtIqlKuexhKF3J8SRkW5M/62HiAZe/N5t/Mrz9HhZpdj8MkRFwt01TLCQmICCMGIamiog7G1MGIwjKhxX1UaXUnyComQ8ffv0321OInh3CWX+KKIUmWYSQwHm+HgSfdVfQS2H4aDFhzXU0wA+aI6ndrNldHPHuNCHfRVb/1c437aIoG0Cqbq9n9TfJDyAdbucbkBa3e7HARLlcwbE0A+qDbPoknw4HSYPdpFfWqaE3XNHglrSr0bcVQv9FCzE8PrG+C97S5vwMgJE0AuaDE7d6wzfn0WTnJz+0IjoekzcbirHq2CWY31TgQaFWwnOWtMANmihau6vHxpMXxuqlvclsegn6gE+PnZMN+3YPreSvhwp2WOZYkJIBtk/Gp1pIYXixtuj+QsNhKiPE+PzXIjww9WudZKti7oFhNAd2ixK6P/owWud1efGN8ytVTSOWpvQR4khWDbSNAlJoCuUOLKpOHw9L1wX0O8jT+Diuje3whnWtwegpL0rcFep1goRFcMHwQLJ8KnJru3a1LQFE2CVa+CYUVYpCeIZAugs9TCjlBNzeYcq6qp1PndE9ymVtKQa3b+eLc2yAXdo1zqj+byDGJIsqdAuQztmr7IKLLttKi4nVbPykgXtpA0dM4zRjkRqMVqtq5R3aNcpnoJn14lWwC5+LtH1cBXlmafY6uYHjWtnlQXD3dnruicFZ7xzGLXsC/bGCJt6I3KYdRI+J5DsgUgN1+2u6+awz8+J+ozihdqrqe+YvpEhcIzEozWAMkdw45ZuZCik+xncF0CSG6guaIiE/4GSjRnW9wzSC6XJYDkFpxXhQUrGlU8jp+Dj3Yn+QrOSwDJDSpXmZE9Vi68aOw55irYJZdTEkByx7DNB2D1ruxdm0Y4FIqte795f5Jv6lEJILlXoKprb26CX22xmJdConv9q62uCnayF8H75QbdGYMTyQ8liisGXokirUkiE6JpUm3cRLnLevO/tNrd+2Qn6++UtXwcgxPJH0U9/nqbC1lW/qwSVWot/iUSNOJq3aV+BbrnIbvgFIetEsCGpF9Fa9L4i791u7zKj1UgmDa+NDIkIYIzzugNL1ezvG3vbIPlq+HtrWnJNdhQdr3sy4r0OqRA2hicUM8YUOnKkagC86wxMGu0C2dWdQYTQm7I8PViUfUJuZvVoVIdMHemZu9Fw9cIWYVcKFuA2TE4qZ6hB6Ma+4qDUTDYAN+QQj12NRro75IdvBg9igtQMS7dS3l6dhxxbZo2NLl7mx5nw0bFvlb4S34nFQLIZELpbaXPC+/E4KSMmLKSNvkAr9lTMkqMVpvPCOA9DQdmAUaJoOiH92kjAO1mvGpP3ygRXvM2f0tK5A/t6Rslwg1bbyuAV7071DDSjGx8RUcCkH/ru/bojZTzHeUBZC6xfVWIbwEtZgFGSpFt/0fbS2svgL3Ai/b0jZTyI2/jN+ioLtC/+OmQYaQJ2fQ32l9PRwLYCnzfHr2RMr7vbfsWFAzX0WXW+x+2uGIjDagY1GTgYPtr6aw04gHgn+3RGynhnzoyfroYAUQfYBVQYtWkjJSxBljY2bq2q+K4+g9/aW5RI8HIdv+qK6dOd9WhpZ6vmQUYCeVr3oY7JZvy6P8O/NQswEgYP/W22yXZCEBlhZ8BtpkFGAlhm7fZbktiZ9sg4wTwuEqhmgUYMeeYt9UT2ZxmLh1itvoDWzFOI67INr/Q0YZXZ+TaIkmZY8sSXVDXSCuyyd/PZHplSz49wl4HnrCRwIgRssUngV/kekr5NsmTCB6yNYERA2SDS/IxfnrYJVJDzX3mHTKKyDZvg+/lewo9bZO61W8z2z6BUWh+BizKZcHbESH6BGdcpH/ry80ZRpQovOF57+3pcXeUUI2yr/ldt8XdbT0bRg9Y623sm9lscmVD6E7xa/2U6Hlfc9QwQnDG29SC0C/Y0ALAR95JoY3AC5ZeafQA2c63vS19MwpbikIAGZSA8BfADOB7FlZt5ECLT2GcCfy5T9CKhK4SYkIzGnjOBynVmTUYHXDY1+1R6ZI9hbhBhRRAht7AUuAPgYeB6kKfgBErmn2tzh/6im0FnTIXQwBtGegXNkv86n4aUFXMEzIiR9ObTcC7PqJgpV/kFoViC0C07dmi0WCKF8JdwDhgJFDr/63KjyDW5yWeqNmKyg5qP0glyNWDWvP3XX7Xdr26O7drzq7/UxyA/wfcD263Tg3k2wAAAABJRU5ErkJggg==',
        routeName: 'cs-stories',
        color: '#ff015f',
        categori: 'social',
        enabled: true,
        show: true
    })

    // The snippet below will automatically install the app from the App Store for supported phones.

    const isInstalled = window.localStorage.getItem('cs-stories-installed') === 'yes'

    if (!isInstalled) {
        const storedApps = JSON.parse(window.localStorage.getItem('gks_app'))

        if (storedApps && window.APP.$store && storedApps.filter(v => v.route === 'cs-stories').length === 0) {
            window.APP.$store.commit('APP_INDIR', {
                name: 'Stories',
                icons: 'data:image/png;base64,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',
                routeName: 'cs-stories'
            })

            window.localStorage.setItem('cs-stories-installed', 'yes')
        }
    }
} else
    window.APP.$phoneAPI.config.apps.push({ // If you want to edit the app's position, name, icon or color you may do so here.
        MenuPage: true,
        name: 'Stories',
        en_US__name: 'Stories',
        menuTitle: 'visible',
        icons: 'data:image/png;base64,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',
        routeName: 'cs-stories',
        color: '#ff015f',
        enabled: true
    })

window.APP.$router.addRoutes([{
    path: '/cs-stories',
    name: 'cs-stories',

    component: {
        template: ''
    }
}])

window.APP.$bus.$on('keyUpBackspace', () => {
    if (window.CS_STORIES.documentHooked && (!window.CS_STORIES.isAnimating) && ((!window.CS_STORIES.isVisible()) || window.CS_STORIES.isHome()))
        window.CS_STORIES.hide()
})

window.APP.$router.beforeEach((to, from, next) => {
    next()

    if (to.name === 'cs-stories') {
        window.CS_STORIES.hookDocument()
        window.CS_STORIES.show()
    } else
        window.CS_STORIES.unhookDocument()
})

window.CS_STORIES.setUsingMouse(window.localStorage.getItem('gc_mouse') === 'true' || window.localStorage.getItem('gks_app') ? true : false) // Informing cs-stories that the phone is using NUI mouse.
