;��Ҫע��ΪĬ��Ӣ�����뷨�ķ���
GroupAdd,en,ahk_exe Xshell.exe
GroupAdd,en,ahk_exe cmd.exe
GroupAdd,en,ahk_exe sh.exe

;��Ҫע��ΪĬ���������뷨�ķ���
;GroupAdd,cn,ahk_exe Notepad++.exe
GroupAdd,cn,ahk_exe RTX.exe
GroupAdd,cn,ahk_exe Wechat.exe
GroupAdd,cn,ahk_exe chrome.exe
GroupAdd,cn,ahk_exe QQ.exe
GroupAdd,cn,ahk_exe Wiz.exe

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; �������Ƿ���ʾ����ͼ��
; HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\MaxThumbSizePx
; ��: DWORD: 1 (0x1)
; ��: DWORD: 240 (0xf0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ȫ�ֶ��嵱ǰ�����뷨���������ٶ����send�Բ�����Ӱ��
isCurrentEnglish = 0

TrayTip,MyAutoHotkey, autohotkey actived.,2,1

; ����ʾͼ��~
Menu, Tray, NoIcon

;����괦����ʾС��ʾ
showTips(var_string)
{
    ;��ʽһ��֪ͨ������
    TrayTip,AHK, %var_string%
    
    ;��ʽ��, ���������ʾ
;   ToolTip, Tips, 10, 10
;   #Persistent
;   ToolTip, %var_string%
;   SetTimer, RemoveTip, 1000
;   return
; RemoveTip:
;   SetTimer, RemoveTip, Off
;   ToolTip
;   return
    
    ;��ʽ������Ļ�м���ʾ
    ;SplashTextOn, , , %var_string%
    ;Sleep, 1000
    ;SplashTextOff
}

; ���п�ݷ�ʽ˵��
; win+h  �������Ͱ
; win+x  �Թ���Ա��ʽ����������
; win+m  ��foxmail
; win+t  ��total commander
; win+g  ��cmder��ԭΪgitbash�����Կ�ݼ�Ϊg
; win+w  ��Ϊ֪�ʼ�
; win+b  �������
; win+c  ��tc����Ϊ�ύsvn����
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

        IfWinActive, �����ļ���Ϣ
        {
            ControlGetText, docUrl, Edit3, 
            SplitPath, docUrl ,fileName
            
            ; �ܱ�
            IfInString, fileName, �ܱ�
            {
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Documents\�����ĵ�\�ܱ�\%fileName%
                ClipWait 
                Send ^v
                return
            }
            
            ; �±�
            IfInString, fileName, �±�
            {
                ControlClick , Edit3, , , , , x102 y93, , 
                Clipboard = 
                Clipboard = F:\Documents\�����ĵ�\�±�\%fileName%
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���뿪ʼ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#h::FileRecycleEmpty

#x::
send,#xa
return

; ����Foxmail������Ѿ������������
#m::
IfWinNotExist  ahk_exe Foxmail.exe
    Run "D:\Program Files\Foxmail 7.2\Foxmail.exe", , Max
Else 
IfWinNotActive  ahk_exe Foxmail.exe
    WinActivate 
Else 
    WinClose ; ʹ��ǰ���ҵ��Ĵ��� 
Return 

; ����tc������Ѿ������������
#t::
IfWinNotExist  ahk_class TTOTAL_CMD, 
    Run "D:\Program Files\TotalCMD64\Totalcmd64.exe", , Max
Else 
IfWinNotActive ahk_class TTOTAL_CMD, 
    WinActivate 
Else 
    WinMinimize 
Return 

;����cmder
#g::
IfWinNotExist ahk_exe ConEmu.exe
    Run "D:\cmder\Cmder.exe", , Max
Else 
IfWinNotActive ahk_exe ConEmu.exe
    WinActivate 
Else 
    WinMinimize 
Return

; ����Ϊ֪�ʼǣ�����Ѿ������������
#w::
IfWinNotExist  ahk_class WizNoteMainFrame
    Run "D:\Program Files (x86)\WizNote\Wiz.exe", , Max
Else 
IfWinNotActive ahk_class WizNoteMainFrame
    WinActivate 
Else 
    WinMinimize 
Return 

; ���������������Ѿ������������
#b::
IfWinNotExist  ahk_class Chrome_WidgetWin_1
    Run "D:\CentBrowser\chrome.exe", , Max
Else 
IfWinNotActive ahk_class Chrome_WidgetWin_1
    WinActivate 
Else 
    WinMinimize 
Return 

; ����source insight������Ѿ������������
#s::
IfWinNotExist ahk_class si_Frame 
    Run "D:\Program Files (x86)\Source Insight 3\Insight3.Exe"
Else 
IfWinNotActive ahk_class si_Frame 
    WinActivate 
Else 
    WinMinimize 
Return 

; ����outlook������Ѿ������������
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

; SVN�ύ
#c::
if WinActive("Total Commander")
{
    Send {F12}
    Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:commit /path:"%clipboard%"
}
Return

;ahk_class #32770
;ahk_exe TortoiseProc.exe
; SVN����
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

; �ر�shit+�ո� ���°���л�
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

;; win+f
#f::
IfWinNotActive ahk_class EVERYTHING
    Send ^+{F12}
Return 
