Locale = {}

Locale.MetroStation = "Metro Station"
Locale.TrainStation = "Train Station"
Locale.FreightStation = "Freight Station"
Locale.Horn = "Horn"
Locale.OpenCloseDoors = "Open/Close Doors"
Locale.LeaveTrain = "Leave Train"
Locale.SwitchSeats = "Switch Seats"
Locale.EnterTrainAsDriver = "Enter Train as Driver"
Locale.EnterMetroAsDriver = "Enter Metro as Driver"
Locale.EnterTrainAsPassanger = "Enter Train as Passanger"
Locale.SitDownInMetro = "Sit down in Metro"
Locale.MetroInfoHeader = "Welcome to the LS Transit Family!"
Locale.MetroInfoText = {
	"You have started working as one of our Metro Operators!",
	"Your job is to drive the metro around the city and make sure its citizens are able to get where they need to go!",
	"The controls for the train will be shown to you when you get inside of it!",
	"Make sure to drive safely and stop at every station for at least 30 seconds!",
	"You can delete your train with /deleteTrain when you are done!",
}
Locale.TrainInfoHeader = "Welcome to the LS Transit Family!"
Locale.TrainInfoText = {
	"You have started working as one of our Train Operators!",
	"Your job is to drive the train around the state and make sure its citizens are able to get where they need to go!",
	"The controls for the train will be shown to you when you get inside of it!",
	"Make sure to drive safely and stop at every station for at least 30 seconds!",
	"You can delete your train with /deleteTrain when you are done!",
}
Locale.TrainSpawnMenuTitle = "LS Transit Spawn Menu"
Locale.TrainSpawnMenuTitleNativeUI = "Spawn Menu"
Locale.TrainSpawnMenuSubtitleNativeUI = "Spawn a Train"
Locale.TrainNotIssuedToYou = "This train is not issued to you!"
Locale.AlreadyHaveTrain = "You already have a train!"
Locale.TrackOccupied = "The tack is currently occupied please wait until the current train has left the trainyard!"
Locale.MetroSpawnText = "Your Train has been set ready for you at the Southbound Platform!"
Locale.TrainSpawnText = "Your Train has been set ready for you!"
Locale.FreightSpawnText = "Your Train has been set ready for you!"
Locale.GettingToCloseToOtherTrain = "You are getting to close to another train, SLOW DOWN!"
Locale.NoFreeSeats = "No Free Seats"
Locale.BuyTicketsAlert = "Purchase Tickets"
Locale.UseTicketMachineOxLib = "Use Ticket Machine"
Locale.TicketMachineTitle = "Los Santos Transit Ticket Machine"
Locale.TicketMachineTitleNativeUI = "LS Transit"
Locale.TicketMachineSubtitleNativeUI = "Ticket Machine"
Locale.TrainTicketName = "Train Day Ticket"
Locale.TrainTicketDescription = "Purchase a Train Day Ticket for $100"
Locale.AlreadyHasTrainTicket = "You already have a train day ticket for today!"
Locale.BoughtTrainTicket = "You have bought a train day ticket for $100"
Locale.NotEnoughtMoneyForTrainTicket = "You do not have enough money for a Day Ticket ($100)"
Locale.MetroTicketName = "Metro Day Pass"
Locale.MetroTicketDescription = "Purchase a Metro Day Pass for $50"
Locale.AlreadyHasMetroTicket = "You already have a daypass for today!"
Locale.BoughtMetroTicket = "You have bought a metro daypass for $50"
Locale.NotEnoughtMoneyForMetroTicket = "You do not have enough money for a Day Pass ($50)"
Locale.ClockInOxLib = "Clock In"
Locale.ClockOffOxLib = "Clock Off"
Locale.SpawnTrainOxLib = "Spawn Train"
Locale.ClockOnDutyMetro3DText = "[E] - Clock On Duty (~r~Metro~s~)"
Locale.ClockOffDutyMetro3DText = "[E] - Clock Off Duty (~r~Metro~s~)"
Locale.ClockOnDutyTrain3DText = "[E] - Clock On Duty (~r~Train~s~)"
Locale.ClockOffDutyTrain3DText = "[E] - Clock Off Duty (~r~Train~s~)"
Locale.SpawnMetro3DText = "[F] - Summon Train (~r~Metro~s~)"
Locale.SpawnTrain3DText = "[F] - Summon Train (~r~ Train~s~)"
Locale.TooFarAway = "You are too far away please come closer!"
Locale.CurrentlyBoardingTrain = "currently boarding the train!" -- this will have a number in front e.g. "5 currently boarding the train!"
Locale.NextStation = "Next Station"
Locale.AtStation = "At Station"
Locale.TrainDriverApproachingNotificaion = "Slow down the train as you approach the station!"
Locale.PassangerApproachingNotificaion = "If you are departing the train please get ready to exit!"
Locale.MetroToDaviesNotificaionTitle = "Metro (To Davies)"
Locale.MetroToLSIANotificaionTitle = "Metro (To LSIA)"
Locale.TrainNotificationTitle = "Train (Los Santos Cricut)"
function strikesFired(strikes) -- Has to be function so the strikes amount can be within the string
	return "You have ".. strikes .." Strikes, and got sacked from driving trains!"
end
function strikesNotification( strikes, maxStrikes ) -- Has to be function so the strikes amount can be within the string
	return "You did not stop at the station for long enough! "..strikes.."/"..maxStrikes.." Strikes!"
end
function noTicketCountdownAlert(seconds) -- Has to be function so the seconds can be within the string
	return "You have no ticket. " .. seconds .. " seconds before 911 call!"
end
Locale.PoliceCalled = "911 Called"
Locale.TrainHasPassangerWithNoTicket = "Head's Up: There is a passenger on your train without a Ticket!"
Locale.AlertLeftTrain = "Thank you for leaving please buy a valid ticket"
function missingItem(item)
	return "You do not have a "..item
end
Locale.NotPermittedToClockIn = "You are not permitted to clock in"
Locale.TrainDissapeared = "The train you where seated on seams to have poofed!"