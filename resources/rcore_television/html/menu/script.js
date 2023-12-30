$("#blackscreen").fadeOut(1500);

var VueJS = new Vue({
	el: '#menu',
	data:
	{
		menuItems: [],
	},
})

$(document).ready(function(){
    $.post('http://rcore_television/loaded', JSON.stringify({
        isMenu: true,
    }));
    window.addEventListener('message', function(event) {
        var data = event.data;

        if(data.type === "reset"){
            VueJS.menuItems = [];
        }

        if(data.type === "rcore_tv_change"){
            for(var i = 0; i < VueJS.menuItems.length; i ++) VueJS.menuItems[i].active = false;
            for(var i = 0; i < VueJS.menuItems.length; i ++){
                var menuData = VueJS.menuItems[i]
                if(menuData.index == data.selected){
                    VueJS.menuItems[i].active = true;
                    break;
                }
            }
        }
        if(data.type === "rcore_tv_add_tv"){
            VueJS.menuItems.push({
                active: false,
                icon: data.icon,
                title: data.title,
                index: data.index,
            });
        }

        if(data.type === "active_first"){
             for(var i = 0; i < VueJS.menuItems.length; i ++){
                var menuData = VueJS.menuItems[i]
                if(menuData.index == 1){
                    VueJS.menuItems[i].active = true;
                    break;
                }
             }
        }
    });
});
