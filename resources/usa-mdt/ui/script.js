const mdtApp = new Vue({
    el: "#content_container",
    data: {
        employee: {
            fname: "",
            lname: "",
            rank: "",
            job: {
                rawName: "",
                displayName: ""
            }
        },
        person_check: {
            _id: null,
            ssn: null,
            fname: null,
            lname: null,
            dob: null,
            dna: null,
            returnedDNA: null,
            licenses: null,
            address: null,
            insurance: null,
            criminal_history: {
                crimes: null,
                tickets: null
            },
            mugshot: "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg",
            personNotes: null
        },
        plate_check: {
            search_input: null,
            registered_owner: null,
            flags: null,
            veh_name: null,
            plate: null,
            vehicleNotes: null
        },
        weapon_check: {
            search_input: null,
            weapon: null,
            weaponNotes: null,
        },
        warrants: [],
        bolos: [],
        police_reports: [],
        name_search: "",
        warrant_search: "",
        bolo_search: "",
        report_search: "",
        new_bolo: {
            description:  "",
            police_report_number: ""
        },
        new_warrant: {
            first_name: "",
            last_name: "",
            dob: "",
            charges: "",
            suspect_description:  "",
            police_report_number: ""
        },
        new_police_report: {
            incident: "",
            location: "",
            other_responders: ""
        },
        current_warrant: {
            first_name: "",
            last_name: "",
            charges: "",
            suspect_description:  "",
            police_report_number: ""
        },
        current_report: {
            incident: "",
            location: "",
            other_responders: ""
        },
        mugshot_url: null,
        dnaModalInput: null,
        error: null,
        personCheckNotifications: [],
        notification: null,
        current_tab: "Person(s) Check", // default tab
        searchedPersonResults: [],
        isLoadingAsyncData: false,
        lastTimeoutId: null
    },
    methods: {
        UpdatePhoto() {
            $("#photo-update").hide();
            if (this.person_check.dob) {
                $.post('http://usa-mdt/updatePhoto', JSON.stringify({
                    fname: this.person_check.fname,
                    lname: this.person_check.lname,
                    dob: this.person_check.dob,
                    url: this.mugshot_url
                }));
                this.notification = "Photo updated!";
                this.mugshot_url = "";
            } else {
                this.error = "You must look up the person before updating their photo!";
            }
        },
        UpdateDNA() {
            $("#dna-update").hide();
            if (this.person_check.dob) {
                $.post('http://usa-mdt/updateDNA', JSON.stringify({
                    fname: this.person_check.fname,
                    lname: this.person_check.lname,
                    dob: this.person_check.dob,
                    dna: this.dnaModalInput
                }));
                this.notification = "DNA updated!";
                this.dnaModalInput = "";
            } else {
                this.error = "You must look up the person before updating their DNA!";
            }
        },
        PerformPersonCheck() {

            this.error = "";

            if (this.person_check) {

                if (this.person_check.ssn != 0 && this.person_check.ssn) {
                    $.post('http://usa-mdt/PerformPersonCheckBySSN', JSON.stringify({
                        ssn: this.person_check.ssn
                    }));
                    return;
                }

                if (this.person_check.dna && this.person_check.dna != "") {
                    $.post('http://usa-mdt/PerformPersonCheckByDNA', JSON.stringify({
                        dna: this.person_check.dna
                    }));
                    return;
                }

                if (!this.person_check.ssn && this.name_search == "" && !this.person_check.dna )
                    this.error = "Please enter an SSN, first and last name, or DNA sample to perform a person check!";

            }
        },
        PerformMarkAddress() {
            /* request person info */
            $.post('http://usa-mdt/PerformMarkAddress', JSON.stringify({
                ssn: this.person_check.ssn,
                fname: this.person_check.fname,
                lname: this.person_check.lname
            }));
        },
        PerformPlateCheck() {
            /* request person info */
            $.post('http://usa-mdt/PerformPlateCheck', JSON.stringify({
                plate: this.plate_check.search_input
            }));
        },
        PerformWeaponCheck() {
            /* request person info */
            $.post('http://usa-mdt/PerformWeaponCheck', JSON.stringify({
                serial: this.weapon_check.search_input
            }));
        },
        changePage(new_page) {
            this.error = null;
            this.notification = null;
            this.personCheckNotifications = [];
            this.current_tab = new_page;
            /* Clear active nav tab */
            ClearActiveNavItem(new_page);
            if (new_page == "Warrants") {
                /* request outstanding warrants */
                $.post('http://usa-mdt/fetchWarrants', JSON.stringify({}));
                $("#warrants").addClass("nav-active");
            } else if (new_page == "BOLO") {
                /* request BOLOs */
                $.post('http://usa-mdt/fetchBOLOs', JSON.stringify({}));
                $("#bolo").addClass("nav-active");
            } else if (new_page == "Person(s) Check") {
                $("#person_check").addClass("nav-active");
            } else if (new_page == "Plate Check") {
                $("#plate_check").addClass("nav-active");
            } else if (new_page == "Weapon Check") {
                $("#weapon_check").addClass("nav-active");
            } else if (new_page == "Police Reports") {
                $.post('http://usa-mdt/fetchPoliceReports', JSON.stringify({}));
                $("#reports").addClass("nav-active");
            }
        },
        CreateBOLO() {
            if (this.new_bolo.description != "") {
                $.post('http://usa-mdt/createBOLO', JSON.stringify({
                    bolo: this.new_bolo
                }));
                this.notification = "BOLO created!";
                this.new_bolo.description = "";
                this.new_bolo.police_report_number = "";
            } else {
                this.notification = "Please fill in all required fields!";
            }
        },
        CreateWarrant() {
            if (this.new_warrant.first_name != "" && this.new_warrant.last_name != "" && this.new_warrant.charges != "" && this.new_warrant.dob) {
                $.post('http://usa-mdt/createWarrant', JSON.stringify({
                    warrant: this.new_warrant
                }));
                this.notification = "Warrant created successfully for: " + this.new_warrant.first_name + " " + this.new_warrant.last_name;
                this.new_warrant.first_name = "";
                this.new_warrant.last_name = "";
                this.new_warrant.dob = "";
                this.new_warrant.charges = "";
                this.new_warrant.suspect_description = "";
                this.new_warrant.police_report_number = "";
            } else {
                this.notification = "Please fill in all required fields!";
            }
        },
        CreatePoliceReport() {
            if (this.new_police_report.incident != "" && this.new_police_report.location != "") {
                $.post('http://usa-mdt/CreatePoliceReport', JSON.stringify({
                    report: this.new_police_report
                }));
                this.notification = "Incident report created!";
                this.new_police_report.incident = "";
                this.new_police_report.location = "";
                this.new_police_report.other_responders = "";
            } else {
                this.notification = "Please fill in all required fields!";
            }
        },
        OpenWarrantDetails(uuid) {
            for (var key in this.warrants) {
                if (uuid == this.warrants[key]._id) {
                    this.error = "";
                    this.current_warrant = this.warrants[key];
                    this.current_tab = "Warrant Detail";
                    return;
                }
            }
            this.error = "Error: did not find a matching warrant for that uuid!";
        },
        OpenPoliceReportDetails(id) {
            $.post('http://usa-mdt/fetchPoliceReportDetails', JSON.stringify({
                id: id
            }));
            /*
            for (var key in this.police_reports) {
                if (uuid == this.police_reports[key]._id) {
                    this.error = "";
                    this.current_report = this.police_reports[key];
                    this.current_tab = "Incident Detail";
                    return;
                }
            }
            this.error = "Error: did not find a matching police report for that uuid!";
            */
        },
        DeleteWarrant(uuid) {
            for (var index in this.warrants) {
                if (uuid == this.warrants[index]._id) {
                    $.post('http://usa-mdt/deleteWarrant', JSON.stringify({
                        warrant_id: this.warrants[index]._id,
                        warrant_rev: this.warrants[index]._rev
                    }));
                    return;
                }
            }
            this.error = "Error: did not find a matching warrant for that uuid!";
        },
        DeleteBOLO(uuid) {
            for (var index in this.bolos) {
                if (uuid == this.bolos[index]._id) {
                    $.post('http://usa-mdt/deleteBOLO', JSON.stringify({
                        bolo_id: this.bolos[index]._id,
                        bolo_rev: this.bolos[index]._rev
                    }));
                    this.bolos.splice(index, 1);
                    this.error = "BOLO deleted!";
                    this.current_tab = "BOLO";
                    return;
                }
            }
            this.error = "Error: did not find a matching BOLO for that uuid!";
        },
        DeletePoliceReport(uuid) {
            for (var index in this.police_reports) {
                if (uuid == this.police_reports[index]._id) {
                    $.post('http://usa-mdt/deletePoliceReport', JSON.stringify({
                        police_report_id: this.police_reports[index]._id,
                        police_report_rev: this.police_reports[index]._rev
                    }));
                    this.current_tab = "Police Reports";
                    return;
                }
            }
            this.error = "Error: did not find a matching police report with that uuid!";
        },
        getNameSearchResults(name) {
            $.post('http://usa-mdt/getNameSearchDropdownResults', JSON.stringify({
                name: name
            }));
            this.searchedPersonResults = [];
            this.isLoadingAsyncData = true;
        },
        selectSearchedNameResult(personDetails) {
            $.post('http://usa-mdt/performPersonCheckByCharID', JSON.stringify({
                id: personDetails._id
            }));
            this.searchedPersonResults = [];
            this.name_search = "";
        },
        setNoteSaveTimeout() {
            // save 2 seconds after done pressing keys
            if (this.lastTimeoutId) window.clearTimeout(this.lastTimeoutId);
            this.lastTimeoutId = window.setTimeout(() =>{
                // send value to server script for saving in mdt-person-check-notes db
                $.post("http://usa-mdt/saveNote", JSON.stringify({
                    targetCharId: this.person_check._id,
                    targetCharFName: this.person_check.fname,
                    targetCharLName: this.person_check.lname,
                    value: this.person_check.personNotes
                }));
            }, 2000);
        },
        setVehNoteSaveTimeout() {
            // save 2 seconds after done pressing keys
            if (this.lastTimeoutId) window.clearTimeout(this.lastTimeoutId);
            this.lastTimeoutId = window.setTimeout(() =>{
                // send value to server script for saving in mdt-person-check-notes db
                $.post("http://usa-mdt/saveVehNote", JSON.stringify({
                    plate: this.plate_check.plate,
                    value: this.plate_check.vehicleNotes
                }));
            }, 2000);
        },
        setWepNoteSaveTimeout() {
            // save 2 seconds after done pressing keys
            if (this.lastTimeoutId) window.clearTimeout(this.lastTimeoutId);
            this.lastTimeoutId = window.setTimeout(() =>{
                // send value to server script for saving in mdt-person-check-notes db
                $.post("http://usa-mdt/saveWepNote", JSON.stringify({
                    serial: this.weapon_check.search_input,
                    value: this.weapon_check.weaponNotes
                }));
            }, 2000);
        }
    },
    computed: {
        filtered_warrants() {
            return this.warrants.filter(warrant => {
                var fullname = warrant.first_name + " " + warrant.last_name;
                if (fullname.toLowerCase().search(this.warrant_search.toLowerCase()) != -1)
                    return warrant
            })
        },
        filtered_bolos() {
            return this.bolos.filter(bolo => {
                if (
                    bolo.description.toLowerCase().search(this.bolo_search.toLowerCase()) != -1 ||
                    bolo.author.toLowerCase().search(this.bolo_search.toLowerCase()) != -1
                    )
                    return bolo;
            })
        },
        filtered_police_reports() {
            return this.police_reports.filter(report => {
                if (
                    report._id.toLowerCase().search(this.report_search.toLowerCase()) != -1 ||
                    report.timestamp.search(this.report_search) != -1 ||
                    report.location.toLowerCase().search(this.report_search.toLowerCase()) != -1 ||
                    report.author.toLowerCase().search(this.report_search.toLowerCase()) != -1
                    )
                    return report;
            })
        },
        GetProperBadge: function() {
            if (this.employee.job) {
                if (this.employee.job.rawName == "sheriff") {
                    return "sasp-badge.png"
                } else if (this.employee.job.rawName == "corrections") {
                    return "https://i.imgur.com/5eQsoOH.png"
                }
            }
        }
    },
    watch: {
        name_search: function(newVal, oldVal) {
            if (newVal.length > 1) {
                this.debouncedGetNameSearchResults(newVal)
            }
        }
    },
    created() {
        this.debouncedGetNameSearchResults = _.debounce(this.getNameSearchResults, 500);
    }
});

document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener('message', function(event) {
            if (event.data.type == "enable") {
                /* show / hide mdt */
                document.body.style.display = event.data.isVisible ? "block" : "none";
                /* get rank */
                if (event.data.isVisible) {
                    $.post('http://usa-mdt/fetchEmployee', JSON.stringify({}));
                }
            } else if (event.data.type == "personInfoLoaded") {
                /* fill person info data */
                if (!event.data.person_info.personNotes) {
                    event.data.person_info.personNotes = "";
                }
                mdtApp.person_check = event.data.person_info;
                /* hide error message */
                mdtApp.error = null;
                /* load MDT property address info */
                $.post('http://usa-mdt/getAddressInfo', JSON.stringify({
                    ssn: mdtApp.person_check.ssn,
                    fname: mdtApp.person_check.fname,
                    lname: mdtApp.person_check.lname
                }));
            } else if (event.data.type == "plateInfoLoaded") {
                /* fill plate info data */
                if (!event.data.plate_info.vehicleNotes) {
                    event.data.plate_info.vehicleNotes = "";
                }
                mdtApp.plate_check.registered_owner = event.data.plate_info.registered_owner;
                mdtApp.plate_check.veh_name = event.data.plate_info.veh_name;
                mdtApp.plate_check.plate = event.data.plate_info.plate;
                mdtApp.plate_check.flags = event.data.plate_info.flags;
                mdtApp.plate_check.vehicleNotes = event.data.plate_info.vehicleNotes;
                /* hide error message */
                mdtApp.error = null;
            } else if (event.data.type == "weaponInfoLoaded") {
                /* fill plate info data */
                if (!event.data.weapon_info.weaponNotes) {
                    event.data.weapon_info.weaponNotes = "";
                }
                mdtApp.weapon_check.weapon = event.data.weapon_info;
                mdtApp.weapon_check.weaponNotes = event.data.weapon_info.weaponNotes;
                /* hide error message */
                mdtApp.error = null;
            } else if (event.data.type == "warrantsLoaded") {
                mdtApp.warrants = event.data.warrants;
            } else if (event.data.type == "bolosLoaded") {
                mdtApp.bolos = event.data.bolos;
            } else if (event.data.type == "employeeLoaded") {
                mdtApp.employee = event.data.employee;
            } else if (event.data.type == "policeReportsLoaded") {
                mdtApp.police_reports = event.data.police_reports;
            } else if (event.data.type == "police_report_details_loaded") {
                mdtApp.error = "";
                mdtApp.current_report = event.data.report;
                mdtApp.current_tab = "Incident Detail";
            } else if (event.data.type == "warrantInfo") {
                /* warrant created successfully, fetch again to update list */
                $.post('http://usa-mdt/fetchWarrants', JSON.stringify({}));
            } else if (event.data.type == "bolo_created") {
                $.post('http://usa-mdt/fetchBOLOs', JSON.stringify({}));
            } else if (event.data.type == "police_report_created") {
                $.post('http://usa-mdt/fetchPoliceReports', JSON.stringify({}));
            } else if (event.data.type == "error") {
                /* display error message */
                mdtApp.error = event.data.message;
                /* clear fields */
                if  (mdtApp.current_tab == "Person(s) Check") {
                    mdtApp.person_check = {
                        _id: null,
                        ssn: null,
                        fname: null,
                        lname: null,
                        dob: null,
                        licenses: null,
                        insurance: null,
                        criminal_history: {
                            crimes: null,
                            tickets: null
                        },
                        mugshot: "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg",
                        personNotes: null
                    }
                } else if (mdtApp.current_tab == "Plate Check") {
                    mdtApp.plate_check = {
                        search_input: null,
                        registered_owner: null,
                        flags: null,
                        veh_name: null,
                        plate: null,
                        vehicleNotes: null
                    }
                } else if (mdtApp.current_tab == "Weapon Check") {
                    mdtApp.weapon_check = {
                        search_input: null,
                        weapon: null,
                        weaponNotes: null
                    }
                }
            } else if (event.data.type == "warrantDeleteFinish") {
                let uuid = event.data.uuid
                let msg = event.data.message
                let deleted = event.data.success
                if (deleted) {
                    let found = false
                    for (var index in mdtApp.warrants) {
                        if (uuid == mdtApp.warrants[index]._id) {
                            mdtApp.warrants.splice(index, 1)
                            mdtApp.notification = "Warrant deleted!"
                            found = true
                        }
                    }
                    if (!found)
                        mdtApp.error = "Error: did not find a matching warrant for that uuid!";
                } else {
                    mdtApp.error = "Insufficient permissions to delete warrants"
                }
                mdtApp.current_tab = "Warrants"
            } else if (event.data.type == "reportDeleteFinish") {
                let uuid = event.data.uuid
                let msg = event.data.message
                let deleted = event.data.success
                if (deleted) {
                    let found = false
                    for (var index in mdtApp.police_reports) {
                        if (uuid == mdtApp.police_reports[index]._id) {
                            mdtApp.police_reports.splice(index, 1)
                            mdtApp.notification = "Report deleted!"
                            found = true
                        }
                    }
                    if (!found)
                        mdtApp.error = "Error: did not find a matching warrant for that uuid!";
                } else {
                    mdtApp.error = "Insufficient permission to delete report."
                }
                mdtApp.current_tab = "Police Reports"
            } else if (event.data.type == "personCheckNotification") {
                mdtApp.personCheckNotifications.push(event.data.message)
            } else if (event.data.type == "addressInfoLoaded") {
                let s = "";
                for (let i = 0; i < event.data.info.length; i++) {
                    s += event.data.info[i].name;
                    if (i != event.data.info.length - 1) {
                        s += ", ";
                    }
                }
                mdtApp.person_check.address = s;
            } else if (event.data.type == "personSearchResultsLoaded") {
                mdtApp.searchedPersonResults = event.data.results
                mdtApp.isLoadingAsyncData = false;
            }
        });
    };
};

document.onkeydown = function (data) {
    if (data.which == 27 || data.which == 112) { // ESC or F1
        $.post('http://usa-mdt/close', JSON.stringify({}));
    }
};

function ClearActiveNavItem() {
    $("#plate_check").removeClass("nav-active");
    $("#weapon_check").removeClass("nav-active");
    $("#person_check").removeClass("nav-active");
    $("#warrants").removeClass("nav-active");
    $("#bolo").removeClass("nav-active");
    $("#reports").removeClass("nav-active");
}
