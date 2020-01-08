$(document).ready(function(){
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
  }
  function openContainer() {
    $(".inv-container").css("display", "block");
  }
  function closeContainer() {
    $(".inv-container").css("display", "none");
  }
	// Listen for NUI Events
	window.addEventListener('message', function(event){
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
	})

  // On 'Esc' or 'i' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 || data.which == 73 ) {
      $.post('http://sillyface/close', JSON.stringify({}));
    }
  };

	// jquery
	$(function() {
	  $(".draggable").draggable({revert: "invalid"});
	  $("#slot0").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot0 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn);
	  	}
		})
	  $("#slot1").droppable({ accept: ".draggable",
	  	drop: function(event, ui) {
	  		console.log("dropping into slot1 now! meow")
	  		var dropped = ui.draggable
	  		var droppedOn = $(this)
	  		$(dropped).detach().css({top: 0,left: 0}).appendTo(droppedOn);
	  	}
		})
	});
})
