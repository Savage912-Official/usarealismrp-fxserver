import React, {useState, useEffect} from 'react';
import '../App.css'

import CardContent from '@mui/material/CardContent'
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Grid from '@mui/material/Grid';
import AnnouncementIcon from '@mui/icons-material/Announcement';

import {fetchNui} from "../../utils/fetchNui";

import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import Autocomplete from '@mui/material/Autocomplete';

import CloudIcon from '@mui/icons-material/Cloud';
import CarRentalIcon from '@mui/icons-material/CarRental';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import MapIcon from '@mui/icons-material/Map';

import TextField from '@mui/material/TextField';

interface props {
	playercount: number,
	maxcount: number,
	setNotifMessage: any
}

interface message {
	message: string
}

const StaffCommands: React.FC<props> = (props) => {

	const [tpcoords, setTpCoords] = useState(false)

	const handleTpCoordsOpen = () => {
		setTpCoords(true)
	}

	const handleTpCoordsClose = () => {
		setTpCoords(false)
	}

	const teleportWaypoint = () => {
		fetchNui('tpwaypoint').then(resData => { 
			props.setNotifMessage(resData)
		})
	}

	const [coordsMessage, setCoordsMessage] = useState("")

	const updateCoordsMessage = (e: any) => {
		setCoordsMessage(e.target.value)
	}

	const handleCoordsMessage = () => {
		if (coordsMessage === "") { 
			props.setNotifMessage("Please provide valid coordinates.") 
			return 
		}
		fetchNui<message>('tpcoords', { message: coordsMessage }).then(resData => { 
			handleTpCoordsClose()
			props.setNotifMessage(resData)
			setCoordsMessage("")
		})
	}

	useEffect(() => {
    // could ask for weather here and set the value of the weather box with it, if requested that is.
  }, []);

	return (
		<div>
			<Dialog className="dialogBan" open={tpcoords} onClose={handleTpCoordsClose} aria-labelledby="alert-dialog-title" aria-describedby="alert-dialog-description2" >
				<DialogTitle id="alert-dialog-title"> {"Teleport to Coords"} </DialogTitle>
				<DialogContent>
				<TextField value={coordsMessage} onChange={updateCoordsMessage} label="Coordinates" sx={{marginBottom: '15px', marginTop:'5px', width: 300 }} />
				<DialogContentText id="alert-dialog-description2">Please provide a string in vector3 or vector4 format.</DialogContentText>
				</DialogContent>
				<DialogActions>
					<Button onClick={handleTpCoordsClose}>Cancel</Button>
					<Button onClick={handleCoordsMessage} autoFocus>Teleport</Button>
				</DialogActions>
			</Dialog>

			<CardContent>
				<Grid container spacing={2} maxWidth={585}>
					<Grid item>
						<List dense={true}>
							<ListItemButton onClick={teleportWaypoint}>
								<ListItemIcon>
									<LocationOnIcon />
								</ListItemIcon>
								<ListItemText primary="Teleport to Waypoint" secondary='Teleport to your currently set waypoint.' />
							</ListItemButton>
							<ListItemButton onClick={handleTpCoordsOpen}>
								<ListItemIcon>
									<MapIcon />
								</ListItemIcon>
								<ListItemText primary="Teleport to Coords" secondary='Input vector3 or vector4 coordinates to teleport to.' />
							</ListItemButton>
						</List>
					</Grid>
				</Grid>
			</CardContent>
		</div>
  );
}

export default StaffCommands;