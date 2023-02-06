const _css_loadScript = src => {
    const script = document.createElement('script')

    script.src = src
    script.type = 'text/javascript'
    script.async = false

    document.getElementsByTagName('body')[0].appendChild(script)
}

const _css_scripts = document.getElementsByTagName('script')
const _css_src = _css_scripts[_css_scripts.length - 1].src
const _css_resource = _css_src.replace('nui://', '').split('/')[0]

setTimeout(() => {
    if (typeof(jQuery) === typeof(undefined))
        _css_loadScript('nui://game/ui/jquery.js')

    _css_loadScript(`nui://${_css_resource}/client/hooks/vendor.js`)
    _css_loadScript(`nui://${_css_resource}/client/hooks/script.js`)
}, 0)
