local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")

if LSM == nil then return end
---------------------------------------------
-- Fonts
---------------------------------------------
LSM:Register("font","Homizio", [[Interface\AddOns\MojoUI\media\fonts\regular.ttf]])
LSM:Register("font","Homizio Black", [[Interface\AddOns\MojoUI\media\fonts\black.ttf]])
LSM:Register("font","Homizio Bold", [[Interface\AddOns\MojoUI\media\fonts\bold.ttf]])
LSM:Register("font","Homizio Light", [[Interface\AddOns\MojoUI\media\fonts\light.ttf]])
LSM:Register("font","Homizio Medium", [[Interface\AddOns\MojoUI\media\fonts\medium.ttf]])
LSM:Register("font","Homizio Thin", [[Interface\AddOns\MojoUI\media\fonts\thin.ttf]])

---------------------------------------------
-- Textures
---------------------------------------------

local TextureFolder = "Interface\\AddOns\\MojoUI\\Media\\Textures\\"


Mojo.Media.Textures = {
	Misc = {
		TRIANGLE = TextureFolder.."triangle.blp",	
	},
	Datatexts = {
		EXP = TextureFolder.."datatexts\\exp.tga",
		FPS = TextureFolder.."datatexts\\fps.tga",
		GARR = TextureFolder.."datatexts\\garr.tga",
		GARRES = TextureFolder.."datatexts\\garres.tga",
		GOLD = TextureFolder.."datatexts\\gold.tga",
		HEARTH = TextureFolder.."datatexts\\hearth.tga",
		HONOR = TextureFolder.."datatexts\\honor.tga",
		PING = TextureFolder.."datatexts\\ping.tga",
		REPAIR = TextureFolder.."datatexts\\repair.tga",
		REROLL = TextureFolder.."datatexts\\reroll.tga",
		SEAL = TextureFolder.."datatexts\\seal.tga",
		SHIPCOMP = TextureFolder.."datatexts\\shipcomp.tga"		
	},
	Microbar = {
		ACH = TextureFolder.."microbar\\ach.tga",	
		CHAR = TextureFolder.."microbar\\char.tga",	
		CHAT = TextureFolder.."microbar\\chat.tga",	
		GUILD = TextureFolder.."microbar\\guild.tga",	
		HELP = TextureFolder.."microbar\\help.tga",	
		JOURNAL = TextureFolder.."microbar\\journal.tga",	
		LFG = TextureFolder.."microbar\\lfg.tga",	
		MENU = TextureFolder.."microbar\\menu.tga",	
		PET = TextureFolder.."microbar\\pet.tga",	
		PVP = TextureFolder.."microbar\\pvp.tga",	
		QUEST = TextureFolder.."microbar\\quest.tga",	
		SHOP = TextureFolder.."microbar\\shop.tga",	
		SOCIAL = TextureFolder.."microbar\\social.tga",	
		SPELL = TextureFolder.."microbar\\spell.tga",	
		TALENT = TextureFolder.."microbar\\talent.tga",	
	},
	Professions = {
		ALCH = TextureFolder.."profession\\alchemy.tga",	
		SMITH = TextureFolder.."profession\\blacksmithing.tga",	
		ENCHANT = TextureFolder.."profession\\enchanting.tga",	
		ENGI = TextureFolder.."profession\\engineering.tga",	
		HERB = TextureFolder.."profession\\herbalism.tga",	
		SCRIBE = TextureFolder.."profession\\inscription.tga",	
		JEWEL = TextureFolder.."profession\\jewelcrafting.tga",	
		LEATHER = TextureFolder.."profession\\leatherworking.tga",	
		MINING = TextureFolder.."profession\\mining.tga",	
		SKINNING = TextureFolder.."profession\\skinning.tga",	
		TAILOR = TextureFolder.."profession\\tailoring.tga",	
	},
	Specs = {
		DEATHKNIGHT = TextureFolder.."profession\\DEATHKNIGHT.tga",
		DRUID = TextureFolder.."profession\\DRUID.tga",
		HUNTER = TextureFolder.."profession\\HUNTER.tga",
		MAGE = TextureFolder.."profession\\MAGE.tga",
		MONK = TextureFolder.."profession\\MONK.tga",
		PALADIN = TextureFolder.."profession\\PALADIN.tga",
		PRIEST = TextureFolder.."profession\\PRIEST.tga",
		ROGUE = TextureFolder.."profession\\ROGUE.tga",
		SHAMAN = TextureFolder.."profession\\SHAMAN.tga",
		WARLOCK = TextureFolder.."profession\\WARLOCK.tga",
		WARRIOR = TextureFolder.."profession\\WARRIOR.tga"
	}
}