local addon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(addon)


--The Contents of the following table are loaded as defaults
local D = {}


D["Layout"] = {
	["BlankTex"] = "Interface/AddOns/MojoUI/media/textures/blank",
	["BGColor"] = {24/255,24/255,29/255,.45},
	["AltBGColor"] = {24/255,24/255,29/255,.65},
	["DefaultFont"] = "Homizio"
}





Mojo.Settings = D