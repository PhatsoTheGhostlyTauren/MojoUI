local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API
local MD = Mojo:GetModule("Databar")

local armor = MD:NewModule("Armor")

armor.Defaults = {
	minArmor = 20,			-- WHEN THE ANVIL GOES FROM INACTIVE TO ACTIVE
	maxArmor = 75,			-- AT WHAT % IT WILL SHOW ARMORTEXT INSTEAD OF ILVL
	color = {1,1,1,0.55},
	hovercolor = {1,1,1,0.95},
	font = LSM:Fetch("font","Homizio Bold"),
	fontSize = 12
}


function armor:OnInitialize() 
	--Loads Settings from Defaults
	self.Settings = self.Defaults
	
	--TODO: Override default Settings with SavedVariable Config
end

function armor:Update()
	--Find the Broken % of the most broken Item on your Character
	local durMin = 100
	local durCur,durMax = 100,100
	for i = 1, 18 do
		durCur, durMax = GetInventoryItemDurability(i)
		if durCur and durMax then
			local durMin = math.min(durMin,(durMax/durCur)*100)
		end
	end
	
	--if said item is not below the threshold display average ilvl if not show Durability% of said Item
	if durMin >= self.Settings.maxArmor then 
		local overallilvl, equippedilvl = GetAverageItemLevel()
		self.armorText:SetText(floor(equippedilvl).." ilvl")
	else
		self.armorText:SetText(floor(durMin).."%")
	end
	
	if durMin >= self.Settings.minArmor then 
		 self.armorIcon:SetVertexColor(unpack(self.Settings.color)) 
	else
		--make icon red when an item is below the threshold
		self.armorIcon:SetVertexColor(1,0,0)
	end
	
	--Update the Frame's Width to fit in the Text
	self.armorFrame:SetSize(self.armorText:GetStringWidth()+40, MD.Databar:GetHeight())

end


function armor:CreateDatatext()
	self.armorFrame = MD:NewDatatext("Armor","LEFT",570)
	
	self.armorIcon = self.armorFrame:CreateTexture("Mojo_Databar_Armor_Icon","MEDIUM",nil,7)
	self.armorIcon:SetPoint("LEFT")
	self.armorIcon:SetTexture(Mojo.Media.Textures.Datatexts.REPAIR)
	self.armorIcon:SetVertexColor(unpack(self.Settings.color))

	self.armorText = self.armorFrame:CreateFontString("Mojo_Databar_Armor_Text", "MEDIUM")
	self.armorText:SetFont(self.Settings.font, self.Settings.fontSize)
	self.armorText:SetPoint("LEFT",self.armorIcon,"RIGHT",3,0)
	self.armorText:SetTextColor(unpack(self.Settings.color))

	
	--Change Color on Hover
	self.armorFrame:SetScript("OnEnter", function()
		self.armorIcon:SetVertexColor(unpack(self.Settings.hovercolor))
		self.armorText:SetTextColor(unpack(self.Settings.hovercolor))
	end)
	self.armorFrame:SetScript("OnLeave", function()
		self.armorIcon:SetVertexColor(unpack(self.Settings.color))
		self.armorText:SetVertexColor(unpack(self.Settings.color))
	end)

	--Load Contents
	self:Update()
end



function armor:Mojoize()
	self:CreateDatatext()

	--Update the Datatext when Equipment or Durability has changed
	AdvancedMojo.ListenDo("UPDATE_INVENTORY_DURABILITY",function() self:Update() end)
	AdvancedMojo.ListenDo("PLAYER_EQUIPMENT_CHANGED",function() self:Update() end)
end