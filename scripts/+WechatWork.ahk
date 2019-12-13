#Persistent
#SingleInstance Force
#NoTrayIcon
#NoEnv

#Include ../lib/MyToolTips.ahk

LButton::
FoundX1 = ""
FoundY1 = ""
FoundX2 = ""
FoundY2 = ""

if WinActive("ahk_class WeWorkWindow")
    ImageSearch, FoundX1, FoundY1, 0, 0, A_ScreenWidth, A_ScreenHeight, name.png
    if (ErrorLevel = 2)
        MouseShowTips("Could not conduct the search.")
    else if (ErrorLevel = 2)
		MouseShowTips("Icon could not be found on the screen.")
    else
        if (FoundX1 > 0) 
            MouseShowTips("Session was founded.")
            ImageSearch, FoundX2, FoundY2, 0, 0, A_ScreenWidth, A_ScreenHeight, read.png
            if (ErrorLevel = 2)
                MouseShowTips("Could not conduct the search.")
            else if (ErrorLevel = 2)
                MouseShowTips("Icon could not be found on the screen.")
            else if (FoundX2 > 0)
                MouseShowTips("Session not read notification.")
                MouseGetPos, xpos, ypos
				SendEvent {Click, %FoundX2%, %FoundY2%}
                Click, %xpos%, %ypos%, 0
            Return
Return

