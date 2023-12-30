$("#blackscreen").fadeOut(1500);

var VueJS = new Vue({
	el: '#container',
	data:
	{
		menuItems: [],
	},
})

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

var activeIndex = 0;

function ChangeNumber(result){
    if(result){
        if(activeIndex + 1 == VueJS.menuItems.length) {
            activeIndex = -1;
        }
        activeIndex ++;
    }else{
        if(activeIndex == 0){
            activeIndex = VueJS.menuItems.length;
        }
        activeIndex --;
    }
}

$(document).ready(function(){
    var params = getQueryParams();
    $.post('http://rcore_television/menuloaded', JSON.stringify({
        identifier: params.identifier,
    }));
    window.addEventListener('message', function(event) {
        var data = event.data;
        if(data.type === "menuItems"){
            VueJS.menuItems.push(data.items)
        }

        if(data.type === "enter"){
            $.post('http://rcore_television/itemSelected', JSON.stringify({
                identifier: params.identifier,
                item: activeIndex,
            }));
        }

        if(data.type === "direction_bottom"){
            ChangeNumber(true)
            for(var i = 0; i < VueJS.menuItems.length; i ++) VueJS.menuItems[i].active = false
            VueJS.menuItems[activeIndex].active = true
        }

        if(data.type === "direction_top"){
            ChangeNumber(false)
            for(var i = 0; i < VueJS.menuItems.length; i ++) VueJS.menuItems[i].active = false
            VueJS.menuItems[activeIndex].active = true
        }
    });
});
