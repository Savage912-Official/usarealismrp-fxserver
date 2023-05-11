<template>
<v-container fluid fill-height>
		<v-row justify="center" align="center">
			<v-card width="75%">
				<v-card-title>Store</v-card-title>
				<v-card-subtitle>Welcome!</v-card-subtitle>
				<v-tabs
					v-model="tab"
					bg-color="primary"
					grow
				>
					<v-tab
					v-for="tab in menuData.tabs"
					:key="tab"
					@click="sendData('tabClicked', tab)"
					>{{ tab }}</v-tab>
					<v-tab @click="exitMenu()">X</v-tab>
				</v-tabs>
				<v-tabs-items v-model="tab">
					<v-tab-item
					v-for="tab in menuData.tabs"
					:key="tab"
					>
						<v-simple-table height="75vh" v-if="menuData.items">
							<template v-slot:default>
								<tbody>
									<tr
									v-for="item in menuData.items"
									:key="item.name"
									>
										<td>
											<v-img :src="getItemImage(item.name)" height="150px" width="200px"></v-img>
										</td>
										<td>{{ item.name }}</td>
										<td>${{ item.price.toLocaleString("en-US") }}</td>
										<td>
											<v-btn
											color="primary"
											elevation="2"
											large
											@click="sendData('purchase', {
												tab: tab,
												itemName: item.name
											})"
											>
											Purchase
											</v-btn>
										</td>
									</tr>
								</tbody>
							</template>
						</v-simple-table>
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
import { mapGetters } from "vuex";
import $ from 'jquery'

export default {
	name: "HomePage",
	data() {
		return {
			tab: null
		};
	},
	computed: {
		...mapGetters(["menuData"])
	},
	methods: {
		async sendData(type, data) {
			$.post('https://usa_stores/receiveData', JSON.stringify({
				type: type,
				data: data
			}));
		},
		exitMenu() {
			$.post('https://usa_stores/exitMenu', JSON.stringify({}));
		},
		getItemImage(name) {
			return this.$store.state.itemImages[name] || "https://images.unsplash.com/photo-1460687521562-9eead9abe9e8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
		}
	},
};
</script>

<style scoped>
</style>
