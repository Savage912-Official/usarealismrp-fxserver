<template>
	<v-card>
		<v-card-title>Parts Catalog</v-card-title>
		<v-card-subtitle>Hello, {{ menuData.playerName }}! You are currently rank: {{ menuData.rank }} </v-card-subtitle>
		<v-simple-table height="75vh">
			<template v-slot:default>
				<tbody>
				<tr
				v-for="part in menuData.availableParts"
				:key="part.name"
				>
					<td width="23%" class="pa-0">
						<v-img :src="getItemImage(part.name)" height="150px" width="200px"></v-img>
					</td>
					<td width="10%" class="pa-0 text-left">${{ part.price.toLocaleString("en-US") }} </td>
					<td width="43%" class="text-left">{{ part.name }}</td>
					<td width="23%" class="text-center">
						<v-btn
						color="primary"
						elevation="2"
						large
						@click="sendData('orderPart', part.name)"
						>
						Order
						</v-btn>
					</td>
				</tr>
				<tr v-if="menuData.availableParts.length == 0">
					<td width="100%">
						You must be mechanic rank 2 or higher to order parts ({{ menuData.lvl2RequiredRepairCount }} or more repairs)
					</td>
				</tr>
				</tbody>
			</template>
		</v-simple-table>
	</v-card>
</template>

<script>
import { mapGetters } from "vuex";
import $ from 'jquery'

export default {
	name: "PartsPage",
	data() {
		return {
			colorOptions: ["success", "error", "warning", "primary"],
			typeOfMessage: "",
			error: "",
			userName: "",
			message: "",
			search: "",
		};
	},
	computed: {
		...mapGetters(["menuData"])
	},
	methods: {
		async sendData(type, data) {
			$.post('https://usa-mechanic-parts-menu/receiveData', JSON.stringify({
				type: type,
				data: data
			}));
		},
		getItemImage(itemName) {
			return this.$store.state.itemImages[itemName];
		}
	},
};
</script>

<style scoped>
</style>
