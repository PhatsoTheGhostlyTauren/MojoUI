local thisaddon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(thisaddon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API
local AS = Mojo:GetModule("AddonSupport")


local MC = Mojo:GetModule("Chat")

local CLog = AS:NewModule("Blizzard_CombatLog",Mojo:GetPrototype())


function CLog:Support()

	local cleft,cbottom,cwidth,cheight = CombatLogQuickButtonFrame_Custom:GetRect()
	--Anchor QuickButtonFrame at the Top of ChatFrame2BG
	CombatLogQuickButtonFrame_Custom:SetPoint("TOPLEFT",ChatFrame2BG,"TOPLEFT",0,cheight)	
	CombatLogQuickButtonFrame_Custom:SetPoint("TOPRIGHT",ChatFrame2BG,"TOPRIGHT",0,cheight)	
	CombatLogQuickButtonFrame_Custom:SetPoint("BOTTOMLEFT",ChatFrame2BG,"TOPLEFT")	
	CombatLogQuickButtonFrame_Custom:SetPoint("BOTTOMRIGHT",ChatFrame2BG,"TOPRIGHT",0)
	--Fix Progressbar Width
	AdvancedMojo.AlignX(CombatLogQuickButtonFrame_CustomProgressBar,CombatLogQuickButtonFrame_Custom)
	
	--Fix Tab Position
	ChatFrame2Tab:SetPoint("BOTTOMLEFT",CombatLogQuickButtonFrame_Custom,"TOPLEFT",0,MC.Settings.CHATFRAMETABSPACING)
	hooksecurefunc("FCF_SetTabPosition",function(chatFrame,x)
		if(chatFrame:GetName() == "ChatFrame2") then
			ChatFrame2Tab:SetPoint("BOTTOMLEFT",CombatLogQuickButtonFrame_Custom,"TOPLEFT",0,MC.Settings.CHATFRAMETABSPACING)
		end
	end)


end
