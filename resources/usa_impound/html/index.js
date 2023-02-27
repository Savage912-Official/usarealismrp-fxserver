$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false);

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true);
            } else {
                display(false);
            }
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://usa_impound/exit', JSON.stringify({}));
            return;
        }
    };
    $("#close").click(function () {
        $.post('https://usa_impound/exit', JSON.stringify({}));
        return;
    })
    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue < 1) {
            $.post("https://usa_impound/error", JSON.stringify({
                error: "Cant impound for less than 1 day"
            }));
            return;
        } else if (!inputValue) {
            $.post("https://usa_impound/error", JSON.stringify({
                error: "There was no value in the input field"
            }));
            return;
        }
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('https://usa_impound/main', JSON.stringify({
            days: inputValue,
        }));
        console.log(inputValue);
        return;
    })
})