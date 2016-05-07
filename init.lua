local addon, private = ...
local Mojo = LibStub("AceAddon-3.0"):NewAddon(addon)

_G["MojoUI"] = Mojo
Mojo.Settings = {}
Mojo.API = {}

function Mojo:OnInitialize()
	for name, module in Mojo:IterateModules() do
		module:Mojoize()
	end
end