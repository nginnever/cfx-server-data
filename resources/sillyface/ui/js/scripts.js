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
	function insertImgs(items) {
		//attach for each slot, each items.img
		$("#s0").attr("src", items[0].slot0+".png").css("display", "block")
		$("#s1").attr("src", items[0].slot1+".png").css("display", "block")
		$("#s2").attr("src", items[0].slot2+".png").css("display", "block")

		// for(i=0; i<items[0].length; i++){
		// 	console.log(items[0].slot1)
		// 	$("#s"+i).attr("src", items[0].slot+i+".png").css("display", "block")
		// }
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

		// hacky ass test
		if(item.invItems[0].slot0 !== undefined){
			console.log(item.invItems[0].slot1)
			// loop through the items, attach them to UI
			insertImgs(item.invItems)
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

	  // drop item slot
	  $("#slot3").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot3 now! meow")
	  		let itemName = ui.draggable.attr('src')
	  		console.log(itemName.substring(0, itemName.length - 4))
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  	// 	// put data on jquery.. using this for item stacking / type of item?
	  	// 	var slot = $("#slot3")[0];
	  	// 	jQuery.data(slot, "test", {
  		// 		first: 16,
  		// 		last: "pizza!"
				// });
				// //replacing image
				// $( "span" ).first().text( jQuery.data( slot, "test" ).last );

				//item: "P_BOXLRGMEAT01X"
	  		// drop item
	  		$('div#slot3 > img').remove()
	      $.post('http://sillyface/dropItem', JSON.stringify({
          item: itemName.substring(0, itemName.length - 4),
          toPlayer: null
	      }))
	  	}
		})

	});

	// character creation
})
