$(document).ready(function(){
	// inventory functions
	function closeMain() {
		$(".home").css("display", "none")
	}
	function openMain() {
		$(".home").css("display", "block")
	}
	function closeAll() {
		$(".body").css("display", "none")
	}
	function openContainer() {
		$(".inv-container").css("display", "block")
	}
	function closeContainer() {
		$(".inv-container").css("display", "none")
	}

	// character creation function
	function openCreator() {
		console.log("opening creator weee")
		$(".creator").css("visibility", "visible")
	}
	function closeCreator() {
		$(".creator").css("visibility", "hidden")
	}

	// Listen for NUI Events
	window.addEventListener('message', function(event){
		console.log('testsetest')
		var item = event.data
	  // Open & Close main inventory window
	  if(item.openInv == true) {
	    openContainer()
	    //openMain()
	  }
	  if(item.openInv == false) {
	  	console.log("weeeeeeeeee")
	    closeContainer()
	    //closeMain()
	  }
	  // character creation listener
	  if(item.openChar == true) {
	  	console.log("opening creator weee!!!!")
	  	openCreator()
	  }
	  if(item.openChar == false) {
	  	closeCreator()
	  }
    if(item.type == 1){
      loadCharacters(item.list)
      //console.log(event.data.list)
		}
	})

	// On 'Esc' or 'i' call close method
	document.onkeyup = function (data) {
		// if (data.which == 73 ) {
		//   $.post('http://sillyface/closeInv', JSON.stringify({}))
		// }
		if (data.which == 27 ) {
			$.post('http://sillyface/closeInv', JSON.stringify({}))
		  $.post('http://sillyface/closeChar', JSON.stringify({}))
		}
	}

	// inventory slots
	$(function() {
	  $(".draggable").draggable({revert: "invalid"});

	  $("#slot0").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot0 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  	}
		})

	  $("#slot1").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot1 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// Give weapon
	      $.post('http://sillyface/giveWeapon', JSON.stringify({
          weapon: "WEAPON_PISTOL_M1899",
          toPlayer: null
	      }))
	  	}
		})

	  $("#slot2").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot2 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// Give weapon
	      $.post('http://sillyface/giveWeapon', JSON.stringify({
          weapon: "WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC",
          toPlayer: null
	      }))
	  	}
		})

	  $("#slot3").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot3 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// drop item
	      $.post('http://sillyface/dropItem', JSON.stringify({
          item: "P_BOXLRGMEAT01X",
          toPlayer: null
	      }))
	  	}
		})

	});

	// character creation
})
