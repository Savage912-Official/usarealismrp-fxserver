var app = new Vue({
    el: '#app',
    data: {
        isLoading: true,
        playerData: [],
        currentHoveredPlayerChar: null,
    },
    methods: {}
})

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        switch (event.data.type) {
            case "toggle":
                $("#wrap").toggle();
                if ($("#wrap").is(":hidden")) {
                    app.isLoading = true;
                    app.playerData = [];
                }
                break;
            case "playerData":
                app.playerData = event.data.data
                app.isLoading = false;
                break;
        }
    }, false);

    document.onmousedown = function(data) {
        if (data.which == 3) { // right click
            $.post("http://usa-playerlist-new/removeNuiFocus", "")
        }
    };
})