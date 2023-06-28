$(function() {
    function display(bool) {
        if (bool) {
            document.getElementById("body").classList.remove("animate__bounceInLeft");
            document.getElementById("body").classList.remove("animate__bounceOutRight");
            $("body").show();
            document.getElementById("body").classList.add("animate__bounceInLeft");
        } else {
            document.getElementById("body").classList.remove("animate__bounceInLeft");
            document.getElementById("body").classList.add("animate__bounceOutRight");
            $("body").hide(500);
        }
    }

    display(false);

    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true);
            } else {
                display(false);
            }
        }
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post("https://usa-artHeist/exit", JSON.stringify({}));
            return;
        }
    };

    $("#start").click(function() {
        $.post("https://usa-artHeist/starting", JSON.stringify({}));
        return;
    });
});