import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
	state: {
		playerName: "John Doe",
		rank: 1,
		top50Mechanics: [],
		availableParts: [],
		orderedParts: [],
		deliveredParts: [],
		itemImages: [],
		showNotification: false,
		notificationText: "",
		lvl2RequiredRepairCount: null
	},
	getters: {
		menuData(state) {
			return state;
		},
	},
	mutations: {
		setMenuData(state, payload) {
			state = Object.assign(state, payload.data)
			// convert delivery progress to integer since it comes in as a decimal
			for (let i = 0; i < state.orderedParts.length; i++) {
				state.orderedParts[i].deliveryProgress = Math.round(state.orderedParts[i].deliveryProgress * 100)
			}
		},
	},
	actions: {},
});
