import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
	state: {
		vehicles: [],
		showNotification: false,
		notificationText: ""
	},
	getters: {
		menuData(state) {
			return state;
		},
	},
	mutations: {
		setMenuData(state, payload) {
			state = Object.assign(state, payload.data)
		},
	},
	actions: {},
});
