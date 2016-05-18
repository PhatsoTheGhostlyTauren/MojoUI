local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API
local TT = Mojo:GetModule("Tooltip")

local MD = Mojo:NewModule("Databar",Mojo:GetPrototype())

MD.Defaults = {
	barheight = 35,
	barcolor = {.094,.094,.102,.45},			-- THE COLOR OF THE BAR
}

function MD:OnInitialize()
	self.Settings = self.Defaults
	self.Datatexts = {}
end


function MD:CreateDatabar()
	self.Databar = CreateFrame("Frame","Mojo_Databar", UIParent)
	self.Databar:SetSize(0, self.Settings.barheight)
	self.Databar:SetFrameStrata("BACKGROUND")

	AdvancedMojo.AlignX(self.Databar,UIParent)
	self.Databar:SetPoint("BOTTOM",UIParent,"BOTTOM")	
	
	AdvancedMojo.SetBlankBD(self.Databar)
	self.Databar:SetBackdropColor(unpack(self.Settings.barcolor))
	self.Databar:SetBackdropBorderColor(0,0,0,0)--Transparent Border
end


function MD:CreateTooltip()
	self.Tooltip = CreateFrame("GameTooltip","Mojo_Databar_Tooltip",self.Databar,"GameTooltipTemplate")
	TT:HandleTip(self.Tooltip)
	TT:EnableTriangle(self.Tooltip)
end



function MD:Mojoize()
	self:CreateDatabar()
	self:CreateTooltip()
	
	for name, module in MD:IterateModules() do
		module:Mojoize()
	end
		
	self.Databar:Show()
end

function MD:NewDatatext(name,Point,xOffset)	
	self.Datatexts[name] = CreateFrame("Frame","Mojo_Databar_"..name,self.Databar)
	AdvancedMojo.AlignY(self.Datatexts[name],self.Databar)

	self.Datatexts[name]:SetPoint(Point,xOffset,0)
	
	
	return self.Datatexts[name]
end


