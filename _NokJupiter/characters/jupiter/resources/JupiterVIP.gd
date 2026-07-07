extends Resource

export (SpriteFrames) var skin_sprites
export (SpriteFrames) var skin_fx

export (Dictionary) var oracle_colors

var host
var skin_enabled = true
var skin = null

#	------------------------------------------------------------------------------------------------
var skins = {
	"Oracle": "Essence of the Oracle",
}

var VIPs = {
	"nok": [["Oracle"], "The Forever Documentation"],
}

#	------------------------------------------------------------------------------------------------
