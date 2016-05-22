local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API
local MD = Mojo:GetModule("Databar")

local Clock = MD:NewModule("Clock")

Clock.Defaults = {
	primcolor = {1,1,1,0.75},
	seccolor = {1,1,1,0.25},
	hovercolor = {1,1,1,0.9},
	font = LSM:Fetch("font","Homizio"),
	fontSize = 12
}





function Clock:OnInitialize()
	self.Settings = self.Defaults
end


--Update the Clock everytime elapsed hits >1 and reset elapsed to 0 after = 1-Second Interval
local elapsed = 0

--Because #wowuidev said so
local str = string
str.format = string.format
local dat = date

function Clock:Update(e)
	elapsed = elapsed + e
	if elapsed >= 1 then		
		local hour, minu = GetGameTime()
		if minu < 10 then
			minu = ("0"..minu)
		end
		if( GetCVarBool("timeMgrUseLocalTime") ) then
			if( GetCVarBool("timeMgrUseMilitaryTime") ) then
				self.clockFrame.clockText:SetText(dat("%H:%M"))
				self.clockFrame.amText:SetText("")	
			else
				self.clockFrame.clockText:SetText(dat("%I:%M"))
				self.clockFrame.amText:SetText(dat("%p"))		
			end			
		else
			if ( GetCVarBool("timeMgrUseMilitaryTime") ) then
				self.clockFrame.clockText:SetText(hour..":"..minu)
				self.clockFrame.amText:SetText("")	
			else
				if hour > 12 then 
					hour = hour - 12
					hour = ("0"..hour)
					AmPmTimeText = "PM"
				else 
					AmPmTimeText = "AM"
				end
				self.clockFrame.clockText:SetText(hour..":"..minu)
				self.clockFrame.amText:SetText(AmPmTimeText)
			end	
		end
		if (CalendarGetNumPendingInvites() > 0) then
			self.clockFrame.calendarText:SetText(str.format("%s  (|cffffff00%i|r)", "New Event!", (CalendarGetNumPendingInvites())))
		else
			self.clockFrame.calendarText:SetText("")
		end
		elapsed = 0
	end
end

function Clock:CreateClockDatatext()
	self.clockFrame = MD:NewDatatext("Clock","CENTER",0)
	
	--Add ClockText
	self.clockFrame.clockText = self.clockFrame:CreateFontString("Mojo_Databar_ClockText", "MEDIUM")
	self.clockFrame.clockText:SetFont(self.Settings.font, MD.Databar:GetHeight()-4)
	self.clockFrame.clockText:SetTextColor(unpack(self.Settings.primcolor))
	self.clockFrame.clockText:SetText("00:00")
	--Make Datatext as Wide as the Clocktext + 40
	self.clockFrame:SetSize(self.clockFrame.clockText:GetStringWidth()+40,MD.Databar:GetHeight())
	
	--Add AM/PM Display
	self.clockFrame.amText = self.clockFrame:CreateFontString("Mojo_Databar_ClockTextAM", "MEDIUM")
	self.clockFrame.amText:SetFont(self.Settings.font, MD.Databar:GetHeight()-20)
	self.clockFrame.amText:SetTextColor(unpack(self.Settings.seccolor))
	
	--Add a NewEvent! display
	self.clockFrame.calendarText = self.clockFrame:CreateFontString("Mojo_Databar_Clock_NewEvents", "MEDIUM")
	self.clockFrame.calendarText:SetFont(self.Settings.font,  MD.Databar:GetHeight()-10)
	self.clockFrame.calendarText:SetTextColor(unpack(self.Settings.seccolor))
	
	
	--Position all Elements
	self.clockFrame.clockText:SetPoint("CENTER",self.clockFrame,"CENTER")
	self.clockFrame.amText:SetPoint("BOTTOMLEFT",self.clockFrame.clockText,"RIGHT",0,-2)
	self.clockFrame.calendarText:SetPoint("CENTER",self.clockFrame, "TOP")
	
	--Show the Frame and make it Update itself
	self.clockFrame:Show()
	self.clockFrame:SetScript("OnUpdate", function(object,e)
		self:Update(e)
	end)
end


function Clock:MakeInteractive()

	self.clockFrame:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		
		self.clockFrame.clockText:SetTextColor(unpack(self.Settings.hovercolor))
		hour, minu = GetGameTime()
		if minu < 10 then
			minu = ("0"..minu)
		end
		
		MD.Tooltip:SetOwner(self.clockFrame,"ANCHOR_TOP",0,10)
		
		--Tip Title Line
		MD.Tooltip:AddLine("[|cff6699FFClock|r]")
		MD.Tooltip:AddLine(" ")
		
		--Local or Realm Time Display
		if ( GetCVarBool("timeMgrUseLocalTime") ) then
			MD.Tooltip:AddDoubleLine("Realm Time", hour..":"..minu, 1, 1, 0, 1, 1, 1)
		else
			MD.Tooltip:AddDoubleLine("Local Time", date("%H:%M"), 1, 1, 0, 1, 1, 1)
		end
		--Interactibilizy
		MD.Tooltip:AddLine(" ")
		MD.Tooltip:AddDoubleLine("<Left-click>", "Open Calendar", 1, 1, 0, 1, 1, 1)
		MD.Tooltip:AddDoubleLine("<Right-click>", "Open Clock", 1, 1, 0, 1, 1, 1)
		
		--Fire the Display of the Tooltip
		MD.Tooltip:Show()

	end)

	self.clockFrame:SetScript("OnLeave", function()
		if ( MD.Tooltip:IsShown() ) then
			MD.Tooltip:Hide()
		end
		self.clockFrame.clockText:SetTextColor(unpack(self.Settings.primcolor))
	end)

	self.clockFrame:SetScript("OnMouseDown", function(self, button)
		if InCombatLockdown() then return end
		if button == "LeftButton" then
			ToggleCalendar()
		elseif button == "RightButton" then 
			ToggleTimeManager()
		end
	end)
end



function Clock:Mojoize()
	self:CreateClockDatatext()
	self:MakeInteractive()
end