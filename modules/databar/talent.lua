MD.Settings.specCoords = {
--	 index	 left	right	top		bottom
	[ 1] = { 0.00,	0.25,	0.00,	1 },
	[ 2] = { 0.25,	0.50,	0.00,	1 },
	[ 3] = { 0.50,	0.75,	0.00,	1 },
	[ 4] = { 0.75,	1.00,	0.00,	1 },
}

return


local addon, ns = ...
local cfg = ns.cfg
local unpack = unpack
--------------------------------------------------------------
if not cfg.talent.show then return end

local currentSpec = 0 -- from 1-4
local currentSpecID, currentSpecName = 0,0 --global id
local lootspecid = 0
local id, name = 0,0

local talentFrame = CreateFrame("Frame",nil, cfg.SXframe)
talentFrame:SetPoint("RIGHT", cfg.SXframe, "CENTER", -110,0)
talentFrame:SetSize(16, 16)
---------------------------------------------
-- LOOTSPEC FRAME
---------------------------------------------
local lootSpecFrame = CreateFrame("BUTTON",nil, talentFrame)
if cfg.core.position ~= "BOTTOM" then
	lootSpecFrame:SetPoint("TOP", talentFrame, "BOTTOM", 0,-8)
else
	lootSpecFrame:SetPoint("BOTTOM", talentFrame, "TOP", 0,8)
end
lootSpecFrame:RegisterForClicks("AnyUp")
lootSpecFrame:Hide()
lootSpecFrame:EnableMouse(true)

lootSpecFrame:SetScript("OnClick", function(self, button, down)
	if InCombatLockdown() then return end
	if button == "RightButton" then
		lootSpecFrame:Hide()
	end
end)

local lootSpecText = lootSpecFrame:CreateFontString(nil, "OVERLAY")
lootSpecText:SetFont(cfg.text.font, cfg.text.normalFontSize)
lootSpecText:SetPoint("TOP")
lootSpecText:SetText("LOOT SPECIALIZATION")
lootSpecText:SetTextColor(unpack(cfg.color.normal))

local defaultLootTypeButton = CreateFrame("BUTTON",nil, lootSpecFrame)
defaultLootTypeButton:SetSize(lootSpecText:GetStringWidth(),cfg.text.normalFontSize)
defaultLootTypeButton:SetPoint("CENTER",lootSpecText)
defaultLootTypeButton:EnableMouse(true)
defaultLootTypeButton:RegisterForClicks("AnyUp")

defaultLootTypeButton:SetScript("OnClick", function(self, button, down)
	if InCombatLockdown() then return end
	if button == "LeftButton" then
		if GetLootSpecialization() ~= 0 then
			SetLootSpecialization(0)
			print("|cffffff00Loot Specialization set to: Current Specialization")
			lootSpecFrame:Hide()
		end
	elseif button == "RightButton" then
		lootSpecFrame:Hide()
	end
end)

local lootSpectBG = lootSpecFrame:CreateTexture(nil,"OVERLAY",nil,7)
lootSpectBG:SetPoint("TOP")
lootSpectBG:SetTexture(unpack(cfg.color.barcolor))
globalLootSpecFrame = lootSpecFrame

---------------------------------------------
-- PRIMARY SPEC FRAME
---------------------------------------------

local primarySpecFrame = CreateFrame("BUTTON",nil, talentFrame)
primarySpecFrame:SetPoint("RIGHT")
primarySpecFrame:SetSize(16, 16)
primarySpecFrame:EnableMouse(true)
primarySpecFrame:RegisterForClicks("AnyUp")

local primarySpecText = primarySpecFrame:CreateFontString(nil, "OVERLAY")
primarySpecText:SetFont(cfg.text.font, cfg.text.normalFontSize)
primarySpecText:SetPoint("RIGHT")
primarySpecText:SetTextColor(unpack(cfg.color.normal))

local primarySpecIcon = primarySpecFrame:CreateTexture(nil,"OVERLAY",nil,7)
primarySpecIcon:SetSize(16, 16)
primarySpecIcon:SetPoint("RIGHT", primarySpecText,"LEFT",-2,0)
primarySpecIcon:SetVertexColor(unpack(cfg.color.normal))

primarySpecFrame:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	GameTooltip:SetOwner(talentFrame, cfg.tooltipPos)
	currentSpec = GetSpecialization()
	currentSpecID, currentSpecName = GetSpecializationInfo(currentSpec)
	lootspecid = GetLootSpecialization()
	if lootspecid == 0 then lootspecid = currentSpecID end
	id, name = GetSpecializationInfoByID(lootspecid)	
	if currentSpecID ~= id then
		GameTooltip:AddLine("|cffffffffLoot is currently set to |cffffff00"..name.."|cffffffff spec")
		GameTooltip:AddDoubleLine("<Right-Click>", "Change lootspec", 1, 1, 0, 1, 1, 1)
	end
	primarySpecIcon:SetVertexColor(unpack(cfg.color.hover))
	GameTooltip:Show()
end)

