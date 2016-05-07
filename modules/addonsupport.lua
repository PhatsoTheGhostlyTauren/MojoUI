local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API

local AS = Mojo:NewModule("AddonSupport")


--This is the Prototype Structure that all Support Modules inherit
local prototype = {
	Profiles = {},
	Config = {},
	Defaults = {}
}

--Returns the default prototype for AddonSupport Modules
function AS:GetPrototype()
	return self.prototype
end


function AS:Mojoize()
	for name, module in AS:IterateModules() do
		module:Support()
	end
end