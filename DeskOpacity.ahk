#NoEnv                 ;Отменяет проверку для пустых переменных, не являются ли они переменными окружения (рекомендуется для всех новых скриптов).
#SingleInstance force  ;Определяет, разрешено ли скрипту запускаться снова, если он уже выполняется.
#InstallKeybdHook      ;Принуждает скрипт к безусловной установке хука клавиатуры.
#InstallMouseHook      ;Принуждает скрипт к безусловной установке хука мыши.
#Persistent            ;Делает скрипт постоянно выполняющимся (т.е. до тех пор, пока пользователь не закроет его или пока не встретится команда ExitApp).

;-----------------------------------------------------
Menu, tray, NoStandard
Menu, tray, add, DeskOpacity, MenuHandler ; Добавить новый пункт.
Menu, tray, add  ; Добавить разделитель.
Menu, tray, add, Exit, ExitHandler  ; Добавить новый пункт.
return

MenuHandler:
	MsgBox DeskOpacity`n`nWin+o `t`t прозрачность окна 100 (вкл/выкл)`nWin+i `t`t поверх всех окон (вкл/выкл)`nWin+Alt+NumAdd `t добавить прозрачность +16 (max: 255)`nWin+Alt+NumSub `t убрать прозрачность -16 (min: 50)
return

ExitHandler:
	ExitApp
return
;-----------------------------------------------------


SendMode Input          ; новый режим высылки без задержки и повышенной надежности
DetectHiddenWindows, on


#!NumpadAdd::
	MouseGetPos,,, MouseWin
	WinGet, TValue, Transparent, ahk_id %MouseWin%
	if (!TValue) {
		TValue = 255
	}
	TValue += 16
	if (TValue >= 255) {
		TValue = 255
	}
	WinSet, Transparent, %TValue%, ahk_id %MouseWin%
	if (TValue == 255) {
		WinSet, Transparent, Off, ahk_id %MouseWin%
	}
return

#!NumpadSub::
	MouseGetPos,,, MouseWin
	WinGet, TValue, Transparent, ahk_id %MouseWin%
	if (!TValue) {
		TValue = 255
	}
	TValue -= 16
	if (TValue <= 50) {
		TValue = 50
	}
	WinSet, Transparent, %TValue%, ahk_id %MouseWin%
return

#o:: ; Нажмите Win+O, чтобы отключить прозрачность окна под курсором мыши.
     ; Курсор должен быть на видимой части окна.
	MouseGetPos,,, MouseWin
	WinGet, TCheck, Transparent, ahk_id %MouseWin%
	if (!TCheck) {
		TCheck = 255
	}
	if (TCheck < 255) {
		WinSet, Transparent, 255, ahk_id %MouseWin%
		WinSet, Transparent, Off, ahk_id %MouseWin%
	} else {
		WinSet, Transparent, 150, ahk_id %MouseWin%
	}
return

#i::
	MouseGetPos,,, MouseWin
	WinSet, AlwaysOnTop, Toggle, ahk_id %MouseWin%
return

/*
#g:: ; Нажмите Win+G, чтобы посмотреть текущие настройки окна под курсором мыши.
     ; Курсор должен быть на видимой части окна.
	MouseGetPos,,, MouseWin
	WinGet, Transparent, Transparent, ahk_id %MouseWin%
	WinGet, TransColor, TransColor, ahk_id %MouseWin%
	ToolTip Прозрачность:`t%Transparent%
	Sleep, 3000
	ToolTip
return
*/

/*
SetTitleMatchMode, 2    ; сравнивать с любой частью заголовка окна
*/
