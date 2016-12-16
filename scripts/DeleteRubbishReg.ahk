Loop, %0%  ; For each parameter:
  {
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
 
if not A_IsAdmin
{
    If A_IsCompiled
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
    Else
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
    ExitApp
}

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

; 不显示图标~
Menu, Tray, NoIcon