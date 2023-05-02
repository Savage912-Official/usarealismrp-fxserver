<template>
	<v-card>
		<v-card-title>Orders</v-card-title>
		<v-card-subtitle>View the delivery progress of your current orders</v-card-subtitle>
		<v-simple-table height="75vh">
			<template v-slot:default>
				<tbody>
				<tr
				v-for="part in menuData.orderedParts"
				:key="part.uuid"
				>
					<td width="23%" class="pa-0">
						<v-img :src="getItemImage(part.name)" height="150px" width="200px"></v-img>
					</td>
					<td width="43%" class="text-left">{{ part.name }}</td>
					<td width="33%" class="text-left">
						<v-progress-linear v-model="part.deliveryProgress"></v-progress-linear>
					</td>
				</tr>
				</tbody>
			</template>
		</v-simple-table>
	</v-card>
</template>

<script>
import { mapGetters } from "vuex";

export default {
	name: "OrdersPage",
	data() {
		return {};
	},
	computed: {
		...mapGetters(["menuData"]),
	},
	methods: {
		getItemImage(itemName) {
			return this.$store.state.itemImages[itemName];
		}
	}
};
</script>

<style scoped>
</style>
