const FIVEM = 'fivem';
const REDM = 'redm';

const toolbarOptions = {
    container: [
        [{'header': [1, 2, 3, 4, 5, 6, false]}],

        ['bold', 'italic', 'underline', 'strike'],
        ['blockquote', 'code-block', 'link'],

        [{'list': 'ordered'}, {'list': 'bullet'}],
        [{'align': []}, {'indent': '-1'}, {'indent': '+1'}],
        [{'script': 'sub'}, {'script': 'super'}],
        [{'direction': 'rtl'}],

        [{'font': []}, {'color': []}, {'background': []}],

        [{'image': true}, {'video': true}],

        ['clean'],
        ['navBtn'],
    ],
    handlers: {
        image: imageHandler,
        'navBtn': quillNavBtnHandler,
    }
};

const REDM_MARKER_TYPES = {
    'prop_mk_cylinder': 0x94FDAE17,
    'prop_mk_ring': 0xEC032ADD,
    'prop_mk_num_0': 0x29FE305A,
    'prop_mk_num_1': 0xE3C923F1,
    'prop_mk_num_2': 0xD57F875E,
    'prop_mk_num_3': 0x40675D1C,
    'prop_mk_num_4': 0x4E94F977,
    'prop_mk_num_5': 0x234BA2E5,
    'prop_mk_num_6': 0xF9B24FB3,
    'prop_mk_num_7': 0x075FEB0E,
    'prop_mk_num_8': 0xDD839756,
    'prop_mk_num_9': 0xE9F6303B,
    'prop_mk_halo': 0x6903B113,
    'prop_mk_halo_point': 0xD6445746,
    'prop_mk_halo_rotate': 0x07DCE236,
    'prop_mk_sphere': 0x50638AB9,
    'prop_mk_cube': 0x6EB7D3BB,
    's_racecheckpoint01x': 0xE60FF3B9,
    's_racefinish01x': 0x664669A6,
    'p_canoepole01x': 0xE03A92AE,
    'p_buoy01x': 0x751F27D6,
};

let pageCache = {}

//Source: https://stackoverflow.com/questions/59602182/quill-add-image-url-instead-of-uploading-it
function imageHandler() {
    const tooltip = this.quill.theme.tooltip;
    const originalSave = tooltip.save;
    const originalHide = tooltip.hide;

    tooltip.save = function () {
        const range = this.quill.getSelection(true);
        const value = this.textbox.value;
        if (value) {
            this.quill.insertEmbed(range.index, 'image', value, 'user');
        }
    };
    // Called on hide and save.
    tooltip.hide = function () {
        tooltip.save = originalSave;
        tooltip.hide = originalHide;
        tooltip.hide();
    };
    tooltip.edit('image');
    tooltip.textbox.placeholder = app.trans.placeholders.image_url;
}

function pastedImageHandler() {
    addNotification(app.trans.exceptions.error, app.trans.notification.image_paste_error, 'error');
}

function ColorToHex(color) {
    let hexadecimal = color.toString(16);
    return hexadecimal.length == 1 ? "0" + hexadecimal : hexadecimal;
}

function ConvertRGBtoHex(red, green, blue) {
    return "#" + ColorToHex(red) + ColorToHex(green) + ColorToHex(blue);
}

function closePost() {
    $.post('https://rcore_guidebook/close', JSON.stringify({}));
}

function requestPage(pageKey, doneCb, errCb) {
    if (pageCache[pageKey] !== undefined) {
        doneCb(pageCache[pageKey])
        return;
    }

    $.post('https://rcore_guidebook/requestPage', JSON.stringify({
        key: pageKey
    }), function (data) {
        if (data === undefined || data === null) {
            errCb();
            return;
        }
        pageCache[pageKey] = data;
        doneCb(data);
    })
}

function saveEndpoint(type, data, cb) {
    $.post('https://rcore_guidebook/saveEndpoint', JSON.stringify({
        data: data,
        type: type
    }), cb);
}

function deleteEndpoint(cb) {
    $.post('https://rcore_guidebook/deleteEndpoint', JSON.stringify({
        key: app.adminData.confirmData.key,
        type: app.adminData.confirmData.type
    }), cb);
}

function teleportEndpoint(cb) {
    $.post('https://rcore_guidebook/teleport', JSON.stringify({
        key: app.adminData.confirmDataTeleport.key
    }), cb);
}

function getCoordsEndpoint(cb) {
    $.post('https://rcore_guidebook/getCoords', JSON.stringify({}), cb);
}

Vue.use(VueQuillEditor)

let app = new Vue({
    el: '#app',
    data: {
        game: FIVEM,
        editorOptions: {
            modules: {
                'history': true,
                'toolbar': toolbarOptions,
                'clipboard': true,
                // htmlEditButton: {}, -- more info at the bottom of index.html
                resize: {
                    showToolbar: false,
                },
                imageDropAndPaste: {
                    handler: pastedImageHandler
                },
            },
            theme: 'snow'
        },
        visible: false,
        page: false,
        trans: locales,
        categories: [],
        loading: false,
        adminData: {
            showAdmin: false,
            isAdmin: false,
            page: false,
            editedCategory: {},
            editedPage: {},
            editedPoint: {
                is_enabled: true,
            },
            confirmData: {
                key: false,
                type: false,
                text: false
            },
            confirmDataTeleport: {
                key: false,
            },
            customGpsBtn: {
                show: false,
                label: '',
                pos: {
                    x: 0,
                    y: 0,
                    z: 0
                },
                quill: null,
            },
            editedKey: false
        },
        points: [],
        errors: [],
        isSidebarHidden: false,
        useCustomContentLayout: false,
        tempVisibleCategory: false,
    },
    methods: {
        showErrorPage() {
            this.loading = false;
            this.page = {
                key: -1,
                content: `<div style="display: flex;flex-direction: column;justify-content: center;align-items: center;height: 100%;text-align: center;">
                <svg><use xlink:href="img/sad.svg#sad"></use></svg>
                ${this.trans.page_template.not_found_page} </div>`,
            }
        },
        toggleCat() {
            const header = $(event.target);
            const currentCat = header.closest('.js-cat');
            const arrow = currentCat.find('.js-cat-arrow');
            const pages = currentCat.find('.js-pages');

            if (currentCat.hasClass('js-cat-open')) {
                currentCat.removeClass('js-cat-open');
                pages.slideUp(300);
            } else {
                currentCat.addClass('js-cat-open');
                pages.slideDown(300);
            }

            arrow.toggleClass('a-flip-y');
        },
        pageClick(page) {
            const pageKey = page.key;

            this.loading = true;

            requestPage(pageKey, function (data) {
                app.page = data;
                app.loading = false;
                $('.guide__body').scrollTop(0);
            }, app.showErrorPage);
        },
        // Admin
        deepCopyCategory(category) {
            this.errors = [];
            this.adminData.editedKey = category.key || false;
            this.adminData.editedCategory = JSON.parse(JSON.stringify(category));
        },
        initAdminPage(page, callRequest) {
            this.errors = [];
            this.adminData.editedPage = {};
            this.adminData.editedKey = page ? page.key : false;

            if (callRequest) {
                this.loading = true;

                requestPage(page.key, function (data) {
                    app.adminData.editedPage = JSON.parse(JSON.stringify(data));
                    app.loading = false;
                    $('.guide__body').scrollTop(0);
                }, app.showErrorPage);
            } else {
                this.adminData.editedPage = {
                    is_enabled: true,
                };
            }
        },
        initPointPage(point) {
            this.errors = [];

            if (point) {
                let data = JSON.parse(JSON.stringify(point));
                data.color = ConvertRGBtoHex(data.color.r, data.color.g, data.color.b);
                data.marker_color = ConvertRGBtoHex(data.marker_color.r, data.marker_color.g, data.marker_color.b);

                this.adminData.editedPoint = data;
                this.adminData.editedKey = point.key;
            } else {
                this.resetEditedPoint();
                this.adminData.editedKey = false;
            }
        },
        saveForm(type) {
            this.errors = [];
            let form, page, data;

            switch (type) {
                case 'CATEGORY':
                    form = document.querySelector('.js-category-edit')
                    page = 'categoryList';
                    data = this.adminData.editedCategory;

                    break;
                case 'PAGE':
                    form = document.querySelector('.js-page-edit')
                    page = 'pageList';
                    data = JSON.parse(JSON.stringify(this.adminData.editedPage));

                    break;
                case 'POINT':
                    form = document.querySelector('.js-point-edit')
                    page = 'pointList';
                    data = JSON.parse(JSON.stringify(this.adminData.editedPoint));

                    //Change color to RGB
                    data.color = {
                        r: parseInt(data.color[1] + data.color[2], 16),
                        g: parseInt(data.color[3] + data.color[4], 16),
                        b: parseInt(data.color[5] + data.color[6], 16),
                    };
                    data.marker_color = {
                        r: parseInt(data.marker_color[1] + data.marker_color[2], 16),
                        g: parseInt(data.marker_color[3] + data.marker_color[4], 16),
                        b: parseInt(data.marker_color[5] + data.marker_color[6], 16),
                    };

                    break;
                default:
                    return
            }

            validateInputs(form, data, type);

            if (type === 'POINT') {
                data.position.x = parseFloat(data.position.x);
                data.position.y = parseFloat(data.position.y);
                data.position.z = parseFloat(data.position.z);
                data.marker_size.x = parseFloat(data.marker_size.x);
                data.marker_size.y = parseFloat(data.marker_size.y);
                data.marker_size.z = parseFloat(data.marker_size.z);
            }

            if (this.errors.length === 0) {
                this.loading = true;
                saveEndpoint(type, data, function (cb) {
                    app.loading = false;

                    if (cb) {
                        if(type == 'PAGE') {
                            pageCache[data.key] = data;
                        }
                        app.adminData.page = page;
                        addNotification(app.trans.exceptions.success, app.trans.notification.data_save_success, 'success');
                    } else {
                        addNotification(app.trans.exceptions.error, app.trans.notification.data_save_error, 'error');
                    }
                });
            }
        },
        deleteData() {
            this.errors = [];
            this.loading = true;

            deleteEndpoint(function (cb) {
                app.loading = false;
                app.adminData.confirmData = {
                    key: false,
                    type: false,
                    text: false
                };

                if (cb) {
                    addNotification(app.trans.exceptions.success, app.trans.notification.data_delete_success, 'success');
                } else {
                    addNotification(app.trans.exceptions.error, app.trans.notification.data_delete_error, 'error');
                }
            });
        },
        addCategory() {
            this.errors = [];
            if (this.adminData.page === 'categoryAdd') {
                return;
            }

            this.adminData.page = 'categoryAdd';
            this.adminData.editedCategory = {};
        },
        listCategory() {
            this.adminData.page = 'categoryList';
        },
        editPage(page, openFromHelp) {     
            if (this.adminData.page === "pageEdit") {
                return;
            }

            if (openFromHelp) this.adminData.showAdmin = true;

            this.adminData.page = 'pageEdit';
            this.initAdminPage(page, true);
        },
        addPage(openFromHelp) {
            if (openFromHelp) this.adminData.showAdmin = true;

            this.adminData.page = 'pageAdd';
            this.initAdminPage();
        },
        pageList() {
            this.adminData.page = 'pageList';
            this.adminData.editedPage = {};
        },
        listPoints() {
            this.adminData.page = "pointList";
        },
        editPoint(point) {
            this.adminData.page = 'pointEdit';
            this.initPointPage(point);
        },
        addPoint() {
            this.adminData.page = "pointAdd";
            this.initPointPage();
        },
        showTeleportDialog(point) {
            this.adminData.confirmDataTeleport.key = point.key;
        },
        teleportToPoint() {
            teleportEndpoint(function (cb) {
                app.adminData.confirmDataTeleport = {
                    key: false,
                };

                if (cb) {
                    addNotification(app.trans.exceptions.success, app.trans.notification.teleport_success, 'success');
                } else {
                    addNotification(app.trans.exceptions.error, app.trans.notification.teleport_error, 'error');
                }
            });
        },
        resetEditedPoint() {
            app.adminData.editedPoint = {
                blip_size: 1.0,
                blip_color: 4,
                blip_sprite: 162,
                blip_display_type: 2,
                draw_distance: 5,
                size: 1.0,
                position: {
                    x: 0,
                    y: 0,
                    z: 0
                },
                marker_size: {
                    x: 1,
                    y: 1,
                    z: 1
                },
                marker_type: 0,
                marker_draw_distance: 20,
                marker_color: '#ffffff',
                color: '#085488',
                is_enabled: true,
            }
        },
        resetGpsBtnData() {
            this.adminData.customGpsBtn = {
                show: false,
                label: '',
                pos: {
                    x: 0,
                    y: 0,
                    z: 0
                }
            };
        },
        fillCurrentCoords(type) {
            getCoordsEndpoint(function (data) {
                const pos = {
                    x: data.x.toFixed(2),
                    y: data.y.toFixed(2),
                    z: data.z.toFixed(2)
                };
                switch (type) {
                    case 'POINT':
                        app.adminData.editedPoint.position = pos;
                        break;
                    case 'GPS_BTN':
                        app.adminData.customGpsBtn.pos = pos;
                        break;
                }
            });
        },
        generateKey(dataType) {
            if(punycode !== null && punycode !== undefined) {
                let label;
                let key;
                switch (dataType) {
                    case 'CATEGORY':
                        label = this.adminData.editedCategory.label;
                        if (label && label.length) {
                            key = punycode.encode(label);
                            this.adminData.editedCategory.key = key.toLowerCase().replaceAll(/~[a-zA-Z]+~/gm, "").replace("-", "").replace(/ /g, "_");
                            this.$refs.key.value = this.adminData.editedCategory.key;
                        }
                        break;
                    case 'PAGE':
                        label = this.adminData.editedPage.label;
                        if (label && label.length) {
                            key = punycode.encode(label);
                            this.adminData.editedPage.key = key.toLowerCase().replaceAll(/~[a-zA-Z]+~/gm, "").replace("-", "").replace(/ /g, "_");
                            this.$refs.key.value = this.adminData.editedPage.key;
                        }
                        break;
                    case 'POINT':
                        label = this.adminData.editedPoint.label;
                        if (label && label.length) {
                            key = punycode.encode(label);
                            this.adminData.editedPoint.key = key.toLowerCase().replaceAll(/~[a-zA-Z]+~/gm, "").replace("-", "").replace(/ /g, "_");
                            this.$refs.key.value = this.adminData.editedPoint.key;
                        }
                        break;
                }
            }
        },
        generateKeyOnInput(dataType) {
            let key;
            switch (dataType) {
                case 'CATEGORY':
                    key = app.adminData.editedCategory.key;
                    break;
                case 'PAGE':
                    key = app.adminData.editedPage.key;
                    break;
                case 'POINT':
                    key = app.adminData.editedPoint.key;
                    break;
            }
            const length = key ? key.length : false;

            if (!length) {
                this.generateKey(dataType)
            }
        },
        saveGpsBtn() {
            app.errors = [];
            let form = document.querySelector('.js-gps-btn-form');
            let data = app.adminData.customGpsBtn;

            validateInputs(form, data, 'GPS_BTN');

            if (app.errors.length === 0) {
                data.quill.insertEmbed(
                    data.index.index,
                    'navBtn',
                    data,
                    'user'
                );

                app.resetGpsBtnData();
            }
        },
        copyKey(key) {
            copyToClipboard(key)
            addNotification(app.trans.exceptions.success, app.trans.notification.key_copied, 'success');
        },
        goTo(helpType) {
            switch (helpType) {
                case 'USER':
                    this.adminData.showAdmin = false;
                    this.adminData.page = false;
                    break;
            
                case 'ADMIN':
                    this.adminData.showAdmin = true;
                    this.adminData.page = false;
                    this.adminData.isAdmin = true;
                    break;
            }
        },
        makeTempVisible(categoryKey) {
            this.tempVisibleCategory = categoryKey;
        },
        resetTempVisible(){
            this.tempVisibleCategory = false;
        },
    }
});

$(function () {
    // Quill.register("modules/htmlEditButton", htmlEditButton);  -- more info at the bottom of index.html
    Quill.register("modules/resize", window.QuillResizeModule);
    Quill.register("formats/navBtn", QuillNavBtn);

    window.addEventListener("click", function(event) {
        if(event.target.nodeName !== "BUTTON") {
            return;
        }

        var target = event.target;
        if(target.getAttribute("type") === "gps") {
            $.post("https://rcore_guidebook/navigate", JSON.stringify({
                x: parseFloat(target.getAttribute("data-x")),
                y: parseFloat(target.getAttribute("data-y")),
            }))

            addNotification(app.trans.exceptions.success, app.trans.notification.gps_set + ' ' + target.getAttribute("data-label"), 'success');
        }
    });

    window.addEventListener("message", function (event) {
        let item = event.data;
        if (item.type === "OPEN") {
            app.visible = true;
            app.resetTempVisible();
            app.adminData.isAdmin = item.data.isAdmin || false;
            app.adminData.showAdmin = false;
        }

        if (item.type === "OPEN_ADMIN") {
            app.visible = true;
            app.resetTempVisible();
            app.adminData.isAdmin = item.data.isAdmin || false;;
            app.adminData.showAdmin = true;
            app.adminData.page = false;
        }

        if (item.type === "CLOSE") {
            app.visible = false;
            app.useCustomContentLayout = false;
            app.resetTempVisible();
            app.adminData.page = false;
        }

        if (item.type === "REFRESH_PAGE") {
            if (pageCache[item.key] !== undefined) {
                pageCache[item.key] = null;
            }
        }

        if (item.type === "UPDATED_CATEGORY") {
            app.loading = false;
        }

        if (item.type === "UPDATED_PAGE") {
            app.loading = false;
        }

        if (item.type === "INIT_DATA") {
            const data = JSON.parse(JSON.stringify(item.data));
            if (data.firstPage) {
                app.page = data.firstPage;
            } else app.showErrorPage();

            sortData(data);
        }

        if (item.type === "POINTS") {
            app.points = item.data;
        }

        if (item.type === "OPEN_SPECIFIC_PAGE") {
            app.resetTempVisible();
            app.visible = true;
            app.adminData.isAdmin = item.data.isAdmin || false;
            app.adminData.showAdmin = false;
            app.useCustomContentLayout = false;

            if (item.data.customContent) {
                app.useCustomContentLayout = true;
                app.page = {
                    key: -1,
                    content: item.data.customContent
                };
            } else {
                requestPage(item.data.key, function (data) {
                    app.page = data;
                    $('.guide__body').scrollTop(0);

                    app.makeTempVisible(data.category_key);
                    scrollPageIntoView();
                }, app.showErrorPage);
            }
        }

        if(item.type === "CONFIGURATION") {
            app.game = item.game;

            console.log('Getting game configuration', app.game)
        }
    });

    const closeKeys = [27];

    $(document.body).bind("keyup", function (key) {
        if (closeKeys.includes(key.which)) {
            if(app.adminData.customGpsBtn.show) {
                app.adminData.customGpsBtn.show = false;
                return;
            }

            if(app.adminData.confirmData.key) {
                app.adminData.confirmData.key = false;
                return;
            }

            if(app.adminData.confirmDataTeleport.key) {
                app.adminData.confirmDataTeleport.key = false;
                return;
            }

            app.visible = false;
            app.resetTempVisible();
            closePost();
        }
    });

    $(document.body).on("click", ".page__content a", function (e) {
        e.preventDefault();
        const link = e.target;
        const linkClasses = link.classList;

        if(
            !linkClasses.contains('ql-action') && 
            !linkClasses.contains('ql-preview') &&
            !linkClasses.contains('btn') &&
            !linkClasses.contains('a-btn')
        ) {
            copyToClipboard(link.href)

            addNotification(app.trans.exceptions.success, app.trans.notification.link_copied, 'success');
        }
    });
});

function validateInputs(form, data, type) {
    const inputErrorClass = 'a-input--error';

    const textInputs = form.querySelectorAll('input[type="text"].js-validate');
    const numInputs = form.querySelectorAll('input[type="number"].js-validate');
    const selectInputs = form.querySelectorAll('select.js-validate');
    const htmlEditor = form.querySelector('.ql-editor');

    if (htmlEditor) {
        data.content = htmlEditor.innerHTML;
    }

    textInputs.forEach(input => {
        $(input).removeClass(inputErrorClass);

        if (!input.value || input.value.length <= 0) {
            app.errors.push('Input <b>' + input.name + '</b> ' + app.trans.exceptions.cant_be_empty);
            $(input).addClass(inputErrorClass);
        } else if (input.name == 'key' && doesKeyExist(input.value, type)) {
            $(input).addClass(inputErrorClass);
            app.errors.push('Input <b>' + input.name + '</b> ' + app.trans.exceptions.key_exists);
        }
    });

    numInputs.forEach(input => {
        $(input).removeClass(inputErrorClass);

        if (isNaN(parseInt(input.value))) {
            app.errors.push('Input <b>' + input.name + '</b> ' + app.trans.exceptions.not_a_number);
            $(input).addClass(inputErrorClass);
        } else if (input.value < 0 && type !== 'POINT' && type !== 'GPS_BTN') {
            $(input).addClass(inputErrorClass);
            app.errors.push('Input <b>' + input.name + '</b> ' + app.trans.exceptions.greater_equal_zero);
        }
    });

    selectInputs.forEach(input => {
        $(input).removeClass(inputErrorClass);

        if (!input.value || input.value.lenght <= 0) {
            app.errors.push('Dropdown <b>' + input.name + '</b> ' + app.trans.exceptions.cant_be_empty);
            $(input).addClass(inputErrorClass);
        }
    });
}

function doesKeyExist(key, type) {
    let matchFound;

    if (type === 'CATEGORY') {
        $.each(app.categories, function (_, cat) {
            if (cat.key == key && cat.key != app.adminData.editedKey) {
                matchFound = true;
                return;
            }
        });
    } else if (type === 'PAGE') {
        $.each(app.categories, function (_, cat) {
            $.each(cat.pages, function (_, page) {
                if (page.key === key && page.key !== app.adminData.editedKey) {
                    matchFound = true;
                    return;
                }
            });
            if (matchFound) return;
        });
    }

    return matchFound;
}

function sortData(data) {
    const sortedData = Object.fromEntries(
        Object.entries(data ? data.categories : app.categories).sort(([, a], [, b]) => a.order_number - b.order_number)
    );

    $.each(sortedData, function (_, value) {
        const pages = value.pages;

        if (pages) {
            if (pages.length > 1) {
                pages.sort(function (a, b) {
                    const valueA = a.order_number || 0;
                    const valueB = b.order_number || 0;
                    return valueA - valueB
                });
            }
        }
    });

    app.categories = sortedData;
}

function copyToClipboard(text) {
    const tempEl = document.createElement('textarea');
    const selected = document.getSelection();

    tempEl.textContent = text;
    document.body.appendChild(tempEl);

    selected.removeAllRanges();
    tempEl.select();
    document.execCommand('copy');

    selected.removeAllRanges();
    document.body.removeChild(tempEl);
}

function scrollPageIntoView() {
    setTimeout(() => {
        const activePage = $('.nav-pages__page--active');

        if (activePage) {
            activePage[0].scrollIntoView({
                behavior: "smooth",
                block: "center"
            });
        }
    }, 0);
}