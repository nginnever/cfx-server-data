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
		console.log('weeee ' + "imgs/"+items[0].slot5+".png")
		$("#s0").attr("src", "imgs/"+items[0].slot0+".png").css("display", "block")
		$("#s1").attr("src", "imgs/"+items[0].slot1+".png").css("display", "block")
		$("#s2").attr("src", "imgs/"+items[0].slot2+".png").css("display", "block")
		$("#s3").attr("src", "imgs/"+items[0].slot3+".png").css("display", "block")
		$("#s4").attr("src", "imgs/"+items[0].slot4+".png").css("display", "block")
		$("#s5").attr("src", "imgs/"+items[0].slot5+".png").css("display", "block")
		// for(i=0; i<items[0].length; i++){
		// 	console.log(items[0].slot1)
		// 	$("#s"+i).attr("src", items[0].slot+i+".png").css("display", "block")
		// }
	}
	function giveItem(item) {
		console.log("in give item "+"imgs/"+item+".png")
		let droppedSlot
		for(var i=4; i<16; i++){
			var check = "#s"+i
			console.log(check)
			console.log($(check).attr("src"))
			if($(check).attr("src") == undefined || $(check).attr("src") == "") {
				if($("#s"+i).attr('src') == "") {
					$("div#slot"+i+" > img").remove()
				}
				$("#slot"+i).append('<img id="s'+i+'" class="inv-img draggable ui-draggable" src="">')
				$("#s"+i).attr("src", "imgs/"+item+".png").css("display", "block")
				$("#s"+i).draggable()
				droppedSlot = i
				break
			}
		}
    $.post('http://sillyface/updatePickupSlot', JSON.stringify({
      slot: "slot"+droppedSlot,
      item: item
    }))
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
    if(item.giveItem !== undefined){
    	console.log("give item wee "+item.giveItem)
      giveItem(item.giveItem)
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
	  $(".draggable").draggable({
	  	//helper: 'original',
	  	revert: "invalid"
	  });

	  $("#slot0").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot0 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// var imgsrc = ui.draggable.attr('src')
	  		// $("#s0").attr("src", imgsrc).css("display", "block")
	  		// $(dropped).attr("src", "")
	  	}
		})

	  $("#slot1").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot1 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  	// 	var imgsrc = ui.draggable.attr('src')
	  	// 	console.log(imgsrc)
				// console.log($(dropped).attr("id"))
	  	// 	console.log($("#s1").attr('src'))
	  	// 	console.log($("#s1").css('display'))
	  	// 	sd.appendTo("#slot1")
	  	// 	//$("#slot1").append('<img id="s1" class="inv-img draggable ui-draggable" src="">')
	  	// 	//$("#s1").css("display", "none")
	  	// 	//$("#s1").addClass("draggable")
	  	// 	$("#s1").attr("src", imgsrc).css("display", "block")
	  	// 	$(dropped).attr("src", "")
	  	// 	$(dropped).detach().removeAttr("style");

	  	// 	console.log($("#s1").css('position'))
	  	// 	console.log($("#s1").css('display'))
	  	// 	console.log($("#s1").css('draggable'))
	  	// 	console.log($("#s1").attr("class"))
	  		// Give weapon
	      $.post('http://sillyface/giveWeapon', JSON.stringify({
          weapon: "WEAPON_PISTOL_M1899",
          toPlayer: null
	      }))
	  	}
		})

	  var sd
	  $("#slot2").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot2 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// var imgsrc = ui.draggable.attr('src')
	  		// $(this).append($("ui.helper").clone())
	  		// // console.log($(dropped).attr("id"))
	  		// // $("#s2").attr("src", imgsrc).css("display", "block")
	  		// // $(dropped).attr("src", "")
	  		// // sd = $(dropped).detach().removeAttr('style')
	  		// // Give weapon
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
	  		itemName = itemName.substring(5, itemName.length - 4)
	  		console.log(itemName)
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		console.log(dropped)
	  		slot = $(dropped).attr("id")
	  		slot = "slot"+slot.substring(1, slot.length)
	  		//$(dropped).attr("src", "").css("display", "none")
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
	  		console.log(lookupItem[itemName])
	  		if(lookupItem[itemName] == "weapon") {
		      $.post('http://sillyface/dropWeapon', JSON.stringify({
	          item: itemName,
	          slot: slot,
	          toPlayer: null
		      }))
	  		}
	  		if(lookupItem[itemName] == "item") {
		      $.post('http://sillyface/dropItem', JSON.stringify({
	          item: itemName,
	          slot: slot,
	          toPlayer: null
		      }))
	    	}
	  	}
		})

	  // non-equip slots
	  $("#slot4").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot4 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// todo hit db for every inventory swap?
	  	}
		})

	  $("#slot5").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot5 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn)
	  		// var imgsrc = ui.draggable.attr('src')
	  		// console.log($(dropped).attr("id"))
	  		// $("#s5").attr("src", imgsrc).css("display", "block")
	  		// $(dropped).attr("src", "")
	  	}
		})

	});

	// character creation
})

let lookupItem = {
	//weapons list
	"WEAPON_PISTOL_M1899":"weapon",
	//items list
	"P_BOXLRGMEAT01X":"item"
}