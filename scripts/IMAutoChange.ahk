#Include ../lib/MyToolTips.ahk

; ����ʾͼ��~
Menu, Tray, NoIcon

ScreenShowTips("Input Method Auto Change actived")

;=====��������
;�������뷨�ķ���
GroupAdd,cn,ahk_exe WeChat.exe
GroupAdd,cn,ahk_exe WXWork.exe

;Ӣ�����뷨�ķ���
GroupAdd,en,ahk_class TMobaXtermForm
GroupAdd,en,ahk_exe cmd.exe

#Persistent
SetBatchLines, -1
Process, Priority,, High

; ��ⴰ���¼�����
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
			sleep 200 ;�ӳ�һ�������֤����ȷʵ���л�����
			IfWinActive ahk_group en
			{
				setInputEnglish()
				return
			}
		}
		
		IfWinActive ahk_group cn
        {
			sleep 200 ;�ӳ�һ�������֤����ȷʵ���л�����
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

; ���ķ���cn��Ӣ�ķ���en
getCurrentInput() {
	FoundX = ""
	CoordMode Pixel
	ImageSearch, FoundX, FoundY, 1834, 915, A_ScreenWidth, A_ScreenHeight, input_cn.png
	if (ErrorLevel = 2) {
		ScreenShowTips("Could not conduct the search")
	} else if (ErrorLevel = 2) {
		ScreenShowTips("Icon could not be found on the screen.")
	} else if (FoundX <> "") {
		;ScreenShowTips("current input method is ����.")
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

;�ı����뷨
changeInput() {
	Send {Shift down}
	sleep 100
	Send {Shift up}
	sleep 100
}

; ��ȡ��ǰ���뷨����������ģ�����shift���л�
setInputEnglish() {
	if (getCurrentInput() = "cn") {
		changeInput()
		if (getCurrentInput() = "en") {
			ScreenShowTips("���뷨���Զ��л�Ϊ En")
			Return
		} else if (getCurrentInput() = "cn") {
			changeInput()
			ScreenShowTips("���뷨���Զ��л�Ϊ En")
		}
	}
}

; ��ȡ��ǰ���뷨�������Ӣ�ģ�����shift���л�
setInputChinese() {
	if (getCurrentInput() = "en") {
			changeInput()
		if (getCurrentInput() = "cn") {
			ScreenShowTips("���뷨���Զ��л�Ϊ ����")
			Return
		} else if (getCurrentInput() = "cn") {
			changeInput()
			ScreenShowTips("���뷨���Զ��л�Ϊ ����")
		}
	}
}