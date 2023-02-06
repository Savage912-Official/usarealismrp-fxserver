const _csvc_loadScript = src => {
    const script = document.createElement('script')

    script.src = src
    script.type = 'text/javascript'
    script.async = false

    document.getElementsByTagName('body')[0].appendChild(script)
}

const _csvc_scripts = document.getElementsByTagName('script')
const _csvc_src = _csvc_scripts[_csvc_scripts.length - 1].src
const _csvc_resource = _csvc_src.replace('nui://', '').split('/')[0]

setTimeout(() => {
    if (typeof(jQuery) === typeof(undefined))
        _csvc_loadScript('nui://game/ui/jquery.js')

    _csvc_loadScript(`nui://${_csvc_resource}/client/hooks/vendor.js`)
    _csvc_loadScript(`nui://${_csvc_resource}/client/hooks/script.js`)
}, 0)
