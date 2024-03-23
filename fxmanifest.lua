fx_version 'cerulean'
games  { 'gta5' }
author 'Mrlion'
description "Lion's Panic button"
version '1.0'
lua54 'yes'

shared_scripts {
    'config.lua',
    "@ox_lib/init.lua",
    "@es_extended/imports.lua"
}

client_scripts {
    'client/client.lua'
}

ui_page "html/index.html"

files {
	"html/index.html",
	"html/sounds/externalpanic1.ogg",
    "html/sounds/localpanic.ogg",
}
