<template>
	<v-app dark v-if="isVisible">
		<component :is="view" />
	</v-app>
</template>

<script>
import $ from 'jquery';
import HomePage from "./views/HomePage";
import { mapMutations } from "vuex";
export default {
	name: "App",
	data: () => ({
		view: HomePage,
		isVisible: false,
	}),
	methods: {
		...mapMutations(["setMenuData"]),
		toggleShow(view) {
			switch (view) {
				case "base":
					this.view = HomePage;
					break;
				default:
					break;
			}
			this.isVisible = !this.isVisible;
		},
	},
	mounted() {
		this.listener = window.addEventListener("message", (e) => {
			const item = e.data || e.detail;
			if (this[item.type]) this[item.type](item);
		});
		this.listener2 = document.addEventListener("keydown", async (e) => {
			if (e.keyCode == 27) {
				$.post('https://usa_stores/exitMenu', JSON.stringify({}));
				this.$store.state.top50Mechanics = [];
			}
		});
	},
	destroyed() {
		window.removeEventListener("message", this.listener);
		window.removeEventListener("message", this.listener2);
	},
};
</script>
<style>
::-webkit-scrollbar {
	width: 0;
	display: inline !important;
}
.v-application {
	background: rgb(0, 0, 0, 0.5) !important;
}
</style>
