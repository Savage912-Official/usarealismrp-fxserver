<template>
	<v-container fluid fill-height>
		<v-row justify="center" align="center">
			<v-card width="75%">
				<v-tabs
					v-model="tab"
					bg-color="primary"
					grow
				>
					<v-tab>Parts</v-tab>
					<v-tab>Orders</v-tab>
					<v-tab>Deliveries</v-tab>
					<v-tab @click="exitMenu()">X</v-tab>
				</v-tabs>

				<v-tabs-items v-model="tab">
					<v-tab-item>
						<PartsPage/>
					</v-tab-item>

					<v-tab-item>
						<OrdersPage/>
					</v-tab-item>

					<v-tab-item>
						<DeliveriesPage/>
					</v-tab-item>
				</v-tabs-items>

				<v-snackbar
					v-model="menuData.showNotification"
					:timeout="3500"
					>
					{{ menuData.notificationText }}

					<template v-slot:action="{ attrs }">
						<v-btn
						color="blue"
						text
						v-bind="attrs"
						@click="menuData.showNotification = false"
						>
						Close
						</v-btn>
					</template>
				</v-snackbar>
			</v-card>
		</v-row>
	</v-container>
</template>

<script>
import $ from 'jquery';
import { mapGetters } from "vuex";
import PartsPage from "./PartsPage";
import OrdersPage from "./OrdersPage";
import DeliveriesPage from "./DeliveriesPage";

export default {
	name: "HomePage",
	components: {
		PartsPage,
		OrdersPage,
		DeliveriesPage
	},
	data() {
		return {
            error: "",
			tab: null
        };
	},
	computed: {
		...mapGetters(["menuData"]),
	},
	methods: {
		sendError(text) {
			this.error = text;
			setTimeout(() => {
				this.error = "";
			}, 3000);
		},
		async exitMenu() {
			$.post('https://usa-mechanic-parts-menu/exitMenu', JSON.stringify({}));
		},
	}
};
</script>

<style scoped>
</style>
