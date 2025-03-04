Config = {}

Config.login = "vrpex" -- login de acesso
Config.senha = "123" -- senha de acesso

Config.Locale = 'br'


Config.voice = {

	levels = {
		default = 5.0,
		shout = 12.0,
		whisper = 1.0,
		current = 0
	}, 
	
	keys = {
		distance 	= 'HOME',
	}
}


Config.vehicle = {
	speedUnit = 'KMH',
	maxSpeed = 240,

	keys = {
		seatbelt 	= 'G',
		cruiser		= 'TOP',
		signalLeft	= 'LEFT',
		signalRight	= 'RIGHT',
		signalBoth	= 'DOWN',
	}
}

Config.ui = {

	showLocation 		= true,
	showVoice	 		= true,
	showWeapons			= true,
	
}


return Config