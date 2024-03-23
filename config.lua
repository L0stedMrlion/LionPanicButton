Config = {}

Config.Framework = "esx"

Config.Jobs = {
    "police",
    "sheriff",
} 

Config.BlipTime =  50
Config.Blipname = "Panic Button"


Config.SenderNotification = 'Needs immediate assistance!'
Config.NotAllowedNotification = 'Youre not allowed to use the panicbutton!'
Config.ShowNotification = false
Config.NotificationTitle = '10-99'
Config.NotificationText = ' Officer Triggered a Panic'
Config.NotificationTime = 30
-- Item 
Config.UseItem = false
Config.ItemName = 'panicbutton'
Config.ItemNotAllowed = "Item using disabled"

Config.Defaultkey = "0" 
Config.AllowKeyboardTrigger = true
Config.AllowCommand = true
Config.PanicCommand = 'panic'
Config.CommandNotAllowed = 'Command is disabled'
