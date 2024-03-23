fx_version 'cerulean'
games  'gta5'
name "lion_panic"
author 'Mrlion'
description "Lion's Panic button for LEO, EMS and more!"
version '1.0'
lua54 'yes'

shared_scripts {
    'config.lua',
    "@ox_lib/init.lua",
    "@es_extended/imports.lua"
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
}

files {
	"html/index.html",
	"html/sounds/*.ogg",
}
