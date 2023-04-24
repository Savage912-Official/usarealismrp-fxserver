<template>
	<v-container fluid fill-height>
		<v-row justify="center" align="center">
			<v-card width="75%">
				<v-tabs
					v-model="tab"
					bg-color="primary"
					grow
				>
					<v-tab @click="fetchLeaderboard()">Leaderboard</v-tab>
					<v-tab>Parts</v-tab>
					<v-tab @click="fetchOrders()">Orders</v-tab>
					<v-tab @click="fetchDeliveries()">Deliveries</v-tab>
					<v-tab @click="exitMenu()">X</v-tab>
				</v-tabs>

				<v-tabs-items v-model="tab">
					<v-tab-item>
						<LeaderboardPage/>
					</v-tab-item>

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
import LeaderboardPage from "./LeaderboardPage";

export default {
	name: "HomePage",
	components: {
		LeaderboardPage,
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
		exitMenu() {
			$.post('https://usa-mechanic-parts-menu/exitMenu', JSON.stringify({}));
			this.$store.state.top50Mechanics = [];
		},
		fetchOrders() {
			$.post('https://usa-mechanic-parts-menu/receiveData', JSON.stringify({
				type: "fetchOrders"
			}));
		},
		fetchDeliveries() {
			$.post('https://usa-mechanic-parts-menu/receiveData', JSON.stringify({
				type: "fetchDeliveries"
			}));
		},
		fetchLeaderboard() {
			$.post('https://usa-mechanic-parts-menu/receiveData', JSON.stringify({
				type: "fetchLeaderboard"
			}));
		}
	}
};
</script>

<style scoped>
</style>
