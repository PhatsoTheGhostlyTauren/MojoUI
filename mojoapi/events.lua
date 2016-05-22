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


--------------------------------
-- Provide a Way to schedule a task 1 Frame Generation after a Hook is being triggered
-- because sometimes the game manipulates the UI without using the proper Lua Channels, which causes regular Hooks to not work
-- Blame Semlar

MojoOneFrameLaterDummy = CreateFrame("Frame","MojoOneFrameLaterDummy")
MojoOneFrameLaterDummy:Hide()

--Provide Table of Procedures to store in
MojoOneFrameLaterDummy.Procedures = {}

--Selector for the OnUpdate procedure
MojoOneFrameLaterDummy.CurrentHook = {
	frame = nil,
	hook = nil
}
--When Shown hide again to only run the code once and do the job
MojoOneFrameLaterDummy:SetScript('OnUpdate', function(self)
	self:Hide()
	for key,func in pairs(MojoOneFrameLaterDummy.Procedures[MojoOneFrameLaterDummy.CurrentHook.frame][MojoOneFrameLaterDummy.CurrentHook.hook]) do
		func()
	end
end)

AdvancedMojo["DoOneFrameLater"] = function(_frame, _hook, _func)
	if not MojoOneFrameLaterDummy.Procedures[_frame] then MojoOneFrameLaterDummy.Procedures[_frame] = {} end
	if not MojoOneFrameLaterDummy.Procedures[_frame][_hook] then MojoOneFrameLaterDummy.Procedures[_frame][_hook] = {} end
	table.insert(MojoOneFrameLaterDummy.Procedures[_frame][_hook],_func)	

	hooksecurefunc(_frame,_hook,function(...)
		MojoOneFrameLaterDummy.CurrentHook = {
			frame = _frame,
			hook = _hook
		}
		MojoOneFrameLaterDummy:Show()
	end)
end
--------------------------------