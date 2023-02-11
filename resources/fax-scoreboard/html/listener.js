$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#list');
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            buf.find('table').append("<tr class=\"heading\"><th>ID</th><th>Identifier</th></tr>");
            $('#wrap').hide();
            return;
        }
        if (item.text.length > 0) {
            $('#loading').hide()
        } else {
            $('#loading').show()
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
    }, false);

    document.onmousedown = function(data) {
        if (data.which == 3) { // right click
            $.post("http://fax-scoreboard/removeNuiFocus", "")
        }
    };
});