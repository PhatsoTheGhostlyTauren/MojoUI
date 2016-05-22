local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API

local TT = Mojo:NewModule("Tooltip",Mojo:GetPrototype())

TT.Defaults = {
	bgcolor = Mojo.Settings.Layout.AltBGColor,
	bordercolor = {0,0,0,0}
}

TT.Tips = {
	"GameTooltip",
	"ShoppingTooltip1",
	"ShoppingTooltip2",
	"ShoppingTooltip3",
	"ItemRefTooltip",
	"ItemRefShoppingTooltip1",
	"ItemRefShoppingTooltip2",
	"ItemRefShoppingTooltip3",
	"WorldMapTooltip",
	"WorldMapCompareTooltip1",
	"WorldMapCompareTooltip2",
	"WorldMapCompareTooltip3",
}


function TT:OnInitialize()
	self.Settings = self.Defaults
end

function TT:StyleTooltip(tooltip)
	print(tooltip:GetName())
	AdvancedMojo.SetBlankBD(tooltip)
	tooltip:SetBackdropColor(unpack(self.Settings.bgcolor))
	tooltip:SetBackdropBorderColor(unpack(self.Settings.bordercolor))
end


function TT:StyleItemTip(tooltip)
	local itName,itLink = tooltip:GetItem()
	if itName then
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itLink)		
		tooltip:SetBackdropBorderColor(GetItemQualityColor(itemRarity))
	end	
end

function TT:HandleTip(tooltip)
	self:StyleTooltip(tooltip)
	
	--Make Sure the Tip Resets to the correct Visuals OnHide
	tooltip:HookScript("OnHide", function(tip) self:StyleTooltip(tip) end)		

	
	tooltip:HookScript("OnTooltipSetItem", function(tip) self:StyleItemTip(tip) end)
	
end


function TT:EnableTriangle(tooltip)	
	local triangle = tooltip:CreateTexture(tooltip:GetName().."_Triangle")
	triangle:SetTexture(Mojo.Media.Textures.Misc.TRIANGLE)
	triangle:SetPoint("TOP",tooltip,"BOTTOM")
	triangle:SetSize(32,10)
	triangle:SetVertexColor(unpack(self.Settings.bgcolor))
	triangle:Show()
end

function TT:Mojoize()
	for _,tipName in pairs(self.Tips) do
		--If Tooltip even exists
		if _G[tipName] then			
			self:HandleTip( _G[tipName] )		
		end
	end
	
	
	AdvancedMojo.DoOneFrameLater(GameTooltip,"SetOwner",function() self:StyleTooltip(GameTooltip) end)
	
end





