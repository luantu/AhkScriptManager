#Include ../lib/MyToolTips.ahk

; 不显示图标~
Menu, Tray, NoIcon

ScreenShowTips("Input Method Auto Change actived")

;=====分组配置
;中文输入法的分组
GroupAdd,cn,ahk_exe WeChat.exe
GroupAdd,cn,ahk_exe WXWork.exe

;英文输入法的分组
GroupAdd,en,ahk_class TMobaXtermForm
GroupAdd,en,ahk_exe cmd.exe

#Persistent
SetBatchLines, -1
Process, Priority,, High

; 检测窗口事件处理
Gui +LastFound
hWnd := WinExist()
DllCall("RegisterShellHookWindow", UInt, hWnd)
MsgNum := DllCall("RegisterWindowMessage", Str, "SHELLHOOK")
OnMessage(MsgNum, "ShellMessage")
OnMessage(0x201, "MouseMessage")
Return

ShellMessage(wParam,lParam) {
	;WinGetActiveTitle, Title
	;ScreenShowTips("Title:"Title)
	;sleep 1000
	;MouseShowTips("wParam:"wParam)
	If (wParam = 1 or wParam = 5 or wParam = 6 or wParam = 32772) ; HSHELL_WINDOWACTIVATED := 5
    {
		IfWinActive ahk_group en
        {
			sleep 200 ;延迟一会儿，保证窗口确实被切换到了
			IfWinActive ahk_group en
			{
				setInputEnglish()
				return
			}
		}
		
		IfWinActive ahk_group cn
        {
			sleep 200 ;延迟一会儿，保证窗口确实被切换到了
			IfWinActive ahk_group cn
			{
				setInputChinese()
				return
			}
		}
	}
}

MouseMessage(wParam,lParam) {
	MouseShowTips("Mouse wParam:"wParam)
}

; 中文返回cn，英文返回en
getCurrentInput() {
	FoundX = ""
	CoordMode Pixel
	ImageSearch, FoundX, FoundY, 1834, 915, A_ScreenWidth, A_ScreenHeight, input_cn.png
	if (ErrorLevel = 2) {
		ScreenShowTips("Could not conduct the search")
	} else if (ErrorLevel = 2) {
		ScreenShowTips("Icon could not be found on the screen.")
	} else if (FoundX <> "") {
		;ScreenShowTips("current input method is 中文.")
		Return "cn"
	}
	
	FoundX = ""
	ImageSearch, FoundX, FoundY, 1834, 915, A_ScreenWidth, A_ScreenHeight, input_en.png
	if (ErrorLevel = 2) {
		MsgBox Could not conduct the search.
	} else if (ErrorLevel = 2) {
		MsgBox Icon could not be found on the screen.
	} else if (FoundX <> "") {
		;ScreenShowTips("current input method is English.")
		Return "en"
	}
	
	Return ""
}

;改变输入法
changeInput() {
	Send {Shift down}
	sleep 100
	Send {Shift up}
	sleep 100
}

; 读取当前输入法，如果是中文，则发送shift键切换
setInputEnglish() {
	if (getCurrentInput() = "cn") {
		changeInput()
		if (getCurrentInput() = "en") {
			ScreenShowTips("输入法已自动切换为 En")
			Return
		} else if (getCurrentInput() = "cn") {
			changeInput()
			ScreenShowTips("输入法已自动切换为 En")
		}
	}
}

; 读取当前输入法，如果是英文，则发送shift键切换
setInputChinese() {
	if (getCurrentInput() = "en") {
			changeInput()
		if (getCurrentInput() = "cn") {
			ScreenShowTips("输入法已自动切换为 中文")
			Return
		} else if (getCurrentInput() = "cn") {
			changeInput()
			ScreenShowTips("输入法已自动切换为 中文")
		}
	}
}