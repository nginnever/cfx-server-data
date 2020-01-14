fx_version 'adamant'
games { 'gta5', 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

dependency 'basic-gamemode'

ui_page 'ui/html/ui.html'

files {
	'ui/html/ui.html',
	'ui/html/054.png',
	'ui/css/inventorystyle.css',
	'ui/js/scripts.js',
	--character ui files
	'ui/bg.png',
	'ui/crock.ttf',
	'ui/css/characterstyle.css',
	'ui/jquery-func.js',
	'ui/jquery.jcarousel.pack.js',
	'ui/listener.js'
}

client_script {
	"config.lua",
	"client.lua",
	"functions.lua",
	"noclip.lua"
}

server_scripts {
	"server.lua",
	"@mysql-async/lib/MySQL.lua"
}
