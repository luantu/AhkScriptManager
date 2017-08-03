
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 任务栏是否显示缩略图，
; HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\MaxThumbSizePx
; 新: DWORD: 1 (0x1)
; 旧: DWORD: 240 (0xf0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;全局定义当前的输入法，尽量减少多余的send对操作的影响
isCurrentEnglish = 0

TrayTip,MyAutoHotkey, autohotkey actived.,2,1

; 不显示图标~
Menu, Tray, NoIcon

;在鼠标处，显示小提示
showTips(var_string)
{
    ;方式一，通知栏弹窗
    ;TrayTip,AHK, %var_string%
    
    ;方式二, 跟随鼠标提示
    ToolTip, Tips, 10, 10
    #Persistent
    ToolTip, %var_string%
    SetTimer, RemoveTip, 1000
    return
  RemoveTip:
    SetTimer, RemoveTip, Off
    ToolTip
    return
    
    ;方式三，屏幕中间显示
;    SplashTextOn, , , %var_string%
;    Sleep, 1000
;    SplashTextOff
}

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Persistent
SetBatchLines, -1
Process, Priority,, High

Gui +LastFound
hWnd := WinExist()

DllCall("RegisterShellHookWindow", UInt, hWnd)
MsgNum := DllCall("RegisterWindowMessage", Str, "SHELLHOOK")
OnMessage(MsgNum, "ShellMessage")
Return

ShellMessage(wParam,lParam) {
    If (wParam = 1) ; HSHELL_WINDOWCREATED := 1
    {
        WinGetActiveTitle, Title

        IfWinActive, 下载文件信息
        {
            ControlGetText, docUrl, Edit3, 
            SplitPath, docUrl ,fileName
            
            showTips("准备下载：" + fileName)
            
            ; RG-ONC_2.2.1-项目周报
            IfInString, fileName, RG-ONC_2.2.1-项目周报
            {
                showTips("RG-ONC_2.2.1-项目周报："+fileName)
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Working\SDN&NFV\RGONC-MANAGE\RGONC_2.2.1\项目周报\%fileName%
                ClipWait 
                Send ^v
                return
            }
            ; 周报
            IfInString, fileName, 周报
            {
                showTips("周报："+fileName)
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Documents\工作文档\周报\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            ; 月报
            IfInString, fileName, 月总结
            {
                showTips("月总结："+fileName)
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Documents\工作文档\月报\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            ; chromeInstall
            IfInString, fileName, chrome_installer
            {
                showTips("chromeInstall："+fileName)
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = D:\Chrome\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            ; Snipaste
            IfInString, fileName, Snipaste
            {
                showTips("Snipaste："+fileName)
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = D:\Program Files\Snipaste\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            ; 2.2.0
            IfInString, fileName, ONC_2.2.0
            {
                showTips("RG-ONC_2.2.0："+fileName)
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Working\SDN&NFV\RGONC-MANAGE\RGONC_2.2.0\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            return
        }
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;代码开始;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#h::FileRecycleEmpty

#x::
send,#xa
return

; 开启Foxmail，如果已经开启，激活窗口
#m::
IfWinNotExist  ahk_exe Foxmail.exe
    Run "D:\Program Files\Foxmail 7.2\Foxmail.exe", , Max
Else 
IfWinNotActive  ahk_exe Foxmail.exe
    WinActivate 
Else 
    WinClose ; 使用前面找到的窗口 
Return 

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
#s::
IfWinNotExist ahk_exe sublime_text.exe 
    Run "D:\Program Files\Sublime Text 3\sublime_text.exe"
Else 
IfWinNotActive ahk_exe sublime_text.exe
    WinActivate 
Else 
    WinMinimize 
Return 

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
    Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:commit /path:"%clipboard%"
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

; 关闭shit+空格 导致半角切换
+Space::
return

; 关闭中文半角

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
