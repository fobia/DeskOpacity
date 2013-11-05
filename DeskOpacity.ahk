#NoEnv                 ;�������� �������� ��� ������ ����������, �� �������� �� ��� ����������� ��������� (������������� ��� ���� ����� ��������).
#SingleInstance force  ;����������, ��������� �� ������� ����������� �����, ���� �� ��� �����������.
#InstallKeybdHook      ;���������� ������ � ����������� ��������� ���� ����������.
#InstallMouseHook      ;���������� ������ � ����������� ��������� ���� ����.
#Persistent            ;������ ������ ��������� ������������� (�.�. �� ��� ���, ���� ������������ �� ������� ��� ��� ���� �� ���������� ������� ExitApp).

;-----------------------------------------------------
Menu, tray, NoStandard
Menu, tray, add, DeskOpacity, MenuHandler ; �������� ����� �����.
Menu, tray, add  ; �������� �����������.
Menu, tray, add, Exit, ExitHandler  ; �������� ����� �����.
return

MenuHandler:
	MsgBox DeskOpacity`n`nWin+o `t`t ������������ ���� 100 (���/����)`nWin+i `t`t ������ ���� ���� (���/����)`nWin+Alt+NumAdd `t �������� ������������ +16 (max: 255)`nWin+Alt+NumSub `t ������ ������������ -16 (min: 50)
return

ExitHandler:
	ExitApp
return
;-----------------------------------------------------


SendMode Input          ; ����� ����� ������� ��� �������� � ���������� ����������
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

#o:: ; ������� Win+O, ����� ��������� ������������ ���� ��� �������� ����.
     ; ������ ������ ���� �� ������� ����� ����.
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
#g:: ; ������� Win+G, ����� ���������� ������� ��������� ���� ��� �������� ����.
     ; ������ ������ ���� �� ������� ����� ����.
	MouseGetPos,,, MouseWin
	WinGet, Transparent, Transparent, ahk_id %MouseWin%
	WinGet, TransColor, TransColor, ahk_id %MouseWin%
	ToolTip ������������:`t%Transparent%
	Sleep, 3000
	ToolTip
return
*/

/*
SetTitleMatchMode, 2    ; ���������� � ����� ������ ��������� ����
*/