primarySpecFrame:SetScript("OnLeave", function() 
	if GetActiveSpecGroup() == 1 then
		primarySpecIcon:SetVertexColor(unpack(cfg.color.normal))
	else
		primarySpecIcon:SetVertexColor(unpack(cfg.color.inactive))
	end
	if ( GameTooltip:IsShown() ) then GameTooltip:Hide() end
end)

primarySpecFrame:SetScript("OnClick", function(self, button, down)
	if InCombatLockdown() then return end
	if button == "LeftButton" then
		if GetNumSpecGroups() < 2 then
			return
		end
		if GetActiveSpecGroup() == 1 then
			SetActiveSpecGroup(2)
		elseif GetActiveSpecGroup() == 2 then
			SetActiveSpecGroup(1)
		end
	elseif button == "RightButton" then 
		if globalLootSpecFrame:IsShown() then
			globalLootSpecFrame:Hide()
		else
			globalLootSpecFrame:Show()
		end
	end
end)
---------------------------------------------------------------------

local secondarySpecFrame = CreateFrame("BUTTON",nil, talentFrame)
secondarySpecFrame:SetPoint("LEFT")
secondarySpecFrame:SetSize(16, 16)
secondarySpecFrame:EnableMouse(true)
secondarySpecFrame:RegisterForClicks("AnyUp")

local secondarySpecIcon = secondarySpecFrame:CreateTexture(nil,"OVERLAY",nil,7)
secondarySpecIcon:SetSize(16, 16)
secondarySpecIcon:SetPoint("LEFT")
secondarySpecIcon:SetVertexColor(unpack(cfg.color.normal))

local secondarySpecText = secondarySpecFrame:CreateFontString(nil, "OVERLAY")
secondarySpecText:SetFont(cfg.text.font, cfg.text.normalFontSize)
secondarySpecText:SetPoint("LEFT", secondarySpecIcon,"RIGHT",2,0)
secondarySpecText:SetTextColor(unpack(cfg.color.normal))

secondarySpecFrame:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
	GameTooltip:SetOwner(talentFrame, cfg.tooltipPos)
	currentSpec = GetSpecialization()
	currentSpecID, currentSpecName = GetSpecializationInfo(currentSpec)
	lootspecid = GetLootSpecialization()
	if lootspecid == 0 then lootspecid = currentSpecID end
	id, name = GetSpecializationInfoByID(lootspecid)	
	if currentSpecID ~= id then
		GameTooltip:AddLine("|cffffffffLoot is currently set to |cffffff00"..name.."|cffffffff spec")
		GameTooltip:AddDoubleLine("<Right-Click>", "Change lootspec", 1, 1, 0, 1, 1, 1)
	end
	secondarySpecIcon:SetVertexColor(unpack(cfg.color.hover))
	GameTooltip:Show()
end)

secondarySpecFrame:SetScript("OnLeave", function() 
	if GetActiveSpecGroup() == 2 then
		secondarySpecIcon:SetVertexColor(unpack(cfg.color.normal))
	else
		secondarySpecIcon:SetVertexColor(unpack(cfg.color.inactive))
	end
	if ( GameTooltip:IsShown() ) then GameTooltip:Hide() end
end)

secondarySpecFrame:SetScript("OnClick", function(self, button, down)
	if InCombatLockdown() then return end
	if button == "LeftButton" then
		if GetNumSpecGroups() < 2 then
			return
		end
		if GetActiveSpecGroup() == 1 then
			SetActiveSpecGroup(2)
		elseif GetActiveSpecGroup() == 2 then
			SetActiveSpecGroup(1)
		end
	elseif button == "RightButton" then 
		if globalLootSpecFrame:IsShown() then
			globalLootSpecFrame:Hide()
		else
			globalLootSpecFrame:Show()
		end
	end
end)

local function createLootSpecButtons()
for index = 1,4 do
	local id, name = GetSpecializationInfo(index)
	if ( name ) then
		lootSpecFrame:SetSize(lootSpecText:GetStringWidth()+16, (index+1)*18)
		lootSpectBG:SetSize(lootSpecFrame:GetSize())
		currentSpecID, currentSpecName = GetSpecializationInfo(index)
		
		local lootSpecButton = CreateFrame("BUTTON",nil, lootSpecFrame)
		lootSpecButton:SetPoint("TOPLEFT", lootSpecText, 0, index*-18)
		lootSpecButton:SetSize(16, 16)
		lootSpecButton:EnableMouse(true)
		lootSpecButton:RegisterForClicks("AnyUp")
		
		
		local lootSpecbuttonText = lootSpecButton:CreateFontString(nil, "OVERLAY")
		lootSpecbuttonText:SetFont(cfg.text.font, cfg.text.smallFontSize)
		lootSpecbuttonText:SetPoint("RIGHT")
		if currentSpecName then currentSpecName = string.upper(currentSpecName) end
		lootSpecbuttonText:SetText(currentSpecName)
		
		local lootSpecbuttonIcon = lootSpecButton:CreateTexture(nil,"OVERLAY",nil,7)
		lootSpecbuttonIcon:SetSize(16, 16)
		lootSpecbuttonIcon:SetPoint("LEFT")
		lootSpecbuttonIcon:SetTexture(cfg.mediaFolder.."spec\\"..cfg.CLASS)
		lootSpecbuttonIcon:SetTexCoord(unpack(cfg.specCoords[index]))
		
		local id = GetSpecializationInfo(index)
		if GetLootSpecialization() == id then 
			lootSpecbuttonText:SetTextColor(unpack(cfg.color.normal))
			lootSpecbuttonIcon:SetVertexColor(unpack(cfg.color.normal))
		else 
			lootSpecbuttonText:SetTextColor(unpack(cfg.color.inactive))
			lootSpecbuttonIcon:SetVertexColor(unpack(cfg.color.inactive))
		end 
		lootSpecButton:SetSize(lootSpecbuttonText:GetStringWidth()+18,16)
		
		lootSpecButton:SetScript("OnEnter", function() if InCombatLockdown() then return end lootSpecbuttonIcon:SetVertexColor(unpack(cfg.color.hover)) end)
		lootSpecButton:SetScript("OnLeave", function()
			local id = GetSpecializationInfo(index)
			if GetLootSpecialization() == id then 
				lootSpecbuttonText:SetTextColor(unpack(cfg.color.normal))
				lootSpecbuttonIcon:SetVertexColor(unpack(cfg.color.normal))
			else 
				lootSpecbuttonText:SetTextColor(unpack(cfg.color.inactive))
				lootSpecbuttonIcon:SetVertexColor(unpack(cfg.color.inactive))
			end 
		end)
		
		lootSpecButton:SetScript("OnClick", function(self, button, down)
			if InCombatLockdown() then return end
			if button == "LeftButton" then
				local id = GetSpecializationInfo(index)
				SetLootSpecialization(id)
				lootSpecbuttonText:SetTextColor(unpack(cfg.color.normal))
				lootSpecbuttonIcon:SetVertexColor(unpack(cfg.color.normal))
				lootSpecFrame:Hide()
			elseif button == "RightButton" then
				lootSpecFrame:Hide()
			end
		end)
	end
end
end

---------------------------------------------
-- EVENTS
---------------------------------------------

local eventframe = CreateFrame("Frame")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
eventframe:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
eventframe:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
eventframe:RegisterEvent("PLAYER_REGEN_DISABLED")

eventframe:SetScript("OnEvent", function(self,event, ...)
	if event == ("PLAYER_ENTERING_WORLD") then 
	createLootSpecButtons()
	end
	if event == ("PLAYER_REGEN_DISABLED") then
		if lootSpecFrame:IsShown() then
			lootSpecFrame:Hide()
		end
	end
	
	local primarySpec = GetSpecialization(false, false, 1)
	if primarySpec ~= nil then
		local id, name = GetSpecializationInfo(primarySpec)
		if name then name = string.upper(name) end
		--name = string.upper(name)
		primarySpecText:SetText(name)
		primarySpecIcon:SetTexture(cfg.mediaFolder.."spec\\"..cfg.CLASS)
		primarySpecIcon:SetTexCoord(unpack(cfg.specCoords[primarySpec]))
		primarySpecFrame:SetSize(primarySpecText:GetStringWidth()+18, 16)
		primarySpecFrame:Show() 
		primarySpecFrame:EnableMouse(true)
	else
		primarySpecFrame:Hide() 
		primarySpecFrame:EnableMouse(false)
	end
	local secondarySpec = GetSpecialization(false, false, 2)
	if secondarySpec ~= nil then
		local id, name = GetSpecializationInfo(secondarySpec)
		if name then name = string.upper(name) end
		--name = string.upper(name)
		secondarySpecText:SetText(name)
		secondarySpecIcon:SetTexture(cfg.mediaFolder.."spec\\"..cfg.CLASS)
		secondarySpecIcon:SetTexCoord(unpack(cfg.specCoords[secondarySpec]))
		secondarySpecFrame:SetSize(secondarySpecText:GetStringWidth()+18, 16)
		secondarySpecFrame:Show() 
		secondarySpecFrame:EnableMouse(true)
	else
		secondarySpecFrame:Hide() 
		secondarySpecFrame:EnableMouse(false)
	end
	if GetActiveSpecGroup() == 1 then
		primarySpecIcon:SetVertexColor(unpack(cfg.color.normal))
		primarySpecText:SetTextColor(unpack(cfg.color.normal))
		secondarySpecIcon:SetVertexColor(unpack(cfg.color.inactive))
		secondarySpecText:SetTextColor(unpack(cfg.color.inactive))
	elseif GetActiveSpecGroup() == 2 then
		primarySpecIcon:SetVertexColor(unpack(cfg.color.inactive))
		primarySpecText:SetTextColor(unpack(cfg.color.inactive))
		secondarySpecIcon:SetVertexColor(unpack(cfg.color.normal))
		secondarySpecText:SetTextColor(unpack(cfg.color.normal))
	end
	
	talentFrame:SetSize((primarySpecFrame:GetWidth())+(secondarySpecFrame:GetWidth()+4), 16)
end)