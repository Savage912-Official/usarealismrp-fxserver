function getQueryParams() {
    var qs = window.location.search;
    qs = qs.split('+').join(' ');

    var params = {},
        tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;

    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]);
    }
    return params;
}

function updateFrame(){
    var result = getQueryParams();

    $("#black").css(
    {
        "max-width": "1920px",
        "max-height": "1080px",
        "top": "0",
        "bottom": "0",
        "left": "0",
        "right": "0",
    });
}

function editString(string){
    var str = string.toLowerCase();
    var res = str.split("/");
    var final = res[res.length - 1];
    final = final.replace(".mp3", " ");
    final = final.replace(".wav", " ");
    final = final.replace(".wma", " ");
    final = final.replace(".wmv", " ");

    final = final.replace(".aac", " ");
    final = final.replace(".ac3", " ");
    final = final.replace(".aif", " ");
    final = final.replace(".ogg", " ");
    final = final.replace("%20", " ");
    final = final.replace("-", " ");

    return final;
}

var MaxDistance = 10;
var max_volume = 0.5;
var TelevisionPos = [0,0,0];
var PlayerPos = [0,0,0];

$(document).ready(function(){
    var result = getQueryParams();
    $.post('http://rcore_television/loaded', JSON.stringify({
        isMenu: false,
        identifier: result.identifier,
    }));
    window.addEventListener('message', function(event) {
        var data = event.data;
        if(data.type === "rcore_tv_update_pos"){
            PlayerPos = [data.x,data.y,data.z];
        }
        if(data.type === "rcore_tv_update_tv_pos"){
            TelevisionPos = [data.x,data.y,data.z];
            MaxDistance = data.MaxDistance;
            max_volume = data.max_volume / 100;
        }
        if(data.type === "rcore_tv_update_tv_volume"){
            max_volume = data.max_volume / 100;
        }
    });
});

//taken from xsound
//https://github.com/Xogy/xsound

function GetNewVolume()
{
    var d_max = MaxDistance;
    var d_now = BetweenCoords();

    var vol = 0;

    var distance = (d_now / d_max);

    if (distance < 1)
    {
        distance = distance * 100;
        var far_away = 100 - distance;
        vol = (max_volume / 100) * far_away;
    }

    return vol;
}

function BetweenCoords()
{
	var deltaX = PlayerPos[0] - TelevisionPos[0];
	var deltaY = PlayerPos[1] - TelevisionPos[1];
	var deltaZ = PlayerPos[2] - TelevisionPos[2];

	var distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);
	return distance;
}