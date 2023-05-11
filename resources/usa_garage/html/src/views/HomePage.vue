<template>
<v-container fluid fill-height>
		<v-row justify="center" align="center">
			<v-card width="75%">
				<v-card-title>Public Garage</v-card-title>
				<v-card-subtitle>View your currently stored vehicles</v-card-subtitle>
				<v-simple-table height="75vh">
					<template v-slot:default>
						<tbody>
							<tr>
								<th>Plate</th>
								<th>Name</th>
								<th>Upgrades</th>
								<th>Stored</th>
								<th></th>
							</tr>
							<tr
							v-for="veh in menuData.vehicles"
							:key="veh.plate"
							>
							<td>{{ veh.plate }}</td>
							<td>{{ veh.make }} {{ veh.model }}</td>
							<td>
								{{ ((veh.upgrades && veh.upgrades.join(", ")) || "None") }}
							</td>
							<td>{{ veh.storedStatus }}</td>
							<td>
								<v-btn
									:color="veh.storedStatus == 'Stored' ? 'primary' : 'secondary'"
									elevation="2"
									@click='sendData("retrieve", { vehicle: veh })'
									>
									Retrieve
								</v-btn>
							</td>
							</tr>
							<tr v-if="menuData.vehicles.length == 0">
								<td width="100%">
									You have no vehicles stored at any public garages
								</td>
							</tr>
						</tbody>
					</template>
				</v-simple-table>
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
			$.post('https://usa_garage/receiveData', JSON.stringify({
				type: type,
				data: data
			}));
		}
	},
};
</script>

<style scoped>
</style>
