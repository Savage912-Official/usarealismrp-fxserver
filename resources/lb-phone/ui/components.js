function SetPopUp(data) {
    if (!data?.buttons) return;

    for (let i = 0; i < data.buttons.length; i++) {
        if (data.buttons[i].cb) data.buttons[i].callbackId = i;
    }

    fetch("https://lb-phone/SetPopUp", {
        method: "POST",
        body: JSON.stringify(data),
    })
        .then((res) => res.json())
        .then((buttonId) => {
            if (!data.buttons[buttonId]?.cb) return;
            data.buttons[buttonId].cb();
        });
}

function SetContextMenu(data) {
    if (!data?.buttons) return;

    for (let i = 0; i < data.buttons.length; i++) {
        if (data.buttons[i].cb) data.buttons[i].callbackId = i;
    }

    fetch("https://lb-phone/SetContextMenu", {
        method: "POST",
        body: JSON.stringify(data),
    })
        .then((res) => res.json())
        .then((buttonId) => {
            if (!data.buttons[buttonId]?.cb) return;
            data.buttons[buttonId].cb();
        });
}

function UseComponent(cb, data) {
    if (!cb || !data?.component) return;

    fetch("https://lb-phone/ShowComponent", {
        method: "POST",
        body: JSON.stringify(data),
    })
        .then((res) => res.json())
        .then((data) => {
            cb(data);
        })
        .catch((err) => {
            console.log(err);
            cb(null);
        });
}

function SelectGallery(data) {
    UseComponent(data.cb, { ...data, component: "gallery" });
}

function SelectGIF(cb) {
    UseComponent(cb, { component: "gif" });
}

function SelectEmoji(cb) {
    UseComponent(cb, { component: "emoji" });
}

function GetSettings() {
    return new Promise((resolve, reject) => {
        fetch("https://lb-phone/GetSettings", {
            method: "POST",
            body: JSON.stringify({}),
        })
            .then((res) => res.json())
            .then(resolve)
            .catch(reject);
    });
}

function GetLocale(path, format) {
    return new Promise((resolve, reject) => {
        fetch("https://lb-phone/GetLocale", {
            method: "POST",
            body: JSON.stringify({ path, format }),
        })
            .then((res) => res.json())
            .then(resolve)
            .catch(reject);
    });
}

let settingListeners = [];
function OnSettingsChange(cb) {
    if (!cb) return;
    settingListeners.push(cb);
}

window.addEventListener("message", (event) => {
    if (event.data.type === "settingsUpdated") {
        settingListeners.forEach((cb) => cb(event.data.settings));
    }
});
