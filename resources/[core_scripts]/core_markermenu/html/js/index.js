$("#main").hide();
$(document).ready(function () {
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.markermenu) {
            if (item.markermenu.showmarker) {
                $("#main .markermenu .markermenutext").html(item.markermenu.showmarker);
                $("#main").show();
            }
            if (item.markermenu.hidemarker) {
                if ($('#main .markermenu').hasClass("exit") == false) {
                    $('#main .markermenu').toggleClass('exit');
                }
                setTimeout(function(){
                    if ($('#main .markermenu').hasClass("exit") == true) {
                        $('#main .markermenu').toggleClass('exit');
                    }
                    $("#main").hide();
                }, 400);
            }
        } 
    });
    document.addEventListener("keydown", function onEvent(event) {
        
    });
});