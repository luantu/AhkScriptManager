;在鼠标处，显示小提示
MouseShowTips(var_string)
{
    ToolTip, Tips, 10, 10
    #Persistent
    ToolTip, %var_string%
    SetTimer, RemoveTip, 1000
    return
  RemoveTip:
    SetTimer, RemoveTip, Off
    ToolTip
    return
}

;屏幕中间显示
ScreenShowTips(var_string)
{
	Progress, Hide
	Progress, zh0 fs12 B ZX0 cb70a704 ct222222 cw70a704 y1045, %var_string%, , , Microsoft YaHei UI
	Sleep, 1500
	Progress, Hide
}