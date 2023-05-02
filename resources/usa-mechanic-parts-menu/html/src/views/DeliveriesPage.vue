<template>
	<v-card>
		<v-card-title>Deliveries</v-card-title>
		<v-card-subtitle>Your currently delivered items!</v-card-subtitle>
		<v-simple-table height="75vh">
			<template v-slot:default>
				<tbody>
				<tr
				v-for="part in menuData.deliveredParts"
				:key="part.uuid"
				>
					<td width="23%" class="pa-0">
						<v-img :src="getItemImage(part.name)" height="150px" width="200px"></v-img>
					</td>
					<td width="53%" class="text-left">{{ part.name }}</td>
					<td width="23%" class="text-center">
						<v-btn
						color="primary"
						elevation="2"
						large
						@click='claimPart(part.uuid)'
						>
						Claim
						</v-btn>
					</td>
				</tr>
				</tbody>
			</template>
		</v-simple-table>
	</v-card>
</template>

<script>
import $ from 'jquery'
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
		getItemImage(partName) {
			return this.$store.state.itemImages[partName];
		},
		claimPart(partId) {
			$.post("https://usa-mechanic-parts-menu/receiveData", JSON.stringify({
				type: "claimPart",
				uuid: partId
			}))
		}
	},
};
</script>

<style scoped>
</style>
