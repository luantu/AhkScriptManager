;需要注册为默认英文输入法的分组
GroupAdd,en,ahk_exe Xshell.exe
GroupAdd,en,ahk_exe cmd.exe
GroupAdd,en,ahk_exe sh.exe

;需要注册为默认中文输入法的分组
;GroupAdd,cn,ahk_exe Notepad++.exe
GroupAdd,cn,ahk_exe RTX.exe
GroupAdd,cn,ahk_exe Wechat.exe
GroupAdd,cn,ahk_exe chrome.exe
GroupAdd,cn,ahk_exe QQ.exe
GroupAdd,cn,ahk_exe Wiz.exe

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;删除右键使用windows defender扫描
RegDelete, HKEY_CLASSES_ROOT, *\shellex\ContextMenuHandlers\EPP,
RegDelete, HKEY_CLASSES_ROOT, Drive\shellex\ContextMenuHandlers\EPP,
RegDelete, HKEY_CLASSES_ROOT, Directory\shellex\ContextMenuHandlers\EPP,
;删除共享
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\*\shellex\ContextMenuHandlers\Sharing,
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\Sharing,
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\Sharing,
;删除固定到开始菜单
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen,

;兼容性疑难解答
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\batfile\shellex\ContextMenuHandlers\Compatibility,
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\exefile\shellex\ContextMenuHandlers\Compatibility,

;包含到库
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\Library Location,

;删除我的电脑的那些文件夹
; 下载
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f},
; 音乐
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de},
; 图片
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8},
; 桌面
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641},
; 文档
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af},
; 视频
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;保持myChrome为默认html打开方式
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, ChromeHTML.77YFJP5HJD5VZSM3X3AK2FMTCQ\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, htmlfile\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, http\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, https\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;修改显示字体大小
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, MenuFont,f1ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, CaptionFont,f1ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, SmCaptionFont,f1ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000

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
    TrayTip,AHK, %var_string%
    
    ;方式二, 跟随鼠标提示
;   ToolTip, Tips, 10, 10
;   #Persistent
;   ToolTip, %var_string%
;   SetTimer, RemoveTip, 1000
;   return
; RemoveTip:
;   SetTimer, RemoveTip, Off
;   ToolTip
;   return
    
    ;方式三，屏幕中间显示
    ;SplashTextOn, , , %var_string%
    ;Sleep, 1000
    ;SplashTextOff
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
            
            ; 周报
            IfInString, fileName, 周报
            {
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Documents\工作文档\周报\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            ; 月报
            IfInString, fileName, 月报
            {
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
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = D:\Program Files\Snipaste\%fileName%
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

; 开启source insight，如果已经开启，激活窗口
#s::
IfWinNotExist ahk_class si_Frame 
    Run "D:\Program Files (x86)\Source Insight 3\Insight3.Exe"
Else 
IfWinNotActive ahk_class si_Frame 
    WinActivate 
Else 
    WinMinimize 
Return 

; 开启outlook，如果已经开启，激活窗口
#o::
IfWinNotExist ahk_exe OUTLOOK.EXE
    Run "D:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE", , Max
Else 
IfWinNotActive ahk_exe OUTLOOK.EXE
    WinActivate 
Else 
    WinMinimize 
Return

#n::Run Notepad++
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

#+m::
IfWinNotExist  ahk_class WinMergeWindowClassW
    Run "D:\Program Files (x86)\WinMerge\WinMergeU.exe"
Else 
IfWinNotActive ahk_class WinMergeWindowClassW
    WinActivate 
Else 
    WinMinimize 
Return 