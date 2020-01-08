RegisterCommand("helloworld", function()
	helloworld("natomata first script edits")
end, false)

function helloworld(data)
	TriggerEvent("chatMessage", "[Server]", {255,0,0}, data)
end