fx_version 'adamant'
games { 'gta5', 'rdr3' }

ui_page 'html/inventory_ui.html'

files {
	'html/inventory_ui.html',
	'html/054.png',
	'css/styles.css',
	'js/scripts.js'
}

client_script {
	"config.lua",
	"guns.lua",
	"functions.lua",
	"noclip.lua"
}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'