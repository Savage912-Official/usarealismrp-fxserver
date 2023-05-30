var characterSelectionApp = new Vue({
  el: "#app",
  created() {
    window.addEventListener('keydown', (e) => {
      if (e.key == "ArrowLeft") {
        this.selectLeft()
      } else if (e.key == "ArrowRight") {
        this.selectRight()
      } else if (e.key == "Enter") {
        if (this.page == "list") {
          if (this.selectedCharIndex == this.characters.length) {
            this.page = "create" // new char
          } else {
            this.goToSpawnPage() // select a char
          }
        } else if (this.page == "spawn") {
          if (this.selectedSpawn && this.selectedCharacter) {
            this.spawnCharacter()
          }
        } else if (this.page == "create") {
          this.createCharacter()
        }
      } else if (e.key == "Backspace") {
        if (this.page == "spawn") {
          this.page = "list"
        }
      }
    });
  },
  data: {
		page: "list",
		characters: [],
		notification: {
			msg: "You don't appear to have any characters! Create one!",
			show: false
		},
    selectedCharacter: null,
    selectedCharIndex: null,
    selectedSpawn: "Paleto Bay"
  },
  methods: {
    createCharacter: function() {
      /* Get data from input form fields */
      var first_name = $('#first_name').val();
      var middle_name = $('#middle_name').val();
      var last_name = $('#last_name').val();
      var dob = $("#date_of_birth").val();

      /* Get date object for validation */
      var dobAsDate = new Date(dob);
      day = dobAsDate.getDate();
      month = dobAsDate.getMonth() + 1;
      year = dobAsDate.getFullYear();

      if (first_name.length > 2 && last_name.length > 2 && (year > 1900 || year < 2020 || !isNaN(day) || !isNaN(month) || !isNaN(year))) {
        var newCharData = {
          name: {
            first: first_name,
            middle: middle_name,
            last: last_name
          },
          dateOfBirth: dob
        }
        $.post('http://character-selection/new-character-submit', JSON.stringify(newCharData));
        /* Go back to list of chars */
        this.page = "list";
        this.notification.show = false;
      } else {
        this.notification.show = true;
        this.notification.msg = "Uh-oh! You didn't supply enough information! Please try again.";
      }
    },
    deleteCharacter: function() {
      if (this.selectedCharacter != null) {
        const modal = document.getElementById('confirm');
				const deleteName = document.getElementById('confirm_name');
        const deleteChar = document.getElementById('confirm_delete');
        const cancelChar = document.getElementById('confirm_cancel');

				modal.show();

				var char = this.selectedCharacter;
				deleteName.innerText = char.name.first + " " + char.name.last;

      } else {
        console.log("No selected character");
      }
    },
    confirmDelete: function() {
      const modal = document.getElementById('confirm');
      var char = this.selectedCharacter;
      $.post('http://character-selection/delete-character', JSON.stringify({
        id: char.id,
        rev: char.rev,
        createdTime: char.created.time
      }));
      modal.close();
      this.selectedCharacter = null;
    },
    cancelDelete: function() {
      const modal = document.getElementById('confirm');
      modal.close();
    },
    disconnect: function() {
      $.post('http://character-selection/disconnect', JSON.stringify({}));
    },
    selectCharacter: function(charIndex) {
      this.selectedCharIndex = charIndex;
      if (this.selectedCharIndex != this.characters.length) {
        this.selectedCharacter = this.characters[charIndex];
        var selectedChar = this.selectedCharacter;
        $('.character').each(function () {
          var char = $(this);
          if (char.attr("data-id") == selectedChar.id) {
            char[0].scrollIntoView(false)
          }
        });
      } else {
        $("#new")[0].scrollIntoView(false)
      }
    },
    selectSpawn: function(spawn) {
      this.selectedSpawn = spawn;
    },
    spawnCharacter: function() {
      if (!this.selectedCharacter || !this.selectedSpawn)
        return;
      $.post('http://character-selection/select-character', JSON.stringify({
        id: this.selectedCharacter.id,
        name: this.selectedCharacter.name,
        spawn: this.selectedSpawn,
        charSavedSpawn: this.selectedCharacter.spawn,
        charLastLocation: this.selectedCharacter.lastRecordedLocation
      }));
      this.page = "list"
      this.selectedCharacter = null
      this.selectedCharIndex = 0
      this.selectedSpawn = "Paleto Bay"
    },
    selectRight: function() {
      if (this.page == "list") {
        this.selectedCharIndex += 1
        if (this.selectedCharIndex >= this.characters.length + 1)
          this.selectedCharIndex = 0 // to beginning of list
        this.selectCharacter(this.selectedCharIndex)
      } else if (this.page == "spawn") {
        let next = getNextSpawn(this.selectedSpawn, this.selectedCharacter.lastRecordedLocation, this.selectedCharacter.spawn)
        this.selectSpawn(next)
      }
    },
    selectLeft: function() {
      if (this.page == "list") {
        this.selectedCharIndex -= 1
        if (this.selectedCharIndex < 0) {
          this.selectedCharIndex = this.characters.length // to new char button
          $("#new")[0].scrollIntoView(false)
        }
        this.selectCharacter(this.selectedCharIndex)
      } else if (this.page == "spawn") {
        let prev = getPreviousSpawn(this.selectedSpawn, this.selectedCharacter.lastRecordedLocation, this.selectedCharacter.spawn)
        this.selectSpawn(prev)
      }
    },
    isSpawnCurrentlySelected(spawn) {
      if (this.selectedSpawn == spawn)
        return true
      else
        return false
    },
    goToSpawnPage() {
      if (this.selectedCharacter) {
        $.post('http://character-selection/getCharLastLocation', JSON.stringify({
          id: this.selectedCharacter.id
        }));
      }
      this.page = 'spawn';
    }
  },
  computed: {
		showNotification: function() {
      if (this.characters) {
        if (this.characters.length == 0) {
  				return true;
  			} else {
  				return this.notification.show;
  			}
      }
    },
    selectButtonText() {
      if (this.selectedCharIndex == this.characters.length)
        return "Create Character"
      else
        return "Select Character"
    }
  },
  filters: {
    displayMoney: function(value) {
      return value.formatMoney(2, '.', ',');
    }
  }
})

document.onreadystatechange = () => {
  if (document.readyState === "complete") {
    /* Listen for events from lua script */
    window.addEventListener('message', function(event) {
      var eventType = event.data.type;
      if (eventType == "toggleMenu") {
        if (event.data.open == true){
          characterSelectionApp.characters = event.data.characters;
          if (event.data.characters.length > 0) {
            characterSelectionApp.selectedCharacter = event.data.characters[0]
            characterSelectionApp.selectedCharIndex = 0
          }
          document.body.style.display = "flex";
        }
        else
          document.body.style.display = "none";
      } else if (eventType == "displayGUI") {
        document.body.style.display = event.data.open = "flex";
        $(".characters").scrollLeft(0)
      } else if (eventType == "gotCharLastLocation") {
        characterSelectionApp.selectedCharacter.lastRecordedLocation = event.data.coords;
        characterSelectionApp.$forceUpdate();
      }
    });
  };
};

function confirmDelete() {
  characterSelectionApp.confirmDelete();
}

function cancelDelete() {
  characterSelectionApp.cancelDelete();
}

function getPreviousSpawn(current, lastSavedLocation = null, propertySpawn = null) {
  switch (current) {
    case "Paleto Bay": {
      if (propertySpawn)
        return "Property"
      else if (lastSavedLocation)
        return "Last Location"
      else
        return "Los Santos"
    }
    case "Sandy Shores":
      return "Paleto Bay"
    case "Los Santos":
      return "Sandy Shores"
    case "Last Location":
      return "Los Santos"
    case "Property": {
      if (lastSavedLocation)
        return "Last Location"
      else
        return "Los Santos"
    }
  }
}

function getNextSpawn(current, lastSavedLocation = null, propertySpawn = null) {
  switch (current) {
    case "Paleto Bay":
      return "Sandy Shores"
    case "Sandy Shores":
      return "Los Santos"
    case "Los Santos": {
      if (lastSavedLocation)
        return "Last Location"
      else if (propertySpawn)
        return "Property"
      else
        return "Paleto Bay"
    }
    case "Last Location": {
      if (propertySpawn)
        return "Property"
      else
        return "Paleto Bay"
    }
    case "Property":
      return "Paleto Bay"
  }
}

Number.prototype.formatMoney = function (c, d, t) {
	var n = this,
		c = isNaN(c = Math.abs(c)) ? 2 : c,
		d = d == undefined ? "." : d,
		t = t == undefined ? "," : t,
		s = n < 0 ? "-" : "",
		i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
		j = (j = i.length) > 3 ? j % 3 : 0;
	return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};
