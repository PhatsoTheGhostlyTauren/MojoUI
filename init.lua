local addon, private = ...
local Mojo = LibStub("AceAddon-3.0"):NewAddon(addon)

_G["MojoUI"] = Mojo
Mojo.Settings = {}
Mojo.Config = {}
Mojo.API = {}
Mojo.Media = {}


-----------------------------------
-- Provide a centralized prototype for all Modules and Submodules and so forth
local prototype = {
	Settings = {},
	Config = {},
	Defaults = {}
}
function Mojo:GetPrototype()
	return prototype
end
-----------------------------------
function Mojo:OnEnable()
	for name, module in Mojo:IterateModules() do
		module:Mojoize()
	end
end