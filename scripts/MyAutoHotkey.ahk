#Include ../lib/MyToolTips.ahk

; ����ʾͼ��~
Menu, Tray, NoIcon

ScreenShowTips("My Hotkey Mapping actived")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���뿪ʼ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;win+h �������Ͱ
#h::FileRecycleEmpty

; win+x  �Թ���Ա��ʽ����������
#x::
send,#xa
return

; ����Foxmail������Ѿ������������
; #m::
; IfWinNotExist  ahk_exe Foxmail.exe
;     Run "D:\Program Files\Foxmail 7.2\Foxmail.exe", , Max
; Else 
; IfWinNotActive  ahk_exe Foxmail.exe
;     WinActivate 
; Else 
;     WinClose ; ʹ��ǰ���ҵ��Ĵ��� 
; Return 

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

; ����sublime������Ѿ������������
;#s::
;IfWinNotExist ahk_exe sublime_text.exe 
;    Run "D:\Program Files\Sublime Text 3\sublime_text.exe"
;Else 
;IfWinNotActive ahk_exe sublime_text.exe
;    WinActivate 
;Else 
;    WinMinimize 
;Return 

; ����outlook������Ѿ������������
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

; SVN�ύ
#c::
if WinActive("Total Commander")
{
    Send {F12}
    Run "D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:commit /logmsg:"update" /path:"%clipboard%" /closeonend:3
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

; �ر����İ��
; �ر�shit+�ո� ���°���л�
+Space::
return

+Del::
If WinActive("ahk_class TFoxMainFrm.UnicodeClass") or WinActive("ahk_class rctrl_renwnd32") 
{
    ; SHIFT+DELETE��ʾ����ȷ��
    MsgBox, 4, ��׼��ɾ�ʼ�, (#^.^#)������ȷ���Ƿ񳹵�ɾ��ѡ���ʼ�, 10  ; 5 ��ĳ�ʱʱ��.
    IfMsgBox, No
        Return  ; �û������ "No" ��ť.
    IfMsgBox, Timeout
        Return ; ���ڳ�ʱʱ�������� "No".
    ; ����, ����:
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
