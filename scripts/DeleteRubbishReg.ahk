Loop, %0%  ; For each parameter:
  {
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"

;; �Թ���ԱȨ������
if not A_IsAdmin
{
    If A_IsCompiled
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
    Else
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
    ExitApp
}

;ɾ���Ҽ�ʹ��windows defenderɨ��
RegDelete, HKEY_CLASSES_ROOT, *\shellex\ContextMenuHandlers\EPP,
RegDelete, HKEY_CLASSES_ROOT, Drive\shellex\ContextMenuHandlers\EPP,
RegDelete, HKEY_CLASSES_ROOT, Directory\shellex\ContextMenuHandlers\EPP,
;ɾ������
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\*\shellex\ContextMenuHandlers\Sharing,
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\Sharing,
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\Sharing,
;ɾ���̶�����ʼ�˵�
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\PintoStartScreen,

;���������ѽ��
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\batfile\shellex\ContextMenuHandlers\Compatibility,
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\exefile\shellex\ContextMenuHandlers\Compatibility,

;��������
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\Library Location,

;ɾ���ҵĵ��Ե���Щ�ļ���
; ����
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f},
; ����
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de},
; ͼƬ
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8},
; ����
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641},
; �ĵ�
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af},
; ��Ƶ
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ɾ�������Ҽ���ʾ����ݷ�ʽ
RegDelete, HKEY_CLASSES_ROOT, Directory\Background\shellex\ContextMenuHandlers\igfxcui

;����myChromeΪĬ��html�򿪷�ʽ
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, ChromeHTML.77YFJP5HJD5VZSM3X3AK2FMTCQ\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, htmlfile\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, http\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, https\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;�޸���ʾ�����С
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, MenuFont,f1ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, CaptionFont,f1ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, SmCaptionFont,f1ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000

; ����ʾͼ��~
Menu, Tray, NoIcon