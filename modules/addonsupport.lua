local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API

local AS = Mojo:NewModule("AddonSupport",Mojo:GetPrototype())

function AS:Mojoize()
	AdvancedMojo.ListenDo("ADDON_LOADED",function(addonname)
		local AddonS = AS:GetModule(addonname,true)
		if AddonS ~= nil then
			if AddonS:IsEnabled() then
				AddonS:Support()
			end
		end
	end)
end