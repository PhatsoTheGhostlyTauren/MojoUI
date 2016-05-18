local addon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(addon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API



-----------------------------
-- Reparents Frames to a hidden Frame and unregisters all Events

Mojo.HiddenFrame = CreateFrame("Frame",nil)
Mojo.HiddenFrame:Hide()

AdvancedMojo["KillFrame"] = function(obj)
	if obj.UnregisterAllEvents then
		obj:UnregisterAllEvents()
	end
	obj:SetParent(Mojo.HiddenFrame)
end

-----------------------------



-----------------------------
--Palette-Mojo
AdvancedMojo["SetBlankBD"] = function(f)
	f:SetBackdrop({
		bgFile = Mojo.Settings.Layout.BlankTex,  
		edgeFile = Mojo.Settings.Layout.BlankTex,
		tile = false,
		tileSize = 0,
		edgeSize = 1,
		insets = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0
		}
	})
end
-----------------------------


-----------------------------
--Anchor-Mojo
AdvancedMojo["AlignX"] = function(f,g,offset)
	if offset == nil then offset = 0 end
	f:SetPoint("LEFT",g,"LEFT",-offset,0)
	f:SetPoint("RIGHT",g,"RIGHT",offset,0)
end
AdvancedMojo["AlignY"] = function(f,g,offset)
	if offset == nil then offset = 0 end
	f:SetPoint("TOP",g,"TOP",0,offset)
	f:SetPoint("BOTTOM",g,"BOTTOM",0,-offset)
end
AdvancedMojo["Align"] = function(f,g)
	AdvancedMojo.AlignX(f,g)
	AdvancedMojo.AlignY(f,g)
end
AdvancedMojo["WrapAnchors"] = function(f,g,offset)
	f:SetPoint("TOPLEFT",g,"TOPLEFT",-offset,offset)
	f:SetPoint("TOPRIGHT",g,"TOPRIGHT",offset,offset)
	f:SetPoint("BOTTOMLEFT",g,"BOTTOMLEFT",-offset,-offset)
	f:SetPoint("BOTTOMRIGHT",g,"BOTTOMRIGHT",offset,-offset)
end
-----------------------------


-----------------------------
--Routines for User Placed Frames
AdvancedMojo["UPMove"] = function(f,offsetX,offsetY)
	local left,bottom,width,height = f:GetRect()
	f:ClearAllPoints()
	f:SetPoint("BOTTOMLEFT", f:GetParent(), left+offsetX, bottom+offsetY)
	f:SetWidth(width)
	f:SetHeight(height)
end
-----------------------------



















