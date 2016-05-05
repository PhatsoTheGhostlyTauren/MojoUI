local addon, private = ...
local Mojo = LibStub("AceAddon-3.0"):GetAddon(addon)
local LSM = LibStub("LibSharedMedia-3.0")
local AdvancedMojo = Mojo.API
local MS = Mojo.Settings


local MC = Mojo:NewModule("Chat")


--Settings
local TABTEXTCOLOR = {1,1,1,0.75}
local CHATFRAMEPADDING = 5
local CHATFRAMETABSPACING = 3
local TABHEIGHT = GeneralDockManager:GetHeight()





local function StripChat(cframe)
	--Get rid of those shitty Scrollbuttons; Fuck people without Scrollwheels, Use PUp/PDown
	AdvancedMojo.KillFrame(_G[cframe.."ButtonFrame"])
	
	local uselessCraps = {"TabSelectedMiddle","TabHighlightMiddle",
						"TabMiddle","TabSelectedRight","TabHighlightRight",
						"TabRight","TabSelectedLeft","TabHighlightLeft","TabLeft",
						"RightTexture","LeftTexture","TopTexture","BottomTexture",
						"TopRightTexture","TopLeftTexture","BottomLeftTexture","BottomRightTexture","Background"
	}
	for _,Crap in pairs(uselessCraps) do
		AdvancedMojo.KillFrame(_G[cframe..Crap])
	end
end

local function StyleChat(cframe)

	local ChatFrame = _G[cframe]
	local ChatTab = _G[cframe.."Tab"]

	--Fixes Chat Frames being position restricted
	ChatFrame:SetClampedToScreen(false)	
	
	--Sets Content Window Backdrop and hides Borders
	local ChatFrameBG = CreateFrame("Frame",cframe.."BG",ChatFrame)
	ChatFrameBG:SetFrameLevel(ChatFrame:GetFrameLevel() - 1)
	AdvancedMojo.AlignX(ChatFrameBG,ChatFrame,CHATFRAMEPADDING)
	AdvancedMojo.AlignY(ChatFrameBG,ChatFrame,CHATFRAMEPADDING)
	AdvancedMojo.SetBlankBD(ChatFrameBG)	
	ChatFrameBG:SetBackdropColor(unpack(MS.Layout.BGColor))
	ChatFrameBG:SetBackdropBorderColor(0,0,0,0)	

	
	--Fix ResizeButton
	local ResizeButton = _G[cframe.."ResizeButton"]
	ResizeButton:ClearAllPoints()
	ResizeButton:SetPoint("BOTTOMRIGHT",2+CHATFRAMEPADDING,-2-CHATFRAMEPADDING)
	
	--Set ChatFrame Font properties
	ChatFrame:SetFont(LSM:Fetch("font","Homizio Regular"),10,"NONE")
	ChatFrame:SetShadowColor(0,0,0,0)
	
	--Create Frame Tab Background
	TabBG = CreateFrame("Frame",cframe.."TabBG",ChatFrame)
	AdvancedMojo.SetBlankBD(TabBG)
	TabBG:SetBackdropColor(unpack(MS.Layout.AltBGColor))
	TabBG:SetBackdropBorderColor(0,0,0,0)
	AdvancedMojo.AlignX(TabBG,ChatFrameBG)
	AdvancedMojo.AlignY(TabBG,ChatTab)
	TabBG:Show()
	
	--Set Tab Text Properties
	local TabText = _G[cframe.."TabText"]
	TabText:ClearAllPoints()
	TabText:SetPoint("CENTER")
	TabText:SetFont(LSM:Fetch("font","Homizio Black"),16,"NONE")
	TabText:SetShadowColor(0,0,0,0)
	TabText:SetTextColor(unpack(TABTEXTCOLOR))
	hooksecurefunc("FCFTab_UpdateColors",function(...)
		TabText:SetTextColor(unpack(TABTEXTCOLOR))
	end)
	
	-- Set Chat Tab Basic Properties
	ChatTab:SetHeight(TABHEIGHT)
	ChatTab:SetPoint("BOTTOMLEFT",ChatFrame,"TOPLEFT",0,CHATFRAMETABSPACING)
end

local function FixFloatingChatFrameBehavior()
	--Reposition GeneralDockManager 
	GENERAL_CHAT_DOCK:ClearAllPoints()
	GENERAL_CHAT_DOCK:SetPoint("BOTTOMLEFT", ChatFrame1BG, "TOPLEFT", 0, CHATFRAMETABSPACING)
	GENERAL_CHAT_DOCK:SetWidth(ChatFrame1:GetWidth())

	FCF_SetTabPosition = function(chatFrame, x)
		local chatTab = _G[chatFrame:GetName().."Tab"];
		chatTab:ClearAllPoints();
		chatTab:SetPoint("BOTTOMLEFT", chatFrame:GetName().."BG", "TOPLEFT", x, CHATFRAMETABSPACING);
	end

end



local function MakeEditBoxGreatAgain()
	--Hides all EditBox Textures
	AdvancedMojo.KillFrame(ChatFrame1EditBoxLeft)
	AdvancedMojo.KillFrame(ChatFrame1EditBoxMid)
	AdvancedMojo.KillFrame(ChatFrame1EditBoxRight)
	AdvancedMojo.KillFrame(ChatFrame1EditBox.focusLeft)
	AdvancedMojo.KillFrame(ChatFrame1EditBox.focusMid)
	AdvancedMojo.KillFrame(ChatFrame1EditBox.focusRight)
	
	--Sets Mojo Backdrop
	AdvancedMojo.SetBlankBD(ChatFrame1EditBox)
	ChatFrame1EditBox:SetBackdropBorderColor(0,0,0,0)
	ChatFrame1EditBox:SetBackdropColor(unpack(MS.Layout.AltBGColor))
	
	--Position under ChatFrame1
	ChatFrame1EditBox:ClearAllPoints()
	AdvancedMojo.AlignX(ChatFrame1EditBox,ChatFrame1BG)
	ChatFrame1EditBox:SetPoint("Top",ChatFrame1BG,"BOTTOM",0,-2)
	ChatFrame1EditBox:SetPoint("BOTTOM",ChatFrame1BG,"BOTTOM",0,-27)
end



function MC:OnInitialize() 	
	--Iterate through all chatframes, strip them and make the great again
	for name,frame in pairs(CHAT_FRAMES) do	
		StripChat(frame)
		StyleChat(frame)
	end		
	
	AdvancedMojo.KillFrame(FriendsMicroButton)
	AdvancedMojo.KillFrame(ChatFrameMenuButton)

	
	MakeEditBoxGreatAgain()
	
	FixFloatingChatFrameBehavior()
	
end