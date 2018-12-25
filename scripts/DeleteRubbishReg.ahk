Loop, %0%  ; For each parameter:
  {
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"

;; 以管理员权限运行
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

;删除svn在垃圾回收站的选项
RegDelete, HKEY_CLASSES_ROOT, Folder\shellex\ContextMenuHandlers\TortoiseSVN

;删除右键在visual studio打开选项
RegDelete, HKEY_CLASSES_ROOT, Directory\Background\shell\AnyCode
RegDelete, HKEY_CLASSES_ROOT, Directory\shell\AnyCode

;删除固定到快速访问
RegDelete, HKEY_CLASSES_ROOT, Folder\shell\pintohome

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
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a},
; 3d对象
RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;删除桌面右键显示器快捷方式
RegDelete, HKEY_CLASSES_ROOT, Directory\Background\shellex\ContextMenuHandlers\igfxcui
RegDelete, HKEY_CLASSES_ROOT, Directory\Background\shellex\ContextMenuHandlers\igfxDTCM

;保持myChrome为默认html打开方式
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, ChromeHTML.77YFJP5HJD5VZSM3X3AK2FMTCQ\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, htmlfile\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, http\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, https\shell\open\command, ,`"D:\CentBrowser\chrome.exe`" -- `"`%1`"

;保持位置笔记关闭dw
RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Run, 为知笔记, `"D:\Program Files (x86)\WizNote\Wiz.exe`" --disable-direct-write /background

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;修改显示字体大小
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, MenuFont,f2ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, CaptionFont,f2ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, SmCaptionFont,f2ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000
RegWrite, REG_BINARY, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, IconFont,f2ffffff0000000000000000000000009001000000000001000005004d006900630072006f0073006f006600740020005900610048006500690020005500490000000000000000000000000000000000000000000000000000000000

TrayTip,MyAutoHotkey, RubbishReg Deleted.,2,1

; 不显示图标~
Menu, Tray, NoIcon
