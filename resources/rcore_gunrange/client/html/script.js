function close() {
    $.post('http://rcore_gunrange/close', JSON.stringify({}));
}

var app = new Vue({
    el: '#app',
    data: {
        visible: false,
        bullets: [],
        points: 0,
        locales: {
            title: 'Gunrange',
            subtitle: '',
            points: 'Points'
        },
        page: 'menu',
        menuItems: [
            {
                label: '7m - range',
                value: 7,
            },
            {
                label: '12m - range',
                value: 7,
            }
        ],
        menuButton: [
            {
                label: 'Cancel',
                style: 'danger',
                name: 'cancel',
            },
            {
                label: 'Next',
                style: 'success',
                name: 'next',
            }
        ],
        menu: {
            label: 'Select distance',
            position: 'middle-right',
        },
        selectedMenuItemIndex: 0,
    },
    computed: {
        menuPosition: function(){
            if(this.menu.position === 'middle-right'){
                return 'middle-right';
            }
        },
        selectedItem: function() {
            if (this.menuItems[this.selectedMenuItemIndex]) {
                return this.menuItems[this.selectedMenuItemIndex]
            }
            return null;
        },
    },
    methods: {
        selectButton: function(button){
            $.post('http://rcore_gunrange/select', JSON.stringify({
                button: button,
                item: this.selectedItem,
            }))
        },
        buttonStyle: function(button){
            if(button.style === 'danger'){
                return 'btn btn-danger';
            }else if(button.style === 'success'){
                return 'btn btn-success';
            }else{
                return 'btn btn-default';
            }
        },
        selectUp: function(){
            if(this.menuItems.length === 0){
                return;
            }

            if(this.menuItems[this.selectedMenuItemIndex+1]){
                this.selectedMenuItemIndex++;
            } else {
                this.selectedMenuItemIndex = 0;
            }
        },
        selectDown: function(){
            if(this.menuItems.length === 0){
                return;
            }

            if(this.menuItems[this.selectedMenuItemIndex-1]){
                this.selectedMenuItemIndex--;
            } else {
                this.selectedMenuItemIndex = this.menuItems.length;
            }
        },
        select: function(index){
            if(this.menuItems[index]){
                this.selectedMenuItemIndex = index;
            }
        }
    }
});

$(function () {
    window.addEventListener("message", function (event) {
        let item = event.data;
        if (item.type === "ui") {
            app.visible = item.value
            app.page = 'range';
        }else if(item.type == "bullet"){
            app.bullets.push(item.value);
            if(item.value.points != -1){
                app.points = app.points + parseInt(item.value.points)
            }
        }else if(item.type == "clean"){
            app.bullets = [];
            app.points = 0;
        }else if(item.type === 'menu'){
            if(item.visible){
                app.menuItems = item.items;
                app.menuButton = item.buttons;
                app.menu = item.menu;
                app.visible = true;
                app.page = 'menu';
            }else {
                app.visible = false;
                app.selectedMenuItemIndex = 0;
                app.menuItems = [];
                app.menuButton = [];
            }
        }
    });

    var closeKeys = [27, 8];

    $(document.body).bind("keyup", function (key) {
        if (closeKeys.includes(key.which)) {
            close()
        }
    });

});
