local addon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(addon)

local AdvancedMojo = Mojo.API


--------------------------------
--Provide a simple method for centralize multiple functions to Events

MojoEventDummy = CreateFrame("Frame","MojoEventDummy")
MojoEventDummy.Events = {}

--Iterate through all functions listening for the event
MojoEventDummy:SetScript("OnEvent", function(self, event, ...)
	for key,func in pairs(MojoEventDummy.Events[event]) do
		func(...)
	end
end)

AdvancedMojo["ListenDo"] = function(event,func)
	if not (MojoEventDummy.Events[event]) then
		MojoEventDummy.Events[event] = {}
		MojoEventDummy:RegisterEvent(event)
	end
	table.insert(MojoEventDummy.Events[event],func)
end
--------------------------------