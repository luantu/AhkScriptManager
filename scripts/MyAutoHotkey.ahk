#Include ../lib/MyToolTips.ahk

; 不显示图标~
Menu, Tray, NoIcon

ScreenShowTips("My Hotkey Mapping actived")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;代码开始;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 已有快捷方式说明
; win+h  清空垃圾桶
; win+x  以管理员方式运行命令行
; win+m  打开foxmail
; win+t  打开total commander
; win+g  打开cmder，原为gitbash，所以快捷键为g
; win+w  打开为知笔记
; win+b  打开浏览器
; win+c  在tc界面为提交svn代码
; 

;win+h 清空垃圾桶
#h::FileRecycleEmpty

; win+x  以管理员方式运行命令行
#x::
send,#xa
return

; 开启Foxmail，如果已经开启，激活窗口
; #m::
; IfWinNotExist  ahk_exe Foxmail.exe
;     Run "D:\Program Files\Foxmail 7.2\Foxmail.exe", , Max
; Else 
; IfWinNotActive  ahk_exe Foxmail.exe
;     WinActivate 
; Else 
;     WinClose ; 使用前面找到的窗口 
; Return 

; 开启tc，如果已经开启，激活窗口
#t::
IfWinNotExist  ahk_class TTOTAL_CMD, 
    Run "D:\Program Files\TotalCMD64\Totalcmd64.exe", , Max
Else 
IfWinNotActive ahk_class TTOTAL_CMD, 
    WinActivate 
Else 
    WinMinimize 
Return 

;运行cmder
#g::
IfWinNotExist ahk_exe ConEmu.exe
    Run "D:\cmder\Cmder.exe", , Max
Else 
IfWinNotActive ahk_exe ConEmu.exe
    WinActivate 
Else 
    WinMinimize 
Return

; 开启为知笔记，如果已经开启，激活窗口
#w::
IfWinNotExist  ahk_class WizNoteMainFrame
    Run "D:\Program Files (x86)\WizNote\Wiz.exe", , Max
Else 
IfWinNotActive ahk_class WizNoteMainFrame
    WinActivate 
Else 
    WinMinimize 
Return 

; 开启浏览器，如果已经开启，激活窗口
#b::
IfWinNotExist  ahk_class Chrome_WidgetWin_1
    Run "D:\CentBrowser\chrome.exe", , Max
Else 
IfWinNotActive ahk_class Chrome_WidgetWin_1
    WinActivate 
Else 
    WinMinimize 
Return 

; 开启sublime，如果已经开启，激活窗口
;#s::
;IfWinNotExist ahk_exe sublime_text.exe 
;    Run "D:\Program Files\Sublime Text 3\sublime_text.exe"
;Else 
;IfWinNotActive ahk_exe sublime_text.exe
;    WinActivate 
;Else 
;    WinMinimize 
;Return 

; 开启outlook，如果已经开启，激活窗口
;#o::
;IfWinNotExist ahk_exe OUTLOOK.EXE
;    Run "D:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE", , Max
;Else 
;IfWinNotActive ahk_exe OUTLOOK.EXE
;    WinActivate 
;Else 
;    WinMinimize 
;Return

#n::Run "D:\Program Files (x86)\Notepad++\notepad++.exe"
return 

:://g:: 
Run http://www.google.com 
return 

:://b:: 
Run http://www.baidu.com 
return

; SVN提交
#c::
if WinActive("Total Commander")
{
    Send {F12}
    Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:commit /logmsg:"update" /path:"%clipboard%" /closeonend:3
}
Return

;ahk_class #32770
;ahk_exe TortoiseProc.exe
; SVN更新
#u::
if WinActive("Total Commander")
{
    try {
        Send {F12}
        Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:update /path:"%clipboard%" /closeonend:3
    } catch {
        return
    }
    ;WinWaitActive  ,,Update, 5
    ;WinActivate 
}
Else
IfWinActive ahk_class CabinetWClass
{
   WinGetActiveTitle, pth
   cmd = D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe /command:update /path:"%pth%" /closeonend:3
   run, %cmd%, %pth%
}
Return

; 关闭中文半角
; 关闭shit+空格 导致半角切换
+Space::
return

+Del::
If WinActive("ahk_class TFoxMainFrm.UnicodeClass") or WinActive("ahk_class rctrl_renwnd32") 
{
    ; SHIFT+DELETE显示弹框确认
    MsgBox, 4, 不准乱删邮件, (#^.^#)请认真确认是否彻底删除选中邮件, 10  ; 5 秒的超时时间.
    IfMsgBox, No
        Return  ; 用户点击了 "No" 按钮.
    IfMsgBox, Timeout
        Return ; 即在超时时假设点击了 "No".
    ; 否则, 继续:
    Send +{Del}
    Return
}
Else
{
Send +{Del}
}
Return

#+m::
IfWinNotExist  ahk_class WinMergeWindowClassW
    Run "D:\Program Files (x86)\WinMerge\WinMergeU.exe"
Else 
IfWinNotActive ahk_class WinMergeWindowClassW
    WinActivate 
Else 
    WinMinimize 
Return 

;; win+f
#f::
IfWinNotActive ahk_class EVERYTHING
    Send ^+{F12}
Return
