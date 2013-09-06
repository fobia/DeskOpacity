#NoTrayIcon
#NoEnv
#SingleInstance,off
settitlematchmode, slow
settitlematchmode, 1
SetBatchLines, -1
detecthiddentext, on
coordmode, caret, relative
fileinstall, com.txt, %A_ScriptDir%\com.txt
fileinstall, vars.txt, %A_ScriptDir%\vars.txt
fileread, Commands, %A_ScriptDir%\com.txt
fileread, Variables, %A_ScriptDir%\vars.txt
SizeOfStructForChooseFont = 60 
OffsetToFontFaceName = 28 
SizeOfFontFaceName = 32 
SizeOfStructForLogFont := OffsetToFontFaceName + SizeOfFontFaceName 
SetWorkingDir,%A_ScriptDir%
VarSetCapacity(StructForChooseFont, SizeOfStructForChooseFont, 0) 
VarSetCapacity(StructForLogFont, SizeOfStructForLogFont)  ; No need to zero it
InsertInteger(SizeOfStructForChooseFont, StructForChooseFont, 0)  ; DWORD lStructSize
GuiHWND := WinExist()  ; Relies on the line above to get the unique ID of GUI window. 
InsertInteger(GuiHWND, StructForChooseFont, 4)  ; HWND hwndOwner (makes dialog "modal"). 
InsertInteger(&StructForLogFont, StructForChooseFont, 12)  ; LPLOGFONT lpLogFont 
InsertInteger(0x101, StructForChooseFont, 20) 
IfNotExist,%A_ScriptDir%\config.cfg
FileAppend,Comic Sans MS`n12`n0x0`n1`n0`n0`n0`n1`n%ahk_dir%\AutoHotkey.exe`n0,%A_ScriptDir%\config.cfg
FileReadLine,FontFace,%A_ScriptDir%\config.cfg,1
FileReadLine,FontSize,%A_ScriptDir%\config.cfg,2
FileReadLine,FColor,%A_ScriptDir%\config.cfg,3
FileReadLine,Avto,%A_ScriptDir%\config.cfg,4
FileReadLine,MmWin,%A_ScriptDir%\config.cfg,5
FileReadLine,Vertik,%A_ScriptDir%\config.cfg,6
FileReadLine,Goriz,%A_ScriptDir%\config.cfg,7
FileReadLine,ViewNumber,%A_ScriptDir%\config.cfg,8
FileReadLine,SelectIco,%A_ScriptDir%\config.cfg,9
FileReadLine,Reg,%A_ScriptDir%\config.cfg,10
FileReadLine,root_dir,%A_ScriptDir%\config.cfg,12
IfNotExist,%root_dir%
root_dir= %A_ScriptDir%
FileReadLine,LastFile1,%A_ScriptDir%\config.cfg,13
FileReadLine,LastFile2,%A_ScriptDir%\config.cfg,14
FileReadLine,LastFile3,%A_ScriptDir%\config.cfg,15

Reg2= 1
LanG= r
SelectDrive= 0
Clip1= 
CliP= 0
ZagScr=
ZagScr2=
NumEdit= 0
Razdel= 0
StatRed= 0
StatRed2= 0
StatEd= 0
Saved= 1
Shet= 0
Position= 0
Command1=
NewVar= 0
NewLabel= 0
ifing= 0
InserT=0
LangName= RU
ContentVars= |
LabelS= 
HotkeyS=
MySearch=
ItemFile= Безымянный.ahk
CarX= %A_CaretX%
CarY= %A_CaretY%
MyEdit= %a_spase%
loop, parse, Commands, `n
{
if A_Loopfield=
break
Stringsplit, ComArray, A_Loopfield, %A_Tab%
Command= %Command%%ComArray1%|
}
gui, +resize MinSize
EdHeight= 207
gui, add, edit, w585 h%EdHeight% +HScroll -Wrap vMyEdit gRazreshit HwndMyEditID,
gui, add, combobox, vCommand1 R5 w130 Sort Simple gPravka,  %Command%
gui, add, Groupbox, w587 h60, Комментарии
gui, add, text, xp+5 yp+15 w575 h40 gTX,
gui, add, button, default, Добавить
gui, add, groupbox, xp+130 yp-160 w452 h100, Параметры
nomer= 1
gui, add, text, xp+7 yp+42 w88 gTX1 0xC 0x1000,
gui, add, edit, xp yp-26 w90 h23 vEd%nomer%,
gui, add, checkbox, xp yp w20 hp vCh%nomer%,
gui, add, dropdownlist, xp yp w90 hp R2 vddl%nomer% gDL1,
loop, 4
{
nomer:= nomer+1
gui, add, text, xp+88 yp+26 w87 gTX1 0xC 0x1000,
gui, add, edit, xp-1 yp-26 w90 h23 vEd%nomer%,
gui, add, checkbox, xp yp w20 hp vCh%nomer%,
gui, add, dropdownlist, xp yp w90 hp R2 vddl%nomer% gDL%nomer%,
}
nomer:= nomer+1
gui, add, text, xp-347 yp+68 w87 gTX1 0xC 0x1000,
gui, add, edit, xp-1 yp-26 w90 h23 vEd%nomer%,
gui, add, checkbox, xp yp w20 hp vCh%nomer%,
gui, add, dropdownlist, xp yp w90 hp R2 vddl%nomer% gDL%nomer%,
loop, 4
{
nomer:= nomer+1
gui, add, text, xp+88 yp+26 w87 gTX1 0xC 0x1000,
gui, add, edit, xp-1 yp-26 w90 h23 vEd%nomer%,
gui, add, checkbox, xp yp w20 hp vCh%nomer%,
gui, add, dropdownlist, xp yp w90 hp R2 vddl%nomer%,
}
gui, add, button, x87 y376, Вставить
gui, add, dropdownlist, xp+70 yp w193 gSelVars vVars, Переменные|В этом скрипте|Специальные символы|Свойства скрипта|Дата и время|Настройки скрипта|Простой в работе|Окна GUI и строки меню|Hotkeys, Hotstrings и пункты меню|OS и user|Цикл|Прочее
gui, add, dropdownlist, xp+195 yp w143 Sort vSelectVars gItemVar,
gui, add, checkbox, xp+145 yp vContVar, Содержимое
Menu, HelpMenu, Add, Autohotkey Help %a_tab%ctrl+F1, Help
Menu, HelpMenu, Add, Window Spy %a_tab%ctrl+F2, WindowSpy
RegRead, ahk_dir, HKEY_LOCAL_MACHINE, SOFTWARE\AutoHotkey, InstallDir
if ErrorLevel <> 0  
	ahk_dir = %A_ProgramFiles%\AutoHotkey
IfNotExist %ahk_dir%
{
	ahk_dir=
	Filereadline, ahk_dir, %A_ScriptDir%\config.cfg, 11
	if ahk_dir=
	MsgBox, 4, Не найдена папка AutoHotkey, Рабочая папка AutoHotkey не найдена.`n"Да" - выбрать папку вручную`n"Нет" - работать без вспомогательных файлов
	else
	goto ComfWork
	IfMsgBox Yes
	{
	ahk_dir=
	FileSelectFolder,ahk_dir,,,Выбор рабочей папки AutoHotkey
	if ahk_dir<>
	goto ComfWork
	}
	Menu, HelpMenu, disable, Autohotkey Help %a_tab%ctrl+F1
	Menu, HelpMenu, disable, Window Spy %a_tab%ctrl+F2
}
ComfWork:
ahk_help_file = %ahk_dir%\AutoHotkey.chm
IfExist,%ahk_dir%\AU3_SpyMy.exe
ahk_win_spy = %ahk_dir%\AU3_SpyMy.exe
Else
ahk_win_spy = %ahk_dir%\AU3_Spy.exe
IfExist,%ahk_dir%\SmartGUI.exe
{
Menu, HelpMenu, Add, SmartGUI %a_tab%ctrl+F3, SmartGUI
ahk_smart_gui = %ahk_dir%\SmartGUI.exe
}
else IfExist,%A_ScriptDir%\SmartGUI.exe
{
Menu, HelpMenu, Add, SmartGUI %a_tab%ctrl+F3, SmartGUI
ahk_smart_gui = %A_ScriptDir%\SmartGUI.exe
}
if A_IsCompiled =
Menu, HelpMenu, Add, Отладка %a_tab%ctrl+F4, Remont
else 
ifexist, %A_ScriptDir%\ScriptCreater.ahk
Menu, HelpMenu, Add, Отладка %a_tab%ctrl+F4, Remont
Menu,RegMenu,add,в меню проводника,SetReg
Menu,RegMenu,add,в панели быстрого запуска,SetQuick
Menu,RegMenu,add,на рабочем столе,SetDesktop
if A_IsCompiled=
{
;Menu,RegMenu,disable,в панели быстрого запуска
Menu,RegMenu,disable,в меню проводника
;Menu,RegMenu,disable,на рабочем столе
}
else
{
Loop,HKCR,AutoHotkeyScript\Shell,2
{
If A_LoopRegName= Править_в_ScriptCreater
Reg= 1
}
if Reg= 0
{
MsgBox,4,Первый запуск,Включить в контекстное меню скриптов`n пункт "Править в ScriptCreater"?
IfMsgBox Yes
gosub SetReg
else
Reg= 0
}
else
Menu,RegMenu,check,в меню проводника
}
IfExist,%A_AppData%\Microsoft\Internet Explorer\Quick Launch\ScriptCreater.lnk
Menu,RegMenu,check,в панели быстрого запуска
IfExist,%A_Desktop%\ScriptCreater.lnk
Menu,RegMenu,check,на рабочем столе
Menu, HelpMenu, Add, Поддержка..., :RegMenu
Menu, SaveMenu, Add, ahk script, SavingAs
IfExist,%ahk_dir%\Compiler\Ahk2Exe.exe
Menu, SaveMenu, Add, приложение exe, SavingAsExe
Menu, EditMenu, Add, Отменить %A_Tab%Ctrl+Z, Undo
Menu, EditMenu, disable, Отменить %A_Tab%Ctrl+Z
Menu, EditMenu, Add, Повторить %A_Tab%Shift+Ctrl+Z, Redo
Menu, EditMenu, disable, Повторить %A_Tab%Shift+Ctrl+Z
Menu, EditMenu, Add,
Menu, EditMenu, Add, В&ырезать %A_Tab%Ctrl+X, Cut
Menu, EditMenu, Add, &Копировать %A_Tab%Ctrl+C, Copy
Menu, EditMenu, Add, &Вставить %A_Tab%Ctrl+V, Paste
Menu, EditMenu, disable, &Вставить %A_Tab%Ctrl+V
Menu,PastMenu,add,переменную%A_Tab%Ctrl+W, PasteVar
Menu,PastMenu,add,блок%A_Tab%Ctrl+B, PasteBlock
Menu,PastMenu,add,метку%A_Tab%Ctrl+M, PasteLabel
Menu,PastMenu,add,строку%A_Tab%Ctrl+Q, PasteCom
Menu, EditMenu, Add, Вставить как..., :PastMenu
Menu, EditMenu, disable, Вставить как...
Menu, EditMenu, Add, &Удалить %A_Tab%Del, Deleting
Menu, EditMenu, Add,
Menu, EditMenu, Add, Найти %A_Tab%Ctrl+F, Find
Menu, EditMenu, disable, Найти %A_Tab%Ctrl+F
Menu, EditMenu, Add, Заменить %A_Tab%Ctrl+P, Replase
Menu, EditMenu, disable, Заменить %A_Tab%Ctrl+P
Menu, EditMenu, Add, Редактировать %A_Tab%Ctrl+E, Redact
Menu,JumpMenu,add,метку выше%A_Tab%Ctrl+PgUp, Prygok
Menu,JumpMenu,add,метку ниже%A_Tab%Ctrl+PgDn, Prygok2
Menu, EditMenu, Add, Перейти на..., :JumpMenu
Menu, EditMenu, Add,
Menu, EditMenu, Add, Вы&делить все %A_Tab%Ctrl+A, Selectall
Menu, EditMenu, disable, Вы&делить все %A_Tab%Ctrl+A
Menu, FileMenu, Add, Создать %A_Tab%Ctrl+N, Creating
Menu, FileMenu, Add, Создать в новом окне %A_Tab%Shift+Ctrl+N, CreatingNW
if root_dir<>
{
SplitPath,root_dir,Root
gosub CreateMenu
}
Menu,NavigMenu,add,Выбор корневой папки,SelRootDir
Menu, FileMenu, Add, Навигатор, :NavigMenu
Menu, FileMenu, Add, &Открыть... %A_Tab%Ctrl+O, Opening
IfExist,%ahk_dir%\Exe2Ahk.exe
Menu, FileMenu, Add, Открыть exe, OpeningExe
else IfExist,%A_ScriptDir%\Exe2Ahk.exe
Menu, FileMenu, Add, Открыть exe, OpeningExe
Menu, FileMenu, Add, &Сохранить %A_Tab%Ctrl+S, Saving
Menu, FileMenu, disable, &Сохранить %A_Tab%Ctrl+S
Menu, FileMenu, Add, Со&хранить как..., :SaveMenu
Menu, FileMenu, disable, Со&хранить как...
Menu, FileMenu, Add, 
Menu, FileMenu, Add, В&ыход, Exing
if LastFile1<>
{
IfExist,%LastFile1%
Menu, FileMenu, Add, 
else IfExist,%LastFile2%
Menu, FileMenu, Add, 
else IfExist,%LastFile3%
Menu, FileMenu, Add, 
SplitPath,LastFile1, OutFile1
IfExist,%LastFile1%
Menu,FileMenu,add,%OutFile1%,LastFile1
else
LastFile1=
}
if LastFile2<>
{
SplitPath,LastFile2, OutFile2
IfExist,%LastFile2%
Menu,FileMenu,add,%OutFile2%,LastFile2
else
LastFile2=
}
if LastFile3<>
{
SplitPath,LastFile3, OutFile3
IfExist,%LastFile3%
Menu,FileMenu,add,%OutFile3%,LastFile3
else
LastFile3=
}
Menu, FontMenu, Add, Шрифт..., SelFont
Menu, FontMenu, Add, Номер строки, ViewNumber
if ViewNumber= 1
Menu,FontMenu,check,Номер строки
Menu,ParaMenu,add, Заголовок окна, GetTitle2
Menu,ParaMenu,add, Класс окна, GetClass2
Menu,ParaMenu,add, Контрол, GetControl2
Menu,ParaMenu,add, Текст, GetText2
Menu,ParaMenu,add, Выбрать цвет, GetColor2
Menu,ParaMenu,add, Имя процесса, GetPIDname
Menu,ParaMenu,add, PID процесса, GetPIDnum
Menu, ServMenu, Add, Метки %A_Tab%Ctrl+L, SelLab
Menu, ServMenu, disable, Метки %A_Tab%Ctrl+L
Menu, ServMenu, Add, Hotkeys %A_Tab%Ctrl+H, SelHtk
Menu, ServMenu, disable, Hotkeys %A_Tab%Ctrl+H
Menu, ServMenu, Add, Вставка параметра, :ParaMenu
RunName= Выполнить...%A_Tab%Ctrl+R
Menu, ServMenu, Add, %RunName%, Running
Menu, ServMenu, disable, %RunName%
Menu,ServMenu,add,Выгрузить %A_Tab%Ctrl+Alt+Win+f12,UnLoad
Menu, ServMenu, disable, Выгрузить %A_Tab%Ctrl+Alt+Win+f12
Menu, MyContextMenu, add, ahk_class, GetClass
Menu, MyContextMenu, add, заголовок, GetTitle
Menu, ColorMenu, add, выбрать, GetColor
Menu, ColorMenu, add, задать, SetColor
Menu,VstMenu,add,Return,Returnpast
Menu,VstMenu,add,Exit,Exitpast
Menu,VstMenu,add,ExitApp,ExitApppast
Menu,VstMenu,add,GuiClose,GuiClosepast
Menu,VstMenu,add,GuiSize,GuiSizepast
Menu,VstMenu,add,GuiContextMenu,GuiContextpast
Menu,VstMenu,add,GuiEscape,GuiEscapepast
Menu,VstMenu,add,NoActivate,NoActivatepast
Menu,VstMenu,add,AlwaysOnTop,AlwaysOnToppast
Menu,VstMenu,add,OwnDialogs,OwnDialogspast
Menu,VstMenu,add,LastFound,LastFoundpast
Menu,VstMenu,add,Caption,Captionpast
Menu,VstMenu,add,MaximizeBox,Maximizepast
Menu,VstMenu,add,MinimizeBox,Minimizepast
Menu,VstMenu,add,SysMenu,SysMenupast
Menu,VstMenu,add,Border,Borderpast
Menu,VstMenu,add,Default,Defaultpast
Menu,VstMenu,add,ToolWindow,ToolWindowpast
Menu,VstMenu,add,BackgroundTrans,BackgroundTranspast
Menu,VstMenu,color,0xFFFFFF
Menu, MyMenuBar, Add, &Файл, :FileMenu  
Menu, MyMenuBar, Add, &Правка, :EditMenu
Menu, MyMenuBar, Add, Формат, :FontMenu
Menu, MyMenuBar, Add, Се&рвис, :ServMenu
Menu, MyMenuBar, Add, Вс&тавка, :VstMenu
Menu, MyMenuBar, Add, По&мощь, :HelpMenu
Menu, MyMenuBar, Add, %LangName%, Lang
Gui, Menu, MyMenuBar
gui, show, , ScriptCreater - Безымянный.ahk
GUI,add,text, x4 y0 w5 h403 0x11 gVertik
GUI,add,text, x602 y0 w2 h403 0x11 gVertik
GUI,add,text, x5 y403 w600 h3 0x10 gGoriz
GUI,add,text,x470 y199 w80 h16 backgroundtrans, Строка №1
GUI,add,ddl,xp+104 yp-2 w18 h18 
GUI,add,Text,xp yp+2 wp hp-7 0x1 backgroundtrans gPrygok,
Gui, Font, s10 , Microsoft Sans Serif
GuiControl, Font, Static16
GuiControl,Hide,ComboBox14
if ViewNumber= 0
GuiControl,Hide,Static15
WinGet,ScriptCreater,ID,ScriptCreater
ControlGetPos,,Ystyle,,,Edit1,ahk_id %ScriptCreater%
PosforStyle:= 402 + Ystyle
gosub Razmeshenie
if MmWin> 0
WinMaximize,ahk_id %ScriptCreater%
else
{
if Vertik= 1
{
Vertik= 0
gosub Vertik
}
if Goriz= 1
{
Goriz= 0
gosub Goriz
}
sleep, 300
}
Gui, Font, s%FontSize% , %FontFace%
GuiControl, Font, Edit1
Gosub,SelColFont
Xparam= 0
Loop %0% ; Для каждого параметра (или файла, перетащенного на скрипт):
{
Xparam:= Xparam + 1
	GivenPath := %A_Index% ; Извлекаем содержимое переменной, имя которой содержится в A_Index.
	Loop %GivenPath%
		LongPath = %A_LoopFileLongPath%
SplitPath,LongPath, OutFileName
if A_Index= 1
	{
	ItemFile= %LongPath%
	Saved= 0
	gosub ClearRun2
	}
else
	{
	Run,%A_ScriptFullPath% "%LongPath%"
	WinWait, ScriptCreater - %OutFileName%
	}
}
settimer, Otobr, 500
settimer, Otobr, on
Skrytie:
guicontrol, ChooseString, combobox12, Переменные
guicontrol,, combobox13, |
guicontrol, hide, combobox13, 
guicontrol,, button15, 0
guicontrol, hide, button15
numb= 2
loop, 10
{
guicontrol, hide, combobox%numb%, 
numb:= numb+1
numb1:= numb+1
guicontrol, hide, Edit%numb%, 
guicontrol, hide, button%numb1%, 
}
guicontrol,, button15, 0
guicontrol, hide, button15
guicontrol, disable, Добавить
guicontrol, disable, Вставить
return

Razmeshenie:
WinGet, WinList, ControlList, ahk_id %ScriptCreater%
ListPos= 
CoordMode,Pixel,Relative
loop, parse, WinList, `n
{
ControlGetPos, Xcon, Ycon, Wcon, Hcon, %a_loopfield%, ahk_id %ScriptCreater%
if ListPos= 
ListPos= %a_loopfield%-%Xcon%-%Ycon%-%Wcon%-%Hcon%-%A_Index%
else
ListPos= %ListPos%`n%a_loopfield%-%Xcon%-%Ycon%-%Wcon%-%Hcon%-%A_Index%
}
return

Vertik:
WinGet,MinM,MinMax,ahk_id %ScriptCreater%
if MinM= 1
Return
settimer, Otobr, off
WinGetPos,, Ytray,,,ahk_class Shell_TrayWnd
if Vertik=0
{
WinMove,ahk_id %ScriptCreater%,,,0,,%Ytray%
Vertik=1
}
else
{
Ynew:= (A_ScreenHeight - 451)/2
WinMove,ahk_id %ScriptCreater%,,,%Ynew%,,451
Vertik=0
}
settimer, Otobr, on
Return

Goriz:
WinGet,MinM,MinMax,ahk_id %ScriptCreater%
if MinM= 1
Return
settimer, Otobr, off
if Goriz= 0
{
WinMove,ahk_id %ScriptCreater%,,0,,%A_ScreenWidth%
Goriz= 1
}
else
{
Xnew:= (A_ScreenWidth - 615)/2
WinMove,ahk_id %ScriptCreater%,,%Xnew%,,615
Goriz= 0
}
settimer, Otobr, on
Return

Lang:
ControlGetFocus,Focus,ahk_id %ScriptCreater%
StringLeft,TipCon,Focus,4
Selected=
if TipCon= Edit
{
if Focus<> Edit2
ControlGet,Selected,Selected,,%Focus%,ahk_id %ScriptCreater%
}
if LangName= EN
{
Menu,MyMenuBar,rename,%LangName%,RU
LangName= RU
Critical
PostMessage, 0x50, 0, 0x4190419,, ahk_id %ScriptCreater%
if Selected<>
Send, %Selected%
Critical,Off
Return
}
Menu,MyMenuBar,rename,%LangName%,EN
LangName= EN
Critical
PostMessage, 0x50, 0, 0x4090409,, ahk_id %ScriptCreater%
if Selected<>
Send, %Selected%
Critical,Off
Return

ViewNumber:
if ViewNumber=0
{
ViewNumber= 1
GuiControl,Show,Static15
Menu,FontMenu,check,Номер строки
}
else
{
ViewNumber= 0
GuiControl,Hide,Static15
Menu,FontMenu,uncheck,Номер строки
}
Return

SetReg:
if Reg= 0
{
Menu,RegMenu,check,в меню проводника
RegWrite,REG_SZ,HKCR,AutoHotkeyScript\Shell\Править_в_ScriptCreater,,Править в ScriptCreater
RegWrite,REG_SZ,HKCR,AutoHotkeyScript\Shell\Править_в_ScriptCreater\command,,"%A_ScriptFullPath%" "`%1`%"
RegWrite,REG_SZ,HKCR,AutoHotkeyScript\Shell\Править_в_ScriptCreater\ddeexec
RegWrite,REG_SZ,HKCR,AutoHotkeyScript\Shell\Править_в_ScriptCreater\ddeexec\Application,,ScriptCreater
RegWrite,REG_SZ,HKCR,AutoHotkeyScript\Shell\Править_в_ScriptCreater\ddeexec\Topic,,System
Reg= 1
Loop,HKCR,AutoHotkeyScript\Shell,2
{
If A_LoopRegName= Править_в_ScriptCreater
Reg= 2
}
if Reg= 1
MsgBox Недостаточно прав доступа`nдля редактирования реестра!
}
else
{
Menu,RegMenu,uncheck,в меню проводника
RegDelete,HKCR,AutoHotkeyScript\Shell\Править_в_ScriptCreater
Reg= 0
}
Return

SetQuick:
IfExist,%A_AppData%\Microsoft\Internet Explorer\Quick Launch\ScriptCreater.lnk
{
FileDelete,%A_AppData%\Microsoft\Internet Explorer\Quick Launch\ScriptCreater.lnk
Menu,RegMenu,uncheck,в панели быстрого запуска
}
else
{
FileCreateShortcut,%A_ScriptFullPath%,%A_AppData%\Microsoft\Internet Explorer\Quick Launch\ScriptCreater.lnk,%A_ScriptDir%,,Редактор скриптов,%A_ScriptFullPath%
Menu,RegMenu,check,в панели быстрого запуска
}
Return

SetDesktop:
IfExist,%A_Desktop%\ScriptCreater.lnk
{
FileDelete,%A_Desktop%\ScriptCreater.lnk
Menu,RegMenu,uncheck,на рабочем столе
}
else
{
FileCreateShortcut,%A_ScriptFullPath%,%A_Desktop%\ScriptCreater.lnk,%A_ScriptDir%,,Редактор скриптов,%A_ScriptFullPath%
Menu,RegMenu,check,на рабочем столе
}
Return

SelRootDir:
Menu,NavigMenu,delete,%Root%
Menu,Menu,add,пусто,Cle
Menu,Menu,deleteall
gui, +owndialogs
IfNotExist,%root_dir%
root_dir= %A_ScriptDir%
root_dir1= %root_dir%
FileSelectFolder,root_dir,*%root_dir%,3,Выбор корневой папки навигатора
if root_dir=
root_dir= %root_dir1%
if errorlevel<> 0
root_dir= %root_dir1%
SplitPath,root_dir,Root

CreateMenu:
IfNotExist,%root_dir%
root_dir= %A_ScriptDir%
Critical
LastFold=
Loop,%root_dir%\*.*,2,1
{
SplitPath,A_LoopFileFullPath,outname,outfold
SplitPath,outfold,outname2,outfold2
if LastFold=
{
MyMenu= Menu
gosub ClearPath
}
else if outfold= %root_dir%
{
MyMenu= Menu
gosub ClearPath
}
else if outfold= %LastFold%
gosub ClearPath
else if outfold<> %LastFold%
{
MyMenu= %outfold2%\%outname2%
gosub ClearPath
}
LastFold= %outfold%
}
Loop,%root_dir%\*.ahk,0,1
{
SplitPath,A_LoopFileFullPath,outname,outfold
SplitPath,outfold,outname2,outfold2
if outfold= %root_dir%
Menu,Menu,add,%outname%,Cle
else
Menu,%outfold2%\%outname2%,add,%outname%,Cle
}
Menu,Menu,add,пусто,Cle
Menu,NavigMenu,add,%Root%, :Menu
Menu,Menu,delete,пусто
Critical, off
Return

Cle:
if A_ThisMenu= Menu
endpath= %root_dir%\%A_ThisMenuItem%
else
endpath= %A_ThisMenu%\%A_ThisMenuItem%
loop, %root_dir%\*.*,1,1
{
IfInString,A_LoopFileFullPath,%endpath%
{
ItemFile= %A_LoopFileFullPath%
TargetFile= 2
goto Opening2
}
}
Return

ClearPath:
Menu,%outfold%\%outname%,add,пусто,Cle
Menu,%outfold%\%outname%,disable,пусто
Menu,%MyMenu%,add,%outname%,:%outfold%\%outname%
Menu,%outfold%\%outname%,deleteall
Return

onclipboardchange:
if ZagScr=
{
ZagScr= 1
Return
}
if ZagScr= 1
{
Menu,VstMenu,add,
ZagScr= 2
}
if A_EventInfo= 1
{
if Clipboard in Return,Exit,ExitApp,GuiSize,GuiContextMenu,GuiEscape,NoActivate,AlwaysOnTop,OwnDialogs,LastFound,Caption,MaximizeBox,MinimizeBox,SysMenu,Border,Default,ToolWindow,BackgroundTrans
{
CliP= 1
Return
}
StringLen, CountC, Clipboard
if CountC> 20
{
stringleft,ClipSt,Clipboard,20
ClipSt= %ClipSt%...
}
else
ClipSt= %Clipboard%
Loop,Parse,ClipSt,`,
{
if A_Index= 1
ClipStK= %A_LoopField%
else
ClipStK= %ClipStK%`,%A_LoopField%
}
Menu,VstMenu,useerrorlevel
If Clip1=
{
Clip1= %Clipboard%
ClipStK1= %ClipStK%
}
else
If Clip2=
{
if Clip1= %Clipboard%
Return
Clip2= %Clipboard%
ClipStK2= %ClipStK%
}
else
If Clip3=
{
if Clip1= %Clipboard%
Return
if Clip2= %Clipboard%
Return
Clip3= %Clipboard%
ClipStK3= %ClipStK%
}
else
{
if Clip1= %Clipboard%
Return
if Clip2= %Clipboard%
Return
if Clip3= %Clipboard%
Return
Menu,VstMenu,delete,%ClipStK1%
if ErrorLevel <> 0
goto Xrensnim
Xrensnim:
Clip1= %Clip2%
ClipStK1= %ClipStK2%
Clip2= %Clip3%
ClipStK2= %ClipStK3%
Clip3= %Clipboard%
ClipStK3= %ClipStK%
ZagScr= 3
}
Menu,EditMenu,enable,&Вставить %A_Tab%Ctrl+V
Menu, EditMenu, enable, Вставить как...
if ClipStK1= %ClipStK%
Menu,VstMenu,add,%ClipStK1%,StKpast
else
if ClipStK2= %ClipStK%
Menu,VstMenu,add,%ClipStK2%,StKpast
else
if ClipStK3= %ClipStK%
Menu,VstMenu,add,%ClipStK3%,StKpast
CliP= 1
}
else
{
Menu,EditMenu,disable,&Вставить %A_Tab%Ctrl+V
Menu, EditMenu, disable, Вставить как...
CliP= 0
}
Return

StKpast:
if A_ThisMenuItem= %ClipStK1%
Command2= %Clip1%
if A_ThisMenuItem= %ClipStK2%
Command2= %Clip2%
if A_ThisMenuItem= %ClipStK3%
Command2= %Clip3%
SourceLabel= menu
goto Inserting

SelVars:
gui, submit, nohide
if Vars= Переменные
{
if Command1=
guicontrol, disable, Вставить
guicontrol,, combobox13, |
guicontrol, hide, combobox13,
guicontrol,, button15, 0
guicontrol, hide, button15
return
}
if Vars= В этом скрипте
{
guicontrol,, static1, Переменные`, заданные в данном скрипте.
guicontrol, show, combobox13,
if ContentVars<>
guicontrol,, combobox13, %ContentVars%
else
guicontrol,, combobox13, |
}
if Vars= Специальные символы
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |А_Space|А_Tab
}
if Vars= Свойства скрипта
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |Digit|A_WorkingDir|A_ScriptDir|A_ScriptName|A_ScriptFullPath|A_LineNumber|A_LineFile|A_AhkVersion|A_IsCompiled|A_ExitReason
}
if Vars= Дата и время
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_YYYY|A_MM|A_DD|A_MMMM|A_MMM|A_DDDD|A_DDD|A_WDay|A_YDay|A_YWeek|A_Hour|A_Min|A_Sec|A_MSec|A_Now|A_NowUTC|A_TickCount
}
if Vars= Настройки скрипта
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_IsSuspended|A_BatchLines|A_TitleMatchMode|A_TitleMatchModeSpeed|A_DetectHiddenWindows|A_DetectHiddenText|A_AutoTrim|A_StringCaseSense|A_FormatInteger|A_FormatFloat|A_KeyDelay|A_WinDelay|A_ControlDelay|A_MouseDelay|A_DefaultMouseSpeed|A_IconHidden|A_IconTip|A_IconFile|A_IconNumber
}
if Vars= Простой в работе
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_TimeIdle|A_TimeIdlePhysical
}
if Vars= Окна GUI и строки меню
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_Gui|A_GuiControl|A_GuiWidth|A_GuiHeight|A_GuiX|A_GuiY|A_GuiControlEvent|A_GuiEvent|A_EventInfo
}
if Vars= Hotkeys, Hotstrings и пункты меню
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_ThisMenuItem|A_ThisMenu|A_ThisMenuItemPos|A_ThisHotkey|A_PriorHotkey|A_TimeSinceThisHotkey|A_TimeSincePriorHotkey|A_EndChar
}
if Vars= OS и user
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_OSType|A_OSVersion|A_Language|A_ComputerName|A_UserName|A_WinDir|A_ProgramFiles|A_Desktop|A_DesktopCommon|A_StartMenu|A_StartMenuCommon|A_Programs|A_ProgramsCommon|A_Startup|A_StartupCommon|A_MyDocuments|A_IsAdmin|A_ScreenWidth|A_ScreenHeight|A_IPAddress1|A_IPAddress2|A_IPAddress3|A_IPAddress4
}
if Vars= Цикл
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_Index|A_LoopFileName|A_LoopRegName|A_LoopReadLine|A_LoopField|A_LoopRegName|A_LoopRegType|A_LoopRegKey|A_LoopRegSubKey|A_LoopRegTimeModified|A_LoopFileExt|A_LoopFileFullPath|A_LoopFileLongPath|A_LoopFileShortPath|A_LoopFileShortName|A_LoopFileDir|A_LoopFileTimeModified|A_LoopFileTimeCreated|A_LoopFileTimeAccessed|A_LoopFileAttrib|A_LoopFileSize|A_LoopFileSizeKB|A_LoopFileSizeMB
}
if Vars= Прочее
{
guicontrol, show, combobox13,
guicontrol,, combobox13, |A_Cursor|A_CaretX|A_CaretY|Clipboard|ClipboardAll|ErrorLevel|A_LastError 
}
guicontrol,, button15, 0
guicontrol, hide, button15
if Command1=
guicontrol, disable, Вставить
guicontrol,, static1, Выбор переменных для вставки.
return

ItemVar:
gui, submit, nohide
if SelectVars=
return
guicontrol, enable, Вставить
guicontrol, show, button15
loop, parse, Variables, `n
{
if A_Loopfield=
break
stringsplit, VarsArray, A_Loopfield, %A_Tab%
if VarsArray1= %SelectVars%
{
guicontrol,, static1, %VarsArray2%
break
}
}
return

Otobr:
ifwinactive, ahk_id %ScriptCreater%
{
MouseGetPos,,,OutputVarWin2, OutputVarControl2
if OutputVarWin2<> %ScriptCreater%
return
if OutputVarControl2 in static2,static3,static4,static5,static6,static7,static8,static9,static10,static11,button14
{
ControlGetText, Outputtext, %OutputVarControl2%, ahk_id %ScriptCreater%
if Outputtext=
return
if Outputtext= Вставить
Outputtext= Вставить строку`nв выбранное место
tooltip, %Outputtext%
settimer, removetooltip, 2000
}
if OutputVarControl2= button2
{
ControlGetText, Outputtext, button2, ahk_id %ScriptCreater%
if Outputtext in &Нет,Перейти,Отмена
return
if Outputtext<> Добавить
return
else
Outputtext= Добавить строку в конец
tooltip, %Outputtext%
settimer, removetooltip, 2000
Outputtext= 
}
ControlGet,Cline,CurrentLine,,edit1,ahk_id %ScriptCreater%
GuiControl,,Static15,Строка №%Cline%
}
WinGetPos, Xt1, Yt1, Wt1, Ht1, ahk_id %ScriptCreater%
WinGet,WinMM,MinMax,ahk_id %ScriptCreater%
if Vertik= 1
{
if WinMM= 1
{
Vertik= 0
Return
}
if Yt1 <> 0
WinMove,ahk_id %ScriptCreater%,,,0,,%Ytray%
if Ht1 <> %Ytray%
WinMove,ahk_id %ScriptCreater%,,,0,,%Ytray%
}
if Goriz= 1
{
if WinMM= 1
{
Goriz= 0
Return
}
if Xt1 <> 0
WinMove,ahk_id %ScriptCreater%,,0,,%A_ScreenWidth%
if Wt1 <> %A_ScreenWidth%
WinMove,ahk_id %ScriptCreater%,,0,,%A_ScreenWidth%
}
return

TX:
ControlGetText, Outputtext, static1, ahk_id %ScriptCreater%
if Outputtext=
return
stringlen, Hislo, Outputtext
if Hislo> 300
msgbox %Outputtext%
return

SelFont:
EdFont= 0
GetFont:
SetTimer,DefFont,100
if not DllCall("comdlg32\ChooseFontA", str, StructForChooseFont) 
   return 
LastFont= %FontFace%
LastFontSize= %FontSize%
VarSetCapacity(FontFace, SizeOfFontFaceName) 
DllCall("RtlMoveMemory", str, FontFace, Uint, &StructForLogFont + OffsetToFontFaceName, Uint, SizeOfFontFaceName) 
FontSize= % ExtractInteger(StructForChooseFont, 16) // 10 
SetFormat, integer, hex 
FColor= % BGRtoRGB(ExtractInteger(StructForChooseFont, 24)) 
SetFormat, integer, d 
if FontSize=
FontSize= %LastFontSize%
if FontFace=
FontFace= %LastFont%
if EdFont= 0
{
;stringtrimleft, FColor, FColor, 2
Gui, Font, s%FontSize% , %FontFace%
GuiControl, Font, Edit1
Goto,SelColFont
}
else
{
winactivate ahk_id %ScriptCreater%
winwaitactive ahk_id %ScriptCreater%
ControlSetText,edit%NumEdit%,%FontFace%,ahk_id %ScriptCreater%
}
return

DefFont:
IfWinActive,Шрифт
{
ControlSetText,edit1,%FontFace%,Шрифт
ControlSetText,edit3,%FontSize%,Шрифт
;MsgBox ok
SetTimer,DefFont,off
}
Return

Razreshit:
if Saved= 1
Saved= 0
if StatEd= 0
{
StatEd= 1
Menu, EditMenu, enable, Найти %A_Tab%Ctrl+F
Menu, EditMenu, enable, Заменить %A_Tab%Ctrl+P
Menu, FileMenu, enable, &Сохранить %A_Tab%Ctrl+S
Menu, EditMenu, enable, Отменить %A_Tab%Ctrl+Z
Menu, EditMenu, enable, Вы&делить все %A_Tab%Ctrl+A
Menu, FileMenu, enable, Со&хранить как...
Menu, ServMenu, enable, %RunName%
}
ControlFocus, edit1, ahk_id %ScriptCreater%
CarX= %A_CaretX%
CarY= %A_CaretY%
Controlgettext, Source,, ahk_id %MyEditID%
if Source=
{
Menu, EditMenu, disable, Найти %A_Tab%Ctrl+F
Menu, EditMenu, disable, Заменить %A_Tab%Ctrl+P
Menu, EditMenu, disable, Вы&делить все %A_Tab%Ctrl+A
Menu, ServMenu, disable, %RunName%
}
else
{
Menu, EditMenu, enable, Найти %A_Tab%Ctrl+F
Menu, EditMenu, enable, Заменить %A_Tab%Ctrl+P
Menu, EditMenu, enable, Вы&делить все %A_Tab%Ctrl+A
Menu, ServMenu, enable, %RunName%
}
return

~LButton::
ifwinactive, ahk_id %ScriptCreater%
{
if NewVar= 1
gosub SetVar
CoordMode,ToolTip,Relative
ControlGetPos,Xed1,Yed1,Wed1,Hed1,Static16,ahk_id %ScriptCreater%
Xed2:= Xed1 + Wed1
Yed2:= Yed1 + Hed1
Hed2:= Hed1 / 2
Yed3:= Yed1 + Hed2
MouseGetPos,Xmous,Ymous
if Xmous between %Xed1% and %Xed2%
	{
	if Ymous between %Yed1% and %Yed3%
	goto Prygok
	if Ymous between %Yed3% and %Yed2%
	goto Prygok2
	}
Sleep, 100
ControlGetFocus,ControlFoc,ahk_id %ScriptCreater%
if Controlfoc= edit1
	{
	sleep, 100
	CarX= %A_CaretX%
	CarY= %A_CaretY%
	}
if Controlfoc= edit2
gosub Vozvrat
}
return

DL1:
DLnum= 1
goto Perexod
DL2:
DLnum= 2
goto Perexod
DL3:
DLnum= 3
goto Perexod
DL4:
DLnum= 4
goto Perexod
DL5:
DLnum= 5
goto Perexod
DL6:
DLnum= 6
goto Perexod

Perexod:
ControlGetFocus, ItemFocus, ahk_id %ScriptCreater%
gui, submit, nohide
Ndl= 1
loop, 10
{
numbC:= Ndl+1
guicontrolget, visC, visible, combobox%numbC%
if visC= 0
ddl%Ndl%= %a_spase%
Ndl:= Ndl+1
}
if Razdel= 0
{
if Command1= GUI
goto Editgui2
if Command1= Loop
goto EditLoop2
if Command1= Menu
goto EditMenu2
if Command1= DriveGet
goto EditDriveGet2
if Command1= if
goto EditIf2
if Command1= Transform
goto EditTransform2
if Command1= WinSet
{
if DLnum= 1
goto EditWinSet2
if DLnum= 2
goto EditWinSet3
}
if Command1= #Include
  {
guicontrol,, static2, %ddl1%
guicontrol, hide, combobox2, 
guicontrol, show, Edit3
  }
if Command1= FileSetAttrib
{
guicontrol, hide, combobox2, 
guicontrol, show, Edit3
stringleft, Attr, ddl1, 1
guicontrol,, Edit3, %Attr%
ItemFocus= Edit3
}
if Command1= IfMsgBox
{
guicontrol, hide, combobox2, 
guicontrol, show, Edit3
guicontrol,, Edit3, %ddl1%
ItemFocus= Edit3
}
if Command1= SetFormat
  {
guicontrol,, static2, NumberType
guicontrol, hide, combobox2, 
guicontrol, show, Edit3
guicontrol,, Edit3, INTEGER
if ddl1= INTEGER
{
guicontrol, hide, Edit4, 
guicontrol,, combobox3, |
guicontrol, show, combobox3, 
guicontrol,, combobox3, hex|d
}
if ddl1= FLOAT
guicontrol,, Edit3, FLOAT
  }
if Command1= FileSelectFile
  {
guicontrol,, static4, %ddl3%
guicontrol, hide, combobox4, 
guicontrol, show, Edit5
  }
if ddl2= Period
{
guicontrol, hide, combobox3, 
guicontrol,, static3, Period
guicontrol, show, Edit4
return
}
if ddl1= Control
{
guicontrol, hide, combobox2, 
guicontrol,, static2, Control
guicontrol, show, Edit3
return
}
if ddl1= Pos
{
guicontrol, hide, combobox2, 
guicontrol,, static2, Pos
guicontrol, show, Edit3
ControlSetText,Edit3,x y,ahk_id %ScriptCreater%
return
}
if ddl6= X&Ycoord
{
guicontrol, hide, combobox7, 
guicontrol,, static7, X`&Ycoord
guicontrol, show, Edit8
ControlSetText,Edit8,x y,ahk_id %ScriptCreater%
return
}
if Command1= Process
{
if ddl2= PID
{
guicontrol, hide, combobox3, 
guicontrol,, static3, PID
guicontrol, show, Edit4
return
}
}
if ddl2= Name
{
guicontrol, hide, combobox3, 
guicontrol,, static3, Name
guicontrol, show, Edit4
return
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
return
}
DLnum1:= DLnum+1
gui, submit, nohide
loop, parse, ddl%DLnum%, *
{
if A_Loopfield=
break
numb:= a_index+2
nums:= a_index+1
guicontrol, show, Edit%numb%
guicontrol,, static%nums%, %A_Loopfield%
}
guicontrol,, combobox%DLnum1%, 
guicontrol, hide, combobox%DLnum1%, 
SelectDrive= 0
Razdel= 0
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
sleep, 100
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

~^F3::
ifwinnotactive ahk_id %ScriptCreater%
return
SmartGUI:
IfWinNotExist,SmartGUI Creator
{
	IfNotExist, %ahk_smart_gui%
	{
		MsgBox, Не найден файл: %ahk_smart_gui%.
		return
	}
	Run, %ahk_smart_gui%
	WinWait, SmartGUI Creator
}
Winactivate, SmartGUI Creator
WinWaitActive, SmartGUI Creator
IfWinExist,SmartGUI.exe
WinClose,SmartGUI.exe
sleep, 200
IfWinExist,SmartGUI.exe
WinClose,SmartGUI.exe
return

~^F2::
ifwinnotactive ahk_id %ScriptCreater%
return
WindowSpy:
IfWinNotExist, Active Window Info
{
	IfNotExist, %ahk_win_spy%
	{
		MsgBox, Не найден файл: %ahk_win_spy%.
		return
	}
	Run, %ahk_win_spy%
	WinWait, Active Window Info
}
Winactivate, Active Window Info
WinWaitActive, Active Window Info
return

~^F1::
ifwinnotactive ahk_id %ScriptCreater%
return
Help:
gui, submit, nohide
IfWinNotExist, AutoHotkey Help
{
	IfNotExist, %ahk_help_file%
	{
		MsgBox, Не найден файл справки: %ahk_help_file%.
		return
	}
	Run, %ahk_help_file%
	WinWait, AutoHotkey Help
}
Winactivate, AutoHotkey Help
WinWaitActive, AutoHotkey Help
PostMessage, 0x50, 0, 0x4090409,, AutoHotkey Help
ControlClick, x170 y80, AutoHotkey Help
sleep, 300
if Command1<>
{
ControlFocus, edit1, AutoHotkey Help
StringLeft,StartCom,Command1,1
if StartCom= #
{
StringTrimLeft,Command1a,Command1,1
send, +{sc004}%Command1a%
}
else
Send, %Command1%
sleep, 200
send, {enter}
sleep, 200
WinWaitActive, AutoHotkey Help
ControlGet, OutputList, List, , SysListView321, AutoHotkey Help
ControlFocus, SysListView321, AutoHotkey Help
loop, parse, OutputList, `n
{
stringsplit, HelpArray, A_Loopfield, %a_tab%
ifinstring, HelpArray1, %Command1%
break
send, {down}
}
send, {down}
sleep, 200
send, {enter}
}
return

Deleting:
ControlFocus, edit1, ahk_id %ScriptCreater%
send, {del}
return

~<sc00D>::
ifwinnotactive ahk_id %ScriptCreater%
return
ControlGetFocus,FocControl,ahk_id %ScriptCreater%
gui, submit, nohide
if FocControl= Edit1
{
ControlGet,Cline,CurrentLine,,%FocControl%,ahk_id %ScriptCreater%
ControlGet,itemlineV,Line,%Cline%,%FocControl%,ahk_id %ScriptCreater%
StringRight,End,itemlineV,1
if End in `:,`=
StringTrimRight,itemlineV,itemlineV,1
StringLeft,Spa,itemlineV,3
if (Spa= "if ")
Return
NewVar= 1
ControlSetText,Static1,Создание переменной "%itemlineV%"...,ahk_id %ScriptCreater%
}
return

~<sc01C>::
ifwinnotactive ahk_id %ScriptCreater%
return
SetVar:
ControlGetFocus, ContrFoc, ahk_id %ScriptCreater%
if ContrFoc= edit1
{
if NewVar= 1
{
Nal= 0
loop, parse, ContentVars, |
	{
	if a_loopfield= %itemlineV%
	{
	Nal= 1
	break
	}
	}
if Nal= 0
{
ContentVars= %ContentVars%|%itemlineV%
ControlSetText,Static1,Переменная "%itemlineV%"`nдобавлена в список переменных!,ahk_id %ScriptCreater%
}
else
ControlSetText,Static1,Обновлено содержимое`nпеременной "%itemlineV%"!,ahk_id %ScriptCreater%
NewVar= 0
}
}
return

$+^<sc031>::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, +^{sc031}
return
}
CreatingNW:
Run, %A_ScriptFullPath%
Return

~^<sc031>::
ifwinnotactive, ahk_id %ScriptCreater%
return
Creating:
Gui, +OwnDialogs 
if Saved= 0
{
WinGetTitle, TitScr, ahk_id %ScriptCreater%
stringtrimleft, TitScr, TitScr, 16
msgbox, 3,,  Файл %TitScr% был изменен. Сохранить изменения?
ifmsgbox cancel
return
ifmsgbox no
goto Dalee2
else
if ItemFile= Безымянный.ahk
gosub SavingAs
else
{
gui, submit, nohide
ifexist, %ItemFile%
filedelete, %ItemFile%
fileappend, %MyEdit%, %ItemFile%
Saved= 1
}
}
Dalee2:
guicontrol,, Edit1, 
ItemFile= Безымянный.ahk
WinSetTitle, ScriptCreater, , ScriptCreater - Безымянный.ahk
return

OpeningExe:
IfNotExist,%ahk_dir%\Exe2Ahk.exe
{
IfNotExist,%A_ScriptDir%\Exe2Ahk.exe
{
MsgBox Декомпилятор в рабочей директории `nи в директории Autohotkey не найден.
Return
}
}
OpenFilter= *.exe
goto Opening2

OpenExe:
IfExist,%ahk_dir%\Exe2Ahk.exe
Exe2Ahk_Path= %ahk_dir%\Exe2Ahk.exe
else IfExist,%A_ScriptDir%\Exe2Ahk.exe
Exe2Ahk_Path= %A_ScriptDir%\Exe2Ahk.exe
RunWait,"%Exe2Ahk_Path%" "%ItemFile%"
sleep, 500
IfNotExist, %OutFileDir%\%OutNameNoExt%.%ExtFile2%
{
MsgBox Приложение не является `nскомпилированным скриптом.
exit
}
else
Itemfile= %OutFileDir%\%OutNameNoExt%.%ExtFile2%
Return

~^F4::
ifwinnotactive ahk_id %ScriptCreater%
return
Remont:
IfNotExist,%A_ScriptDir%\ScriptCreater.ahk
{
MsgBox Не найден первичный скрипт!
Return
}
TargetFile= 1
OpenFilter= *.ahk
ItemFile= %A_ScriptDir%\ScriptCreater.ahk
goto Opening2

LastFile1:
if LastFile1= %ItemFile%
Return
TargetFile= 1
SplitPath,LastFile1,,, OutExt
OpenFilter= *.%OutExt%
ItemFile1= %ItemFile%
ItemFile= %LastFile1%
goto Opening2

LastFile2:
if LastFile2= %ItemFile%
Return
TargetFile= 1
SplitPath,LastFile2,,, OutExt
OpenFilter= *.%OutExt%
ItemFile1= %ItemFile%
ItemFile= %LastFile2%
goto Opening2

LastFile3:
if LastFile3= %ItemFile%
Return
TargetFile= 1
SplitPath,LastFile3,,, OutExt
OpenFilter= *.%OutExt%
ItemFile1= %ItemFile%
ItemFile= %LastFile3%
goto Opening2

~^<sc018>::
ifwinnotactive, ahk_id %ScriptCreater%
return
Opening:
TargetFile= 0
OpenFilter= *.ahk
Opening2:
Gui, +OwnDialogs 
WinGetTitle, TitScr, ahk_id %ScriptCreater%
stringtrimleft, TitScr, TitScr, 16
if Saved= 0
{
msgbox, 3,,  Файл %TitScr% был изменен. Сохранить изменения?
ifmsgbox cancel
return
ifmsgbox no
goto Dalee
else
gosub SavingAs
}
Dalee:
if RunName= Reload%A_Tab%Ctrl+R
{
msgbox, 3,,  Скрипт "%TitScr%" загружен. Выгрузить?
ifmsgbox cancel
return
ifmsgbox no
goto NeVygr
else
{
Send,#^!{f12}
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
Menu,ServMenu,Disable,Выгрузить %A_Tab%Ctrl+Alt+Win+f12
}
}
NeVygr:
if TargetFile= 1
{
Saved= 0
goto ClearRun
}
if TargetFile= 2
{
Saved= 0
goto ClearRun2
}
Dialog:
Gui, +OwnDialogs 
FileSelectFile, ItemFile, , %root_dir%, Выбор скрипта для редактирования, %OpenFilter%
if ItemFile=
{
if TargetFile= 1
{
Menu,FileMenu,delete,%A_ThisMenuItem%
ItemFile= %ItemFile1%
}
return
}
if errorlevel<> 0
{
if TargetFile= 1
{
Menu,FileMenu,delete,%A_ThisMenuItem%
ItemFile= %ItemFile1%
}
return
}
Saved= 0
ClearRun2:
if LastFile1=
{
if LastFile2=
{
if LastFile3=
Menu,FileMenu,add
}
LastFile1= %ItemFile%
SplitPath,LastFile1, OutFile1
Menu,FileMenu,add,%OutFile1%,LastFile1
}
else
if LastFile2=
{
if LastFile1= %ItemFile%
goto ClearRun
LastFile2= %ItemFile%
SplitPath,LastFile2, OutFile2
Menu,FileMenu,add,%OutFile2%,LastFile2
}
else
if LastFile3=
{
if LastFile1= %ItemFile%
goto ClearRun
if LastFile2= %ItemFile%
goto ClearRun
LastFile3= %ItemFile%
SplitPath,LastFile3, OutFile3
Menu,FileMenu,add,%OutFile3%,LastFile3
}
else
{
if LastFile1= %ItemFile%
goto ClearRun
if LastFile2= %ItemFile%
goto ClearRun
if LastFile3= %ItemFile%
goto ClearRun
Menu,FileMenu,delete,%OutFile1%
LastFile1= %LastFile2%
OutFile1= %OutFile2%
LastFile2= %LastFile3%
OutFile2= %OutFile3%
LastFile3= %ItemFile%
SplitPath,LastFile3, OutFile3
Menu,FileMenu,add,%OutFile3%,LastFile3
}
ClearRun:
if Saved= 1
Return
SplitPath,ItemFile,, OutFileDir,ExtFile,OutNameNoExt
if OpenFilter= *.ahk
{
if ExtFile<> ahk
{
msgbox Файл "%ItemFile%" `nне является скриптом ahk.
return
}
}
if OpenFilter= *.exe
{
if ExtFile<> exe
{
msgbox Файл "%ItemFile%" `nне является приложением exe.
return
}
ifexist, %OutFileDir%\%OutNameNoExt%.ahk
{
ExtFile2= new
MsgBox,4,,В данной папке уже имеется первичный скрипт. `nНажмите "да" для открытия первичного скрипта `n "нет" для декомпиляции exe файла.
IfMsgBox no
gosub OpenExe
else
ItemFile= %OutFileDir%\%OutNameNoExt%.ahk
}
else
{
ExtFile2= ahk
gosub OpenExe
}
}
Gui +Disabled
IfWinExist,ahk_id %IDNameW%
gui, 2: +Disabled
IfWinExist,ahk_id %IDFindwintit%
gui, 3: +Disabled
IfExist,%ItemFile%
fileread, OpenI, %ItemFile%
else IfNotExist,%ItemFile%
{
MsgBox Заданный файл не существует.`nПроверьте правильность заданного пути!
Gui -Disabled
IfWinExist,ahk_id %IDNameW%
gui, 2: -Disabled
IfWinExist,ahk_id %IDFindwintit%
gui, 3: -Disabled
goto Dialog
}
guicontrol,, Edit1, %OpenI%
SplitPath, ItemFile, OutFileName
WinSetTitle, ahk_id %ScriptCreater%, , ScriptCreater - Обработка файла "%OutFileName%"... %А_Tab%
SetTimer,Renaming,150
gosub Renaming
ZagScr2=
gosub RegVars
ZagScr2= 1
WinActivate,ahk_id %ScriptCreater%
Menu, EditMenu, enable, Найти %A_Tab%Ctrl+F
Menu, EditMenu, enable, Заменить %A_Tab%Ctrl+P
Menu, EditMenu, enable, Вы&делить все %A_Tab%Ctrl+A
Menu, FileMenu, enable, &Сохранить %A_Tab%Ctrl+S
Menu, FileMenu, enable, Со&хранить как...
Menu, ServMenu, enable, %RunName%
SetTimer,Renaming,off
WinSetTitle, ahk_id %ScriptCreater%, , ScriptCreater - %OutFileName%
Saved= 1
Gui -Disabled
IfWinExist,ahk_id %IDNameW%
{
WinGetTitle,NameWind,ahk_id %IDNameW%
gui, 2: destroy
if NameWind= Выбор Hotkeys
WinMenuSelectItem,ahk_id %ScriptCreater%,,Се&рвис,Hotkeys %A_Tab%Ctrl+H
if NameWind= Выбор метки
WinMenuSelectItem,ahk_id %ScriptCreater%,,Се&рвис,Метки %A_Tab%Ctrl+L
}
IfWinExist,ahk_id %IDFindwintit%
{
WinGetTitle,NameWind,ahk_id %IDFindwintit%
gui, 3: destroy
if NameWind= Найти...
goto Find
if NameWind= Найти и заменить
goto Replase
}
return

~^<sc01F>::
ifwinnotactive, ahk_id %ScriptCreater%
return
if Saved= 1
return
Saving:
if ItemFile=
goto SavingAs
if ItemFile= Безымянный.ahk
goto SavingAs
gui, submit, nohide
ifexist, %ItemFile%
filedelete, %ItemFile%
fileappend, %MyEdit%, %ItemFile%
Saved= 1
return

$^<sc026>::
WinGet,Atit,ID,A
if Atit<> %ScriptCreater%
{
if Atit<> %IDFindwintit%
{
if Atit<> %IDNameW%
{
send, ^{sc026}
return
}
}
}
if LabelS=
return
WinMenuSelectItem,ahk_id %ScriptCreater%,,Сервис,Метки %A_Tab%Ctrl+L
return

$^<sc023>::
WinGet,Atit,ID,A
if Atit<> %ScriptCreater%
{
if Atit<> %IDFindwintit%
{
if Atit<> %IDNameW%
{
send, ^{sc023}
return
}
}
}
if HotkeyS=
return
WinMenuSelectItem,ahk_id %ScriptCreater%,,Сервис,Hotkeys %A_Tab%Ctrl+H
return

SavingAsExe:
SavFilter= *.exe
gui, submit, nohide
goto Nazad
SavingAs:
SavFilter= *.ahk
gui, submit, nohide
Nazad:
Gui, +OwnDialogs 
StringTrimRight,ItemFile,ItemFile,4
FileSelectFile, ItemFileS, S8, %ItemFile%, Сохранение скрипта, %SavFilter%
if ItemFileS=
{
ItemFile= %ItemFile%.ahk
exit
}
SplitPath,ItemFileS,,,Fileext
if SavFilter= *.ahk
	{
	if Fileext<> ahk
	ItemFileS= %ItemFileS%.ahk
	}
if SavFilter= *.exe
	{
	if Fileext<> exe
	ItemFileS= %ItemFileS%.exe
	IfNotExist,%ahk_dir%\Compiler\Ahk2Exe.exe
		{
		MsgBox Компилятор не обнаружен. `nПроект может быть сохранен `n только как ahk скрипт.
		Return
		}
	}
if errorlevel<> 0
return
ifexist, %ItemFileS%
	{
	Gui, +OwnDialogs 
	msgbox, 1,, Файл %ItemFileS% уже существует. `n Заменить его?
	ifmsgbox Cancel
	goto Nazad
	}
if SavFilter= *.ahk
filedelete, %ItemFileS%
if SavFilter= *.exe
	{
	SplitPath,ItemFileS,, OutDirD,, OutNameNoExtD
	FileMove,%ItemFileS%,%OutDirD%\%OutNameNoExtD%_delete.exe
	ItemFileSexe= %ItemFileS%
	StringTrimRight,ItemFileS,ItemFileS,4
	ifexist, %ItemFileS%_to_exe.ahk
		filedelete, %ItemFileS%_to_exe.ahk
	ItemFileS= %ItemFileS%.ahk
	ifexist, %ItemFileS%
		{
		StringTrimRight,ItemFileS,ItemFileS,4
		ItemFileS= %ItemFileS%_to_exe.ahk
		}
	}
fileappend, %MyEdit%, %ItemFileS%
if SavFilter= *.ahk
{
SplitPath, ItemFileS, OutFileName
WinSetTitle, ahk_id %ScriptCreater%, , ScriptCreater - %OutFileName%
ItemFile= %ItemFileS%
Saved= 1
gosub ClearRun2
}
if SavFilter= *.exe
{
DeleTemp= 0
gui, 4: default
gui, 4: +owner1 +ToolWindow
Gui, Add, Edit, x10 y7 w315 r1 disabled vNewExe, %ItemFileSexe%
Gui, Add, Button, x336 y7 w100 hp gPathExe, Обзор
Gui, Add, Button, x10 y37 wp hp default gNewExe, Сохранить
Gui, Add, Button, x126 yp wp hp gCancelExe, Отмена
Gui, Add, Checkbox, x236 yp w210 hp Checked vDeleTemp, Удалять временный скрипт`n после сохранения
Gui, Add, Checkbox, x10 y67 w430 h20 vSparam gSparam, Применить дополнительные параметры сохранения
GUI,add,groupbox,x10 yp+30 w430 h80,Выбор иконки
Gui, Add, Edit, xp+10 yp+20 w320 r1 disabled vSelectIco, %SelectIco%
Gui, Add, Button, xp yp+30 w100 hp gSelectIco, Обзор
Gui, Add, Button, xp+115 yp w100 hp gDefaultIco, По умолчанию
if SelectIco=
SelectIco= %ahk_dir%\AutoHotkey.exe
GUI,add,pic,x375 y117 w32 h-1,%SelectIco%
GUI,add,text, xp-30 yp+35 w90 h20,Текущая иконка
GUI,add,groupbox,x10 yp+25 w430 h80, Предохранение от декомпиляции
GUI,add,text, xp+10 yp+25 w100 h20,Кодовая фраза
Gui, Add, Edit, xp+100 yp w220 r1 Password* vPassw1, 
GUI,add,text, x20 yp+25 w100 h20,Повторить фразу
Gui, Add, Edit, xp+100 yp w220 r1 Password* vPassw2, 
Gui, Add, Button, xp+225 yp-12 w85 hp gDefaultPassw, По умолчанию
Gui, Show, x404 y321 h90 w450, Параметры сохранения
WinGet,IDparam,ID,Параметры сохранения
Return
}
Saved= 1
return

4guiclose:
4buttonОтмена:
CancelExe:
FileDelete,%ItemFileS%
ifexist, %OutDirD%\%OutNameNoExtD%_delete.exe
FileMove,%OutDirD%\%OutNameNoExtD%_delete.exe,%OutDirD%\%OutNameNoExtD%.exe
gui, 4: destroy
ItemFile= %ItemFile%.ahk
Return

NewExe:
gui, 4: submit, nohide
gui, 4: +disabled
if Passw1<>
{
if Passw1<> %Passw2%
	{
	MsgBox Кодовая фраза не подтверждена`n или подтверждена неверно.
	Return
	}
}
ConfigSave= "%ahk_dir%\Compiler\Ahk2Exe.exe" /in "%ItemFileS%"  /out "%ItemFileSexe%"
if SelectIco<>
ConfigSave= %ConfigSave% /icon "%SelectIco%"
if Passw1<>
ConfigSave= %ConfigSave% /pass %Passw1%
RunWait,%ConfigSave%
if DeleTemp= 1
filedelete, %ItemFileS%
gui, 4: destroy
Saved= 1
ifexist, %OutDirD%\%OutNameNoExtD%_delete.exe
FileRecycle,%OutDirD%\%OutNameNoExtD%_delete.exe
ControlSetText,Static1,Сохранение завершено успешно.,ahk_id %ScriptCreater%
ItemFile= %ItemFile%.ahk
Return

SelectIco:
Gui, 4: +OwnDialogs 
SplitPath,SelectIco,, OutDirI
FileSelectFile,NewIco,,%OutDirI%,Выбор иконки для компиляции,*.ico; *.exe; *.dll
if NewIco=
return
if errorlevel<> 0
return
GuiControl,,edit2,%NewIco%
GuiControl,,static1, %NewIco%
Return

PathExe:
Gui, +OwnDialogs 
FileSelectFile, ItemFileSexe, S8, %ItemFileSexe%, Сохранение скрипта, *.exe
if ItemFileSexe=
Return
if errorlevel<> 0
return
GuiControl,,edit1,%ItemFileSexe%
Return

DefaultIco:
GuiControl,,edit2,
GuiControl,,static1, %ahk_dir%\AutoHotkey.exe
SelectIco= %ahk_dir%\AutoHotkey.exe
Return

DefaultPassw:
GuiControl,,edit3,
GuiControl,,edit4,
Passw1=
Passw2=
Return

Sparam:
gui, 4: submit, nohide
if Sparam= 1
WinMove,Параметры сохранения,,,,,290
else
WinMove,Параметры сохранения,,,,,110
Return

~^<sc013>::
ifwinnotactive, ahk_id %ScriptCreater%
return
Running:
gui, submit, nohide
if MyEdit=
return
if ItemFile= Безымянный.ahk
{
ifexist tempscr.ahk
filedelete tempscr.ahk
IfInString,MyEdit,SingleInstance
fileappend, %MyEdit%`r`n#^!f12::exitapp, tempscr.ahk
else
fileappend, #SingleInstance`,force`r`n%MyEdit%`r`n#^!f12::exitapp, tempscr.ahk
sleep, 100
if RunName= Reload%A_Tab%Ctrl+R
{
	Send,#^!{f12}
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
	goto Running
}
	Menu,ServMenu,rename,%RunName%,Reload%A_Tab%Ctrl+R
	RunName= Reload%A_Tab%Ctrl+R
Menu,ServMenu,enable,Выгрузить %A_Tab%Ctrl+Alt+Win+f12
	Runwait, tempscr.ahk
	filedelete tempscr.ahk
if RunName= Reload%A_Tab%Ctrl+R
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
Menu, ServMenu, disable, Выгрузить %A_Tab%Ctrl+Alt+Win+f12
}
else
{
SplitPath,ItemFile,,Rabdir,,ItemFileName
ifexist, %Rabdir%\%ItemFileName%_temp.ahk
filedelete, %Rabdir%\%ItemFileName%_temp.ahk
IfInString,MyEdit,SingleInstance
fileappend, %MyEdit%`r`n#^!f12::exitapp, %Rabdir%\%ItemFileName%_temp.ahk
else
fileappend, #SingleInstance`,force`r`n%MyEdit%`r`n#^!f12::exitapp, %Rabdir%\%ItemFileName%_temp.ahk
;FileSetAttrib,H,%Rabdir%\%ItemFileName%_temp.ahk
if RunName= Reload%A_Tab%Ctrl+R
{
	Send,#^!{f12}
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
	goto Running
}
	Menu,ServMenu,rename,%RunName%,Reload%A_Tab%Ctrl+R
	RunName= Reload%A_Tab%Ctrl+R
Menu,ServMenu,enable,Выгрузить %A_Tab%Ctrl+Alt+Win+f12
	Runwait, %Rabdir%\%ItemFileName%_temp.ahk, %Rabdir%
	filedelete, %Rabdir%\%ItemFileName%_temp.ahk
if RunName= Reload%A_Tab%Ctrl+R
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
Menu, ServMenu, disable, Выгрузить %A_Tab%Ctrl+Alt+Win+f12
}
return

UnLoad:
Send,#^!{f12}
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
Menu,ServMenu,Disable,Выгрузить %A_Tab%Ctrl+Alt+Win+f12
Return

$^<sc02C>::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, ^{sc02C}
return
}
Undo:
ControlFocus, edit1, ahk_id %ScriptCreater%
send, ^{sc02C}
Menu, EditMenu, disable, Отменить %A_Tab%Ctrl+Z
Menu, EditMenu, enable, Повторить %A_Tab%Shift+Ctrl+Z
return

$+<sc01C>::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, +{Enter}
return
}
send, ``n
Return

$^<sc01C>::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, ^{Enter}
return
}
send, ``r``n
Return

$+^<sc02C>::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, +^{sc02C}
return
}
Redo:
send, +^{sc02C}
Menu, EditMenu, disable, Повторить %A_Tab%Shift+Ctrl+Z
Menu, EditMenu, enable, Отменить %A_Tab%Ctrl+Z
return

Cut:
send, ^{sc02D}
return

Paste:
send, ^{sc02F}
return

~^<sc032>::
ifwinnotactive, ahk_id %ScriptCreater%
Return
if CliP= 0
{
ControlSetText,Static1,Буфер обмена пуст.,ahk_id %ScriptCreater%
Return
}
PasteLabel:
ItLab= 0
loop, parse, LabelS, |
{
if a_loopfield= %Clipboard%
ItLab= 1
}
if ItLab= 1
{
MsgBox,17,Предупреждение о возможной ошибке,Метка "%Clipboard%" уже имеется в этом скрипте. `nВсе равно вставить?
IfMsgBox,Cancel
Return
}
send, ^{sc02F}`:{enter}
if ItLab= 0
LabelS= %LabelS%|%Clipboard%
Menu, ServMenu, enable, Метки %A_Tab%Ctrl+L
IfWinExist,ahk_id %IDNameW%
{
WinGetTitle,NameWind,ahk_id %IDNameW%
if NameWind= Выбор метки
{
GuiControl, 2:, combobox1, |
GuiControl, 2:, combobox1, %LabelS%
Control,ChooseString,%Clipboard%,ComboBox1,ahk_id %IDNameW%
}
else
Control,Enable,,Button5,ahk_id %IDNameW%
}
Return
~^<sc010>::
ifwinnotactive, ahk_id %ScriptCreater%
Return
if CliP= 0
Return
PasteCom:
send, ^{sc02F}{enter}
Return
~^<sc030>::
ifwinnotactive, ahk_id %ScriptCreater%
Return
if CliP= 0
Return
PasteBlock:
send, {ASC 123}{enter}^{sc02F}{enter}{ASC 125}{enter}
Return
~^<sc011>::
ifwinnotactive, ahk_id %ScriptCreater%
Return
if CliP= 0
Return
PasteVar:
send,  `%^{sc02F}`%
Nal= 0
loop, parse, ContentVars, |
	{
	if a_loopfield= %ItVar%
	{
	Nal= 1
	break
	}
	}
if Nal= 0
ContentVars= %ContentVars%|%Clipboard%
Return

Copy:
;ControlFocus, edit1, ahk_id %ScriptCreater%
clipboard =
gosub Copying 
ClipWait,1
if Clipboard =
{
ControlGetFocus,FocControl,ahk_id %ScriptCreater%
ControlGet,Cline,CurrentLine,,%FocControl%,ahk_id %ScriptCreater%
ControlGet,itemline,Line,%Cline%,%FocControl%,ahk_id %ScriptCreater%
Clipboard = %itemline%
}
return

Copying:
send, ^{sc02E}
Return

Selectall:
ControlFocus, edit1, ahk_id %ScriptCreater%
send, ^{sc01E}
return

Pravka:
if StatRed2= 1
StatRed2= 0
else
StatRed= 0
ControlGetFocus, ItemFocus, ahk_id %ScriptCreater%
gosub Vozvrat
gui, submit, nohide
Ndl= 1
loop, 10
{
ddl%Ndl%= %a_spase%
Ndl:= Ndl+1
}
if Command1<>
{
guicontrol, enable, Добавить
guicontrol, enable, Вставить
}
loop, parse, Commands, `n
{
if A_Loopfield=
break
Stringsplit, OutArray, A_Loopfield, %A_Tab%
if OutArray1= %Command1%
 {
guicontrol,, Static1, %OutArray2%
Propert= %OutArray3%
if Command1= GUI
goto Editgui
if Command1= Loop
goto EditLoop
if Command1= Menu
goto EditMenu
if Command1= DriveGet
goto EditDriveGet
if Command1= if
goto EditIf
else
ifing= 0
if Command1= Transform
goto EditTransform
if Command1= WinSet
goto EditWinSet
gosub Editing
Number= 1
loop, 10
  {
Number:= Number+1
guicontrol,, combobox%Number%, 
guicontrol, hide, combobox%Number%, 
numb:= Number+1
guicontrol,, Edit%numb%,
guicontrol, hide, Edit%numb%,
numb1:= numb+1
guicontrol,, button%numb1%, 0
guicontrol, hide, button%numb1%, 
controlgettext, St%Number%, Static%Number%, ahk_id %ScriptCreater%
;Vari:= %A_Spase% . St%Number%
;msgbox "%Vari%"
if St%Number%=
continue
if St%Number% in Off,TimeUnits,1,R,Play,T,L
    {
guicontrol, show, button%numb1%
continue
    }
if St%Number% <> 0
    {
ifinstring, St%Number%, *
Razdel= 1
ifinstring, St%Number%, |
	{
Ncom= 1
loop, 20
	 {
OutCombo%Ncom%=
Ncom:= Ncom+1
	 }
stringsplit, OutCombo, St%Number%, |
ComboX= |%OutCombo1%||%OutCombo2%
Ncom= 3
loop
	 {
if OutCombo%Ncom%=
break
else
ComboA:= %A_Spase% . OutCombo%Ncom%
ComboX= %ComboX%|%ComboA%
Ncom:= Ncom+1
	 }
guicontrol,, combobox%Number%, %ComboX%
guicontrol, show, combobox%Number%
	}
else
	{
	guicontrol, show, Edit%numb%
	if St%Number%=FutureUse
	guicontrol, disable, Edit%numb%
	else
	guicontrol, enable, Edit%numb%
	}
    }
  }
break
 }
}
guicontrol, Choose, combobox12, |1
guicontrol, hide, combobox13, 
guicontrol, hide, button15
guicontrol,, button15, 0
return

Ochistka:
guicontrol, enable, Добавить
Ochistka2:
guicontrol, enable, Вставить
Ochistka3:
if StatRed= 1
Return
num= 1
loop, 10
{
num:= num+1
guicontrol,, Static%num%, %A_Spase%
num1:= num+1
;guicontrol,, Edit%num1%, %A_Spase%
}
return

EditWinSet:
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol,, static2, Attribute
guicontrol, show, combobox2
guicontrol,, combobox2, AlwaysOnTop|Bottom|Top|Disable|Enable|Redraw|Style|ExStyle|Region|Transparent|TransColor
guicontrol,, static3, Value
guicontrol, show, edit4
guicontrol,, static4, WinTitle
guicontrol, show, edit5
guicontrol,, static5, WinText
guicontrol, show, edit6
guicontrol,, static6, ExcludeTitle
guicontrol, show, edit7
guicontrol,, static7, ExcludeText
guicontrol, show, edit8
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

EditWinSet2:
guicontrol, enable, edit7
guicontrol, enable, Добавить
guicontrol, enable, Вставить
guicontrol, show, combobox2
guicontrol,, static3, Value
guicontrol, show, edit4
guicontrol,, Edit4, %A_Spase%
if ddl1 in Bottom,Top,Disable,Enable,Redraw
guicontrol, disable, edit4
if ddl1 in Style,ExStyle,Transparent
{
guicontrol, enable, edit4
guicontrol,, static3, N
}
if ddl1= AlwaysOnTop
{
guicontrol, hide, edit4
guicontrol,, combobox3, |
guicontrol, show, combobox3
guicontrol,, combobox3, On|Off|Toggle
}
if ddl1= Region
{
guicontrol, hide, edit4
guicontrol,, combobox3, |
guicontrol, show, combobox3
guicontrol,, combobox3, Wn|Hn|X-Y|E|R[w-h]
}
if ddl1= TransColor
{
guicontrol, hide, edit4
guicontrol,, combobox3, |
guicontrol, show, combobox3
guicontrol,, combobox3, WindowColor|Off
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

EditWinSet3:
guicontrol, enable, edit7
guicontrol, enable, Добавить
guicontrol, enable, Вставить
guicontrol, show, combobox2
guicontrol, hide, combobox3
guicontrol, show, edit4
if ddl2= WindowColor
{
NumEdit2= 4
Menu, ColorMenu, Show, %A_GuiX%, %A_GuiY%
}
else
guicontrol,, edit4, %ddl2%
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

EditLoop:
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol,, static2, Cmd
guicontrol, show, combobox2
guicontrol,, combobox2, Count|FilePattern|Parse|Read|RootKey
guicontrol,, combobox3, 1|2
guicontrol,, combobox4, 0|1|2
guicontrol,, combobox5, 1|2
guicontrol, enable, Edit6
guicontrol, enable, Edit7
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

EditLoop2:
gosub Skrytie
gosub Ochistka
guicontrol,, static2, Cmd
guicontrol, show, combobox2
gui, submit, nohide
if ddl1= 
return
if ddl1= Count
{
guicontrol, hide, combobox2
guicontrol,, static2, Count
guicontrol, show, edit3
guicontrol,, static1, Многократно выполняет ряд команд: заданное количество раз или до команды break.
}
if ddl1= FilePattern
{
guicontrol, hide, combobox2
guicontrol,, static2, FilePattern
guicontrol, show, edit3
guicontrol,, static3, IncludeFolders?
guicontrol, show, combobox3
guicontrol,, static4, Recurse?
guicontrol, show, combobox4
guicontrol,, static1, Поочередно извлекает заданные файлы или папки.
}
if ddl1= Parse
{
guicontrol, hide, combobox2
guicontrol,, static2, Cmd
guicontrol, show, edit3
guicontrol,, edit3, Parse
guicontrol,, static3, InputVar
guicontrol, show, edit4
guicontrol,, static4, Delimiters
guicontrol, show, edit5
guicontrol,, static5, OmitChars
guicontrol, show, edit6
guicontrol,, static6, FutureUse
guicontrol, show, edit7
guicontrol, disable, Edit7
guicontrol,, static1, Поочередно извлекает подстроки из строки.
}
if ddl1= Read
{
guicontrol, hide, combobox2
guicontrol,, static2, Cmd
guicontrol, show, edit3
guicontrol,, edit3, Read
guicontrol,, static3, InputFile
guicontrol, show, edit4
guicontrol,, static4, OutputFile
guicontrol, show, edit5
guicontrol,, static5, FutureUse
guicontrol, show, edit6
guicontrol, disable, Edit6
guicontrol,, static1, Поочередно извлекает строки текстового файла (работает быстрее, чем команда FileReadLine).
}
if ddl1= RootKey
{
guicontrol, hide, combobox2
guicontrol,, static2, RootKey
guicontrol, show, edit3
guicontrol,, static3, Key
guicontrol, show, edit4
guicontrol,, static4, IncludeSubkeys?
guicontrol, show, combobox4
guicontrol,, static5, Recurse?
guicontrol, show, combobox5
guicontrol,, static1, Извлекает содержимое заданного подраздела реестра, по одному элементу.
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

EditIf:
ifing= 1
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, Var
guicontrol, show, combobox3
guicontrol,, combobox3, |between|not between|is|is not|in|not in|contains|not contains
guicontrol,, static3, Cmd
guicontrol,, combobox4, integer|float|number|digit|xdigit|alpha|upper|lower|alnum|space|time
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

EditIf2:
gosub Skrytie
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, OutputVar
guicontrol, show, combobox3
guicontrol,, static3, Cmd
gui, submit, nohide
if ddl2=
{
guicontrol, hide, combobox3
guicontrol,, static3, Var
guicontrol, show, edit4
guicontrol,, static1, Если сравнение переменной со значением истинно (TRUE), задает команду(ы) для исполнения. Если команд несколько, сформируйте из них блок (заключите в фигурные скобки).
}
if ddl2 in between,not between
{
guicontrol, hide, combobox3
guicontrol,, static2, Var
guicontrol, show, edit3
guicontrol,, static3, 
guicontrol, show, edit4
guicontrol,, edit4, %ddl2%
guicontrol,, static4, LowerBound
guicontrol, show, edit5
guicontrol,, static5, 
guicontrol, show, edit6
guicontrol,, edit6, and
guicontrol,, static6, UpperBound
guicontrol, show, edit7
guicontrol,, static1, Проверяет, находится ли содержимое переменной численно или в алфавитном порядке между двумя значениями (включительно).
}
if ddl2 in is,is not
{
guicontrol, hide, combobox3
guicontrol,, static2, Var
guicontrol, show, edit3
guicontrol,, static3, 
guicontrol, show, edit4
guicontrol,, edit4, %ddl2%
guicontrol,, static4, type
guicontrol, show, combobox4
guicontrol,, static1, Проверяет, содержит ли переменная число, принадлежит ли строковое содержимое переменной верхнему регистру и т.д.
}
if ddl2 in in,not in,contains,not contains
{
guicontrol, hide, combobox3
guicontrol,, static2, Var
guicontrol, show, edit3
guicontrol,, static3, 
guicontrol, show, edit4
guicontrol,, edit4, %ddl2%
guicontrol,, static4, MatchList
guicontrol, show, edit5
guicontrol,, static1, Проверяет, совпадает ли содержимое переменной с одним из пунктов в списке.
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

EditTransform:
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, OutputVar
guicontrol, show, combobox3
guicontrol,, combobox3, Unicode|Asc|Chr|Deref|HTML|Mod|Pow|Exp|Sqrt|Log|Ln|Round|Ceil|Floor|Abs|Sin|Cos|Tan|ASin|ACos|ATan|BitNot|BitAnd|BitOr|BitXOr|BitShiftLeft|BitShiftRight
guicontrol,, static3, Cmd
guicontrol, show, edit5
guicontrol,, static4, Value1
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

EditTransform2:
gosub Skrytie
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, OutputVar
guicontrol, show, combobox3
guicontrol,, static3, Cmd
guicontrol, show, edit5
guicontrol,, static4, Value1
gui, submit, nohide
if ddl2=
return
if ddl2 in Chr,Sqrt,Log,Ln,Ceil,Floor,Abs,Sin,Cos,Tan,ASin,ACos,ATan,BitNot
{
guicontrol,, static4, Value1
guicontrol, hide, edit6
guicontrol,, static5,
}
if ddl2 in BitAnd,BitOr,BitXOr,BitShiftLeft,BitShiftRight
{
guicontrol,, static4, Value1
guicontrol, show, edit6
guicontrol,, static5, Value2
}
if ddl2 in Unicode,Asc,Deref,HTML
{
guicontrol,, static4, String
guicontrol, hide, edit6
guicontrol,, static5, 
}
if ddl2= Exp
{
guicontrol,, static4, N
guicontrol, hide, edit6
guicontrol,, static5, 
}
if ddl2= Mod
{
guicontrol,, static4, Dividend
guicontrol, show, edit6
guicontrol,, static5, Divisor
}
if ddl2 in Round,Pow
{
guicontrol,, static4, Value1
guicontrol, show, edit6
guicontrol,, static5, N
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

EditDriveGet:
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, OutputVar
guicontrol, show, combobox3
guicontrol,, combobox3, List|Capacity|Filesystem|Label|Serial|Type|Status|StatusCD
guicontrol,, static3, Cmd
SelectDrive= 0
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

EditDriveGet2:
if SelectDrive= 1
{
SelectDrive= 0
Return
}
gosub Skrytie
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, OutputVar
guicontrol, show, combobox3
guicontrol,, static3, Cmd
gui, submit, nohide
if ddl2=
return
if ddl2 in Filesystem,Label,Serial,StatusCD
{
guicontrol,, static4, Drive
guicontrol, show, edit5
}
if ddl2 in Capacity,Type,Status
{
guicontrol,, static4, Path
guicontrol, show, edit5
}
if ddl2= List
{
guicontrol,, static4, Type
guicontrol, show, combobox4, 
guicontrol,, combobox4, |
guicontrol,, combobox4, CDROM|REMOVABLE|FIXED|NETWORK|RAMDISK|UNKNOWN
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

EditMenu:
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, MenuName
guicontrol, show, combobox3
guicontrol,, combobox3, add|delete|deleteall|rename|check|uncheck|togglecheck|enable|disable|toggleenable|default|nodefault|standard|nostandard|icon|noicon|tip|show|color|click|mainwindow|nomainwindow|useerrorlevel
guicontrol,, static3, Cmd
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

EditMenu2:
gosub Skrytie
gosub Ochistka
guicontrol, show, edit3
guicontrol,, static2, MenuName
guicontrol, show, combobox3
guicontrol,, static3, Cmd
gui, submit, nohide
if ddl2=
return
if ddl2= standard
return
if ddl2= deleteall
return
if ddl2= nostandard
return
if ddl2= noicon
return
if ddl2= mainwindow
return
if ddl2= nomainwindow
return
if ddl2= add
{
guicontrol,, static4, MenuItemName
guicontrol, show, edit5
guicontrol,, static5, Label-or-Submenu
guicontrol, show, edit6
guicontrol,, static6, Pn
guicontrol, show, combobox6
guicontrol,, combobox6, P1|P2|P3|P4|P5
}
if ddl2= click
{
guicontrol,, static4, ClickCount
guicontrol, show, combobox4
guicontrol,, combobox4, 1||2
}
if ddl2= rename
{
guicontrol,, static4, MenuItemName
guicontrol, show, edit5
guicontrol,, static5, NewName
guicontrol, show, edit6
}
if ddl2= show
{
guicontrol,, static4, X
guicontrol, show, edit5
guicontrol,, static5, Y
guicontrol, show, edit6
}
if ddl2= icon
{
guicontrol,, static4, FileName
guicontrol, show, edit5
guicontrol,, static5, IconNumber
guicontrol, show, edit6
guicontrol,, static6, 1
guicontrol, show, button8
}
if ddl2= color
{
guicontrol,, static4, ColorValue
guicontrol, show, edit5
guicontrol,, static5, Single
guicontrol, show, button7
}
if ddl2= tip
{
guicontrol,, static4, Text
guicontrol, show, edit5
}
if ddl2= useerrorlevel
{
guicontrol,, static4, off
guicontrol, show, button6
}
if ddl2 in delete,check,uncheck,togglecheck,enable,disable,toggleenable,default
{
guicontrol,, static4, MenuItemName
guicontrol, show, edit5
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

Editgui:
gosub Skrytie
guicontrol,, combobox2, |
guicontrol,, combobox3, |
guicontrol,, combobox4, |
guicontrol,, combobox5, |
gosub Ochistka
guicontrol, show, combobox2
guicontrol,, combobox2, add|show|submit|hide|destroy|font|color|margin|menu|flash|default
guicontrol,, static2, sub-command
guicontrol,, combobox3, text|edit|updown|pic|button|checkbox|radio|ddl|combobox|listbox|listview|treeview|hotkey|datetime|monthcal|slider|progress|groupbox|tab
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
gosub Vozvrat
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
send, {end}
return

Editgui2:
gosub Skrytie
gosub Ochistka
guicontrol, show, combobox2
guicontrol,, static2, sub-command
gui, submit, nohide
if ddl1=
return
if ddl1= add
{
guicontrol, show, combobox3
guicontrol, show, edit5
guicontrol,,static4, Options
guicontrol, show, edit6
if ddl2= Pic
guicontrol,,static5, ImageFile
else
guicontrol,,static5, Text
}
if ddl1= show
{
guicontrol, show, edit4
guicontrol,,static3, Options
guicontrol, show, edit5
guicontrol,,static4, NameWin
}
if ddl1= submit
{
guicontrol, show, button5
guicontrol,,static3, nohide
}
if ddl1= font
{
guicontrol, show, edit4
guicontrol,,static3, Options
guicontrol, show, edit5
guicontrol,,static4, FontName
}
if ddl1= color
{
guicontrol, show, edit4
guicontrol,,static3, WindowColor
guicontrol, show, edit5
guicontrol,,static4, ControlColor
}
if ddl1= margin
{
guicontrol, show, edit4
guicontrol,,static3, X
guicontrol, show, edit5
guicontrol,,static4, Y
}
if ddl1= menu
{
guicontrol, show, edit4
guicontrol,,static3, MenuName
}
if ddl1= flash
{
guicontrol, show, button5
guicontrol,,static3, off
}
if ddl1= default
{
guicontrol, show, edit4
guicontrol,,static3, NumberWin
}
sleep, 200
controlclick, x%CarX% y%CarY%, ahk_id %ScriptCreater%
ControlFocus, %ItemFocus%, ahk_id %ScriptCreater%
return

Exing:
guiclose:
if RunName= Reload%A_Tab%Ctrl+R
{
WinGetTitle, TitScr, ahk_id %ScriptCreater%
stringtrimleft, TitScr, TitScr, 16
msgbox, 3,,  Скрипт "%TitScr%" загружен. Выгрузить?
ifmsgbox cancel
return
ifmsgbox no
goto NeVygrEx
else
Send,#^!{f12}
if ItemFile= Безымянный.ahk
	{
	ifexist tempscr.ahk
	filedelete tempscr.ahk
	}
else
	{
	SplitPath,ItemFile,,Rabdir,,ItemFileName
	ifexist, %Rabdir%\%ItemFileName%_temp.ahk
	filedelete, %Rabdir%\%ItemFileName%_temp.ahk
	}
}
NeVygrEx:
WinGet,MmWin,MinMax,ahk_id %ScriptCreater%
IfExist,%A_ScriptDir%\config.cfg
FileDelete,%A_ScriptDir%\config.cfg
FileAppend,%FontFace%`n%FontSize%`n%FColor%`n%Avto%`n%MmWin%`n%Vertik%`n%Goriz%`n%ViewNumber%`n%SelectIco%`n%Reg2%`n%ahk_dir%`n%root_dir%`n%LastFile1%`n%LastFile2%`n%LastFile3%,%A_ScriptDir%\config.cfg
if Saved= 1
exitapp
gui, submit, nohide
if MyEdit<>
{
Gui, +OwnDialogs 
msgbox, 3,, Сохранить изменения в файле`n %ItemFile%?
ifmsgbox cancel
return
ifmsgbox no
exitapp
else
{
gosub Saving
exitapp
}
}
else
exitapp

ED:
ControlGetFocus, ContrFoc, ahk_id %ScriptCreater%
stringtrimleft, NumEd, ContrFoc, 4
NumSt:= NumEd-1
ControlGetText, TextSt, static%NumSt%, ahk_id %ScriptCreater%
stringleft, NaH, TextSt, 3
if NaH= Out
Prisv= 1
return

buttonДобавить:
Adding:
StatRed= 0
if Saved= 1
Saved= 0
Menu, EditMenu, enable, Найти %A_Tab%Ctrl+F
Menu, EditMenu, enable, Заменить %A_Tab%Ctrl+P
Menu, FileMenu, enable, &Сохранить %A_Tab%Ctrl+S
Menu, FileMenu, enable, Со&хранить как...
Command2= 
gui, submit, nohide
if Command1= {...}
Command1= {`n}
gosub SetNewVar
guicontrolget, visV, visible, combobox13
if visV= 0
SelectVars=
if SelectVars<>
{
Command2= %SelectVars%
goto Inserting
}
if ifing= 0
Command2= %Command1%`,
else
Command2= %Command1%
numb= 1
loop, 10
{
numb:= numb+1
numb1:=numb+1
numb2:=numb1+1
Summ=
guicontrolget, visE, visible, Edit%numb1%
guicontrolget, visC, visible, combobox%numb%
guicontrolget, visB, visible, button%numb2%
Summ:= visE+visC+visB
if Summ= 0
break
if visE= 1
{
EdN:= %A_Spase% . Ed%A_Index%
if ifing= 0
Command2= %Command2%%EdN%`,
else
Command2= %Command2% %EdN%
Ed%A_Index%=
EdN=
}
if visC= 1
{
ddlN:= %A_Spase% . ddl%A_Index%
if ifing= 0
Command2= %Command2%%ddlN%`,
else
Command2= %Command2% %ddlN%
ddl%A_Index%=
ddlN=
}
if visB= 1
{
VarB:= numb2-3
if Ch%VarB%= 1
{
Nst:= numb2-2
ControlGetText, TexT, Static%Nst%, ahk_id %ScriptCreater%
if ifing= 0
Command2= %Command2%%TexT%`,
else
Command2= %Command2% %TexT%
Ch%VarB%= 0
}
}
if errorlevel<> 0
break
}
loop
{
StringRight, Comma, Command2, 1
if Comma= `,
stringtrimright, Command2, Command2, 1
else
if (Comma = " ")
stringtrimright, Command2, Command2, 1
else
break
}
if InserT= 0
{
if MyEdit=
guicontrol,, Edit1, %Command2%`n
else
guicontrol,, Edit1, %MyEdit%%Command2%`n
ControlFocus, edit1, ahk_id %ScriptCreater%
send, ^{End}
}
else
goto Inserting
sleep, 100
Adding2:
CarX= %A_CaretX%
CarY= %A_CaretY%
guicontrol, text, Combobox1,
guicontrol, disable, Добавить
guicontrol, disable, Вставить
Menu, ServMenu, enable, %RunName%
num= 1
numb:= num+2
loop, 10
{
guicontrol,, Edit%numb%
guicontrol, enable, Edit%numb%
guicontrol, hide, Edit%numb%
guicontrol,, static%num%,
num:= num+1
guicontrol,, combobox%num%, 
guicontrol, hide, combobox%num%, 
numb:= numb+1
guicontrol,, button%numb%, 0
guicontrol, hide, button%numb%, 
ifing= 0
}
Adding3:
guicontrol, ChooseString, combobox12, Переменные
guicontrol,, combobox13, |
guicontrol, hide, combobox13,
guicontrol,, button15, 0
guicontrol, hide, button15
guicontrol,, static11,
ContVar= 0
InserT= 0
return

GuiSizepast:
Command2= GuiSize`:
SourceLabel= menu
goto Inserting
BackgroundTranspast:
Command2= BackgroundTrans
SourceLabel= menu
goto Inserting
SysMenupast:
Command2= SysMenu
SourceLabel= menu
goto Inserting
OwnDialogspast:
Command2= OwnDialogs
SourceLabel= menu
goto Inserting
Minimizepast:
Command2= MinimizeBox
SourceLabel= menu
goto Inserting
Maximizepast:
Command2= MaximizeBox
SourceLabel= menu
goto Inserting
NoActivatepast:
Command2= NoActivate
SourceLabel= menu
goto Inserting
GuiContextpast:
Command2= GuiContextMenu`:
SourceLabel= menu
goto Inserting
Defaultpast:
Command2= Default
SourceLabel= menu
goto Inserting
Borderpast:
Command2= Border
SourceLabel= menu
goto Inserting
Captionpast:
Command2= Caption
SourceLabel= menu
goto Inserting
ToolWindowpast:
Command2= ToolWindow
SourceLabel= menu
goto Inserting
LastFoundpast:
Command2= LastFound
SourceLabel= menu
goto Inserting
AlwaysOnToppast:
Command2= AlwaysOnTop
SourceLabel= menu
goto Inserting
GuiEscapepast:
Command2= GuiEscape`:
SourceLabel= menu
goto Inserting
GuiClosepast:
Command2= GuiClose`:
SourceLabel= menu
goto Inserting
Exitpast:
Command2= Exit
SourceLabel= menu
goto Inserting
ExitApppast:
Command2= ExitApp
SourceLabel= menu
goto Inserting
Returnpast:
Command2= Return
SourceLabel= menu
goto Inserting

buttonВставить:
SourceLabel= button
keywait, LButton, 
InserT= 1
goto Adding
Inserting:
sleep, 100
settimer, Otobr, off
guicontrolget, visV, visible, combobox13
if visV= 0
SelectVars=
StringLen, CountS, Command2
if CountS> 15
{
stringleft,CommandT, Command2, 15
CommandT= %CommandT%...
}
else
CommandT= %Command2%
settimer, InsVieW, 100
settimer, InsVieW, on
keywait, LButton, D
ifwinnotactive, ahk_id %ScriptCreater%
winwaitactive, ahk_id %ScriptCreater%
ClickPast2:
MouseGetPos,,, OutputVarWin, OutputVarControl
if OutputVarControl= Edit1
{
keywait, LButton,
sleep, 100
if ContVar= 1
send, `%
Control, EditPaste, %Command2%, edit1, ahk_id %ScriptCreater%
if ContVar= 1
send, `%
if SelectVars=
	{
if Command2 not in Default,Border,Caption,ToolWindow,LastFound,AlwaysOnTop,NoActivate,MaximizeBox,MinimizeBox,OwnDialogs,SysMenu,BackgroundTrans
send, {enter}
	}
tooltip
if SourceLabel= menu
{
guicontrol,, button15, 0
settimer, InsVieW, off
tooltip
settimer, Otobr, on
Return
}
}
if OutputVarControl in Edit3,Edit4,Edit5,Edit6,Edit7,Edit8,Edit9,Edit10,Edit11,Edit12
{
if Command2= %SelectVars%
	{
keywait, LButton,
sleep, 100
if ContVar= 1
send, `%
Control, EditPaste, %Command2%, %OutputVarControl%, ahk_id %ScriptCreater%
if ContVar= 1
send, `%
guicontrol,, button15, 0
settimer, InsVieW, off
ToolTip
settimer, Otobr, on
goto Adding3
	}
if SourceLabel= menu
	{
keywait, LButton,
sleep, 100
Control, EditPaste, %Command2%, %OutputVarControl%, ahk_id %ScriptCreater%
guicontrol,, button15, 0
settimer, InsVieW, off
ToolTip
settimer, Otobr, on
ContVar= 0
InserT= 0
return
	}
}
guicontrol,, button15, 0
settimer, InsVieW, off
ToolTip
settimer, Otobr, on
goto Adding2

InsVieW:
tooltip, %CommandT%
return

SetNewVar:
NewVar= 
if Command1 in Ifinstring,#CommentFlag,#EscapeChar,if,IfEqual,IfGreater,IfGreaterOrEqual,IfLess,IfLessOrEqual,IfNotEqual,Menu,MsgBox,Send,SplashTextOn,ToolTip,TrayTip,WinActivate,WinActivateBottom,WinClose,WinHide,WinKill,WinMaximize,WinMenuSelectItem,WinMinimize,WinMove,WinRestore,WinSet,WinSetTitle,WinShow,WinWait,WinWaitActive,WinWaitClose,WinWaitNotActive
return
if Command1 in ControlGet,ControlGetFocus,ControlGetText,DriveGet,DriveSpaceFree,FileGetSize,FileGetTime,FileGetVersion,FileRead,FileReadLine,FileSelectFile,FileSelectFolder,FormatTime,GetKeyState,GuiControlGet,IniRead,Input,InputBox,PixelGetColor,Random,RegRead,SoundGet,SoundGetWaveVolume,StatusBarGetText,StringGetPos,StringLeft,StringLen,StringLower,StringMid,StringReplace,StringRight,StringSplit,StringTrimLeft,StringTrimRight,StringUpper,SysGet,Transform,WinGetActiveTitle,WinGetClass,WinGet,WinGetText,WinGetTitle
NewVar= %Ed1%
if Command1 in PixelSearch,ImageSearch,
NewVar= %Ed1%|%Ed2%
if Command1 in WinGetPos,WinGetActiveStats,MouseGetPos,ControlGetPos,
NewVar= %Ed1%|%Ed2%|%Ed3%|%Ed4%
if Command1= SplitPath
NewVar= %Ed2%|%Ed3%|%Ed4%|%Ed5%|%Ed6%
if Command1= FileGetShortcut
NewVar= %Ed2%|%Ed3%|%Ed4%|%Ed5%|%Ed6%|%Ed7%|%Ed8%
stringsplit, NextAr, NewVar, |
SetNewVar2:
loop, 7
{
if NextAr%A_Index%<>
{
NewAr:= NextAr%A_Index% . %a_spase%
if Shet= 0
    {
ContentVars= |%NewAr%
Shet= 1
    }
else
    {
Nal= 0
loop, parse, ContentVars, |
	{
	if a_loopfield= %NewAr%
	{
	Nal= 1
	break
	}
	}
if Nal= 0
ContentVars= %ContentVars%|%NewAr%
    }
}
}
return

Editing:
num= 1
loop, 10
{
Itemprop%num%=
num:= num+1
}
StringTrimRight, Propert, Propert, 1
if Propert <> 0
stringsplit, Itemprop, Propert, `,
if Itemprop1= 0
{
num= 1
loop, 10
{
num:= num+1
guicontrol,, Static%num%, %A_Spase%
}
}
else
loop, 10
{
Nst:= a_index+1
ItN:= %A_Spase% . Itemprop%A_Index%
guicontrol,, Static%Nst%, %ItN%
}
return

TX1:
SourceLabel= text
MouseGetPos,,,, OutputVarControl
ControlGetText, Outputtext, %OutputVarControl%, ahk_id %ScriptCreater%
if Outputtext=
return
Filter= *.*
if Outputtext in FilePattern,SourcePattern,Filename,DestPattern,Target,IconFile,LinkFile,ImageFile
{
if Outputtext= LinkFile
Filter= *.lnk
gui, +OwnDialogs
FileSelectFile, OutputEdit, , %A_WorkingDir%\любoй_в_этoй_пaпкe.xxx, Выбор адреса файла для вставки`:, %Filter%
if OutputEdit=
return
splitpath, OutputEdit, OutFileName, OutDir
if OutFileName= любoй_в_этoй_пaпкe.xxx
OutFileName= *.*
if Outputtext= LinkFile
{
if OutFileName= *.*
OutFileName= *.lnk
else
OutFileName= %OutFileName%.lnk
}
if OutDir= %A_WorkingDir%
TarG= %OutFileName%
else
TarG= %OutDir%\%OutFileName%
stringtrimleft, OutputNumber, OutputVarControl, 6
Tar:= OutputNumber+1
;msgbox %TarG% `n%Tar%
guicontrol,, edit%Tar%, %TarG%
return
}
if Outputtext in DirName,Source,Dest,Path,WorkingDir,RootDir,StartingFolder
{
FileSelectFolder, OutputEdit, , , Выбор адреса папки для вставки`:
if OutputEdit=
return
TarG= %OutputEdit%
stringtrimleft, OutputNumber, OutputVarControl, 6
Tar:= OutputNumber+1
guicontrol,, edit%Tar%, %TarG%
return
}
if Outputtext= Label
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
2ButtonL:
SelLab:
if NameW <> Выбор Hotkeys
NameW= Выбор метки
IfWinExist,ahk_id %IDNameW%
{
WinGetTitle,NameWind,ahk_id %IDNameW%
if NameWind= Выбор Hotkeys
gui, 2: destroy
if NameWind= Выбор метки
{
WinActivate, Выбор метки
return
}
}
gui, 2: default
gui, 2: +owner1 +toolwindow
if NameW= Выбор метки
gui, add, ddl, gSelectLab vNewLab, %LabelS%
if NameW= Выбор Hotkeys
gui, add, ddl, gSelectLab vNewLab, %HotkeyS%
gui, add, button,, Вставить
gui, add, button,  xp+61 yp wp hp, Перейти
gui, add, button,  xp+61 yp wp hp, Отмена
GUI,add,checkbox,xp-2 yp-25 gAvto vAvto,Автопереход
if NameW= Выбор метки
{
gui, add, button,  xp+63 yp+25 w20 h23, H
if HotkeyS=
GuiControl,Disable,Button5
}
if NameW= Выбор Hotkeys
{
gui, add, button,  xp+63 yp+25 w20 h23, L
if LabelS=
GuiControl,Disable,Button5
}
ControlGetPos,Xe1,Ye1,We1,,Edit1,ahk_id %ScriptCreater%
WinGetPos,Xscr,Yscr,,,ahk_id %ScriptCreater%
Ymou:= Ye1 + Yscr - 20
Xmou:= Xscr + Xe1 + We1 - 250
gui, show, x%Xmou% y%Ymou% w220, %NameW%
WinGet,IDNameW,ID,%NameW%
NameW=
guicontrol, disable, button1
guicontrol, disable, button2
if Avto= 0
GuiControl,,button4,0
Else
GuiControl,,button4,1
return
2ButtonH:
SelHtk:
IfWinExist,ahk_id %IDNameW%
{
WinGetTitle,NameWind,ahk_id %IDNameW%
if NameWind= Выбор метки
gui, 2: destroy
if NameWind= Выбор Hotkeys
{
WinActivate, Выбор Hotkeys
return
}
}
NameW= Выбор Hotkeys
gosub SelLab
return
}
if Outputtext in WinTitle,ExcludeTitle
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
return
}
if Outputtext in WinText,ExcludeText
{
GetText:
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
guicontrol,,static1, Правым кликом выбрать нужный текст.
hotkey, RButton, SelTip
hotkey, RButton, on
Tooltext= Выбор`nтекста
settimer, Tool, 100
settimer, Tool, on
return
GetText2:
OutputVarControl= Contro12
SourceLabel= menu
goto GetText
}
if Outputtext in Control,ControlID
{
GetControl:
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
guicontrol,,static1, Правым кликом выбрать нужный контрол.
hotkey, RButton, SelTip
hotkey, RButton, on
Tooltext= Выбор`nконтрола
settimer, Tool, 100
settimer, Tool, on
return
GetControl2:
OutputVarControl= Contro12
SourceLabel= menu
goto GetControl
}
if Outputtext= FontName
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
EdFont= 1
goto GetFont
}
if Outputtext= WhichButton
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
guicontrol, hide, edit%NumEdit%
guicontrol, show, combobox%NumStat%
guicontrol,, combobox%NumStat%, |
guicontrol,, combobox%NumStat%, LEFT|RIGHT|MIDDLE|WheelUp|WheelDown|X1|X2
return
}
if Outputtext= KeyName
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
guicontrol, hide, edit%NumEdit%
guicontrol, show, combobox%NumStat%
guicontrol,, combobox%NumStat%, |
guicontrol,, combobox%NumStat%, LButton|RButton|MButton|WheelUp|WheelDown|XButton1|XButton2|Joy1|JoyX|JoyY|JoyZ|JoyR|JoyU|JoyV|JoyPOV
return
}
if Outputtext in DriveLetter,Drive
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
DriveGet, list, list
DriveS=
Loop,Parse,list
{
if DriveS=
DriveS= |%A_LoopField%`:
else
DriveS= %DriveS%|%A_LoopField%`:
}
guicontrol, hide, edit%NumEdit%
guicontrol, show, combobox%NumStat%
guicontrol,, combobox%NumStat%, %DriveS%
SelectDrive= 1
return
}
if Outputtext= Attributes
{
guicontrol, hide, edit3
guicontrol, show, combobox2
guicontrol,, combobox2, |
guicontrol,, combobox2, READONLY|ARCHIVE|SYSTEM|HIDDEN|NORMAL|OFFLINE|TEMPORARY
return
}
if Outputtext= ButtonName
{
guicontrol, hide, edit3
guicontrol, show, combobox2
guicontrol,, combobox2, |
guicontrol,, combobox2, Yes|No|OK|Cancel|Abort|Ignore|Retry|Timeout
return
}
if Outputtext in WindowColor,ControlColor
{
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit2:= NumStat+1
Menu, ColorMenu, Show, %A_GuiX%, %A_GuiY%
return
}
if Outputtext= ColorID
{
GetColor:
guicontrol,,static1, Правым кликом выбрать пиксель нужного цвета.
NumEdit= 9
hotkey, RButton, SelTip
hotkey, RButton, on
Tooltext= Выбор`nцвета
settimer, Tool, 100
settimer, Tool, on
return
GetColor2:
SourceLabel= menu
goto GetColor
}
if Outputtext in PID,Name
{
GetPID:
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
guicontrol,,static1, Правым кликом выбрать окно нужного процесса.
hotkey, RButton, SelTip
hotkey, RButton, on
if Outputtext= PID
Tooltext= Выбор`nокна для`nизвлечения PID
if Outputtext= Name
Tooltext= Выбор`nокна для`nизвлечения`nимени процесса
settimer, Tool, 100
settimer, Tool, on
return
GetPIDname:
Outputtext= Name
goto GetPID2
GetPIDnum:
Outputtext= PID
GetPID2:
OutputVarControl= Contro12
SourceLabel= menu
goto GetPID
}
stringtrimleft, NumStat, OutputVarControl, 6
NumEdit:= NumStat+1
guicontrolget, visE, visible, Edit%NumEdit%
if visE= 1
ControlSetText,edit%NumEdit%,%Outputtext%,ahk_id %ScriptCreater%
return

Avto:
if Avto= 0
Avto= 1
Else
Avto= 0
return

SetColor:
SizeOfStructForChooseColor = 0x24 
VarSetCapacity(StructForChooseColor, SizeOfStructForChooseColor, 0) 
VarSetCapacity(StructArrayForChooseColor, 64, 0) 

InsertInteger(SizeOfStructForChooseColor, StructForChooseColor, 0)  ; DWORD lStructSize 
InsertInteger(GuiHWND, StructForChooseColor, 4)  ; HWND hwndOwner (makes dialog "modal"). 
InsertInteger(0x0 ,    StructForChooseColor, 8)  ; HINSTANCE hInstance 
InsertInteger(0x0 ,    StructForChooseColor, 12)  ; clr.rgbResult =  0; 
InsertInteger(&StructArrayForChooseColor , StructForChooseColor, 16)  ; COLORREF *lpCustColors 
InsertInteger(0x00000100 , StructForChooseColor, 20)  ; Flag: Anycolor 
InsertInteger(0x0 ,    StructForChooseColor, 24)  ; LPARAM lCustData 
InsertInteger(0x0 ,    StructForChooseColor, 28)  ; LPCCHOOKPROC lpfnHook 
InsertInteger(0x0 ,    StructForChooseColor, 32)  ; LPCTSTR lpTemplateName 

nRC := DllCall("comdlg32\ChooseColorA", str, StructForChooseColor)  
if (errorlevel <> 0) || (nRC = 0) 
{ 
   MsgBox error while calling ChooseColor Errorlevel: %errorlevel% - RC: %nRC% 
   return 
} 
SetFormat, integer, hex  
SetColor= % BGRtoRGB(ExtractInteger(StructForChooseColor, 12)) 
SetFormat, integer, d 
winactivate, ahk_id %ScriptCreater%
winwaitactive, ahk_id %ScriptCreater%
ControlSetText,edit%NumEdit2%,%SetColor%,ahk_id %ScriptCreater%
return

GetClass2:
SourceLabel= menu
GetClass:
guicontrol,,static1, Правым кликом выбрать окно нужного класса.
hotkey, RButton, SelTip
hotkey, RButton, on
Tooltext= Выбор`nкласса`nокна
settimer, Tool, 100
settimer, Tool, on
return

GetTitle2:
SourceLabel= menu
GetTitle:
guicontrol,,static1, Правым кликом выбрать окно с нужным заголовком.
hotkey, RButton, SelTip
hotkey, RButton, on
Tooltext= Выбор`nзаголовка
settimer, Tool, 100
settimer, Tool, on
return

Tool:
tooltip, %Tooltext%
ControlGetText,CurrentText,Static1,ahk_id %ScriptCreater%
Loop,Parse,CurrentText,`n
{
if A_Index= 1
FirstString= %A_LoopField%
}
MouseGetPos, Xpos, Ypos, OutputVarWin, OutputControl
if Tooltext= Выбор`nокна для`nизвлечения PID
{
WinGet, ProcID, PID, ahk_id %OutputVarWin%
ControlSetText,Static1,%FirstString%`nPID текущего окна - "%ProcID%",ahk_id %ScriptCreater%
}
if Tooltext= Выбор`nокна для`nизвлечения`nимени процесса
{
WinGet, ProcName, ProcessName, ahk_id %OutputVarWin%
ControlSetText,Static1,%FirstString%`nИмя процесса текущего окна - "%ProcName%",ahk_id %ScriptCreater%
}
if Tooltext= Выбор`nцвета
{
PixelGetColor,ColoR,%Xpos%,%Ypos%,RGB
ControlSetText,Static1,%FirstString%`nТекущий цвет - "%ColoR%",ahk_id %ScriptCreater%
}
if Tooltext= Выбор`nтекста
{
ControlGetText,TexT, %OutputControl%, ahk_id %OutputVarWin%
Stringlen, Dlina, TexT
if Dlina > 40
Stringleft, TexT, TexT, 40
ControlSetText,Static1,%FirstString%`nТекущий текст - "%TexT%",ahk_id %ScriptCreater%
}
if Tooltext= Выбор`nзаголовка
{
WinGetTitle,TitlE, ahk_id %OutputVarWin%
ControlSetText,Static1,%FirstString%`nТекущий заголовок - "%TitlE%",ahk_id %ScriptCreater%
}
if Tooltext= Выбор`nкласса`nокна
{
WinGetClass,TitlE, ahk_id %OutputVarWin%
ControlSetText,Static1,%FirstString%`nТекущий класс окна - "%TitlE%",ahk_id %ScriptCreater%
}
if Tooltext= Выбор`nконтрола
ControlSetText,Static1,%FirstString%`nТекущий контрол - "%OutputControl%",ahk_id %ScriptCreater%
return

SelTip:
traytip, ok, ап%OutputVarWin%, 1
keywait, rbutton, D
keywait, rbutton,
MouseGetPos, Xpos, Ypos, OutputVarWin, OutputControl
if Tooltext= Выбор`nокна для`nизвлечения PID
WinGet, ProcID, PID, ahk_id %OutputVarWin%
if Tooltext= Выбор`nокна для`nизвлечения`nимени процесса
WinGet, ProcName, ProcessName, ahk_id %OutputVarWin%
if Tooltext= Выбор`nцвета
PixelGetColor,ColoR,%Xpos%,%Ypos%,RGB
if Tooltext= Выбор`nтекста
{
ControlGetText,TexT, %OutputControl%, ahk_id %OutputVarWin%
Stringlen, Dlina, TexT
if Dlina > 40
Stringleft, TexT, TexT, 40
}
if Tooltext= Выбор`nзаголовка
WinGetTitle,TitlE, ahk_id %OutputVarWin%
if Tooltext= Выбор`nкласса`nокна
WinGetClass,TitlE, ahk_id %OutputVarWin%
hotkey, RButton, off
settimer, Tool, off
tooltip
if Tooltext= Выбор`nконтрола
msgbox, 1, Выбор контрола, Выбран контрол:`n "%OutputControl%"
if Tooltext= Выбор`nтекста
msgbox, 1, Выбор текста, Выбран текст:`n "%TexT%"
ifmsgbox cancel
return
winactivate ahk_id %ScriptCreater%
winwaitactive ahk_id %ScriptCreater%
gosub SmenaRask
sleep, 200
if SourceLabel= text
{
if Tooltext= Выбор`nокна для`nизвлечения PID
ControlSetText,edit%NumEdit%,%ProcID%,ahk_id %ScriptCreater%
if Tooltext= Выбор`nокна для`nизвлечения`nимени процесса
ControlSetText,edit%NumEdit%,%ProcName%,ahk_id %ScriptCreater%
if Tooltext= Выбор`nцвета
ControlSetText,edit%NumEdit2%,%ColoR%,ahk_id %ScriptCreater%
if Tooltext= Выбор`nзаголовка
ControlSetText,edit%NumEdit%,%TitlE%,ahk_id %ScriptCreater%
if Tooltext= Выбор`nкласса`nокна
ControlSetText,edit%NumEdit%,ahk_class %TitlE%,ahk_id %ScriptCreater%
if Tooltext= Выбор`nтекста
ControlSetText,edit%NumEdit%,%TexT%,ahk_id %ScriptCreater%
if Tooltext= Выбор`nконтрола
ControlSetText,edit%NumEdit%,%OutputControl%,ahk_id %ScriptCreater%
}
if SourceLabel= menu
{
if Tooltext= Выбор`nокна для`nизвлечения PID
Command2= %ProcID%
if Tooltext= Выбор`nокна для`nизвлечения`nимени процесса
Command2= %ProcName%
if Tooltext= Выбор`nцвета
Command2= %ColoR%
if Tooltext= Выбор`nзаголовка
Command2= %TitlE%
if Tooltext= Выбор`nкласса`nокна
Command2= ahk_class %TitlE%
if Tooltext= Выбор`nтекста
Command2= %TexT%
if Tooltext= Выбор`nконтрола
Command2= %OutputControl%
goto Inserting
}
if LanG= e
gosub Vozvrat
return

2buttonОтмена:
2guiclose:
gui, 2: destroy
NumEdit= 0
return
3buttonОтмена:
3guiclose:
gui, 3: destroy
NumEdit= 0
return

2buttonВставить:
gui, 2: submit, nohide
if NewLab=
return
winactivate ahk_id %ScriptCreater%
ControlSetText,Edit%NumEdit%,%NewLab%,ahk_id %ScriptCreater%
NumEdit= 0
if Avto2= 1
GuiControl,,button4,1
guicontrol, disable, button1
return

$^<sc021>::
WinGet,Atit,ID,A
if Atit<> %ScriptCreater%
{
if Atit<> %IDFindwintit%
{
if Atit<> %IDNameW%
{
send, ^{sc021}
return
}
}
}
Find:
IfWinExist,ahk_id %IDFindwintit%
{
WinGetTitle,NameWind,ahk_id %IDFindwintit%
if NameWind= Найти и заменить
gui, 3: destroy
if NameWind= Найти...
{
WinActivate, Найти...
return
}
}
Repl=0
Findwintit= Найти...
Find2:
gui, 3: default
gui, 3: +owner1 +toolwindow
GUI,add,edit,r1 w200 gMySearch vMySearch, %MySearch%
GUI,add,ddl,xp yp wp gSelSear vSelSear,текст|переменную|метку|команду|Hotkey|HotString
GUI,add,button, default w60,Найти
GUI,add,button, wp,Отмена
GUI,add,groupbox,xp+70 yp-35 w130 h60,Начиная с...
GUI,add,radio,xp+10 yp+20 Checked,Текущего места
GUI,add,radio,xp yp+20 vNachal,Начала
if Repl=1
{
GUI,add,button,xp-80 yp+30 w90 gReplasing,Заменить на...
GUI,add,edit,xp+95 yp w105 vReplas, %Replas%
}
ControlGetPos,Xe1,Ye1,We1,,Edit1,ahk_id %ScriptCreater%
WinGetPos,Xscr,Yscr,,,ahk_id %ScriptCreater%
Ymou:= Ye1 + Yscr + 69
Xmou:= Xscr + Xe1 + We1 - 250
gui, show, x%Xmou% y%Ymou%,%Findwintit%
WinGet,IDFindwintit,ID,%Findwintit%
control, hide,, edit1, Найти
gui, 3: submit, nohide
if SelSear=
{
guicontrol, disable, Найти
guicontrol, disable, Заменить на...
}
return

$^<sc019>::
WinGet,Atit,ID,A
if Atit<> %ScriptCreater%
{
if Atit<> %IDFindwintit%
{
if Atit<> %IDNameW%
{
send, ^{sc019}
return
}
}
}
Replase:
IfWinExist,ahk_id %IDFindwintit%
{
WinGetTitle,NameWind,ahk_id %IDFindwintit%
if NameWind= Найти...
gui, 3: destroy
if NameWind= Найти и заменить
{
winactivate, Найти и заменить
return
}
}
Repl=1
Findwintit= Найти и заменить
goto Find2

Replasing:
Replas=
gui, 3: submit, nohide
gosub Search1
SendMessage, 0xC2, 0, &Replas,, ahk_id %MyEditID%  ; em_replacesel, заменить.
Return

3guiescape:
control, show,, combobox1, Найти
control, hide,, edit1, Найти
GuiControl,, combobox1, |текст|переменную|метку|команду|Hotkey|HotString
guicontrol, disable, Найти
guicontrol, disable, Заменить на...
Return

SelSear:
gui, 3: submit, nohide
if SelSear= текст
{
control, hide,, combobox1, Найти
control, show,, edit1, Найти
ControlSetText,Edit1,"Esc" для возврата,ahk_id %IDFindwintit%
sleep, 1000
ControlSetText,Edit1, ,ahk_id %IDFindwintit%
if MySearch<>
{
guicontrol, enable, Найти
guicontrol, enable, Заменить на...
}
return
}
else
if SelSear= назад_к_выбoру
{
GuiControl,, combobox1, |текст|переменную|метку|команду|Hotkey|HotString
guicontrol, disable, Найти
guicontrol, disable, Заменить на...
}
else
if SelSear= переменную
GuiControl,, combobox1, |назад_к_выбoру|------------------|%ContentVars%
else
if SelSear= метку
GuiControl,, combobox1, |назад_к_выбoру|------------------|%LabelS%
else
if SelSear= команду
GuiControl,, combobox1, |назад_к_выбoру|------------------||%Command%
else
if SelSear= Hotkey
GuiControl,, combobox1, |назад_к_выбoру|------------------|%HotkeyS%
else
if SelSear= HotString
GuiControl,, combobox1, |назад_к_выбoру|------------------|%ConHstr%
else
if SelSear= 
{
guicontrol, disable, Найти
guicontrol, disable, Заменить на...
}
else
if SelSear= ------------------
{
guicontrol, disable, Найти
guicontrol, disable, Заменить на...
}
else
{
guicontrol, enable, Найти
guicontrol, enable, Заменить на...
}
return

MySearch:
gui, 3: submit, nohide
if MySearch=
{
guicontrol, disable, Найти
guicontrol, disable, Заменить на...
}
else
{
guicontrol, enable, Найти
guicontrol, enable, Заменить на...
}
return

$^PgDn::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, ^{PgDn}
Return
}
Prygok2:
Prygok = 0
GuiControl,,Static16,LI
goto Prygok3
$^PgUp::
ifwinnotactive, ahk_id %ScriptCreater%
{
send, ^{PgUp}
Return
}
Prygok:
Prygok = 1
GuiControl,,Static16,ГI
Prygok3:
If LabelS=
{
GetKeyState,StCtrl,Ctrl,P
if StCtrl= U
KeyWait,LButton
else
KeyWait,Ctrl
GuiControl,,Static16,
Return
}
ControlGet,Choice,Choice,,ComboBox14,ahk_id %ScriptCreater%
if Choice=
GuiControl, Choose, ComboBox14, 1
SendMessage, 0x147, 0, 0, ComboBox14, ahk_id %ScriptCreater%
ChoicePos = %ErrorLevel%  ; It will be -1 if there is no item selected.
if Prygok = 1
send, ^{home}
else
{
ChoicePos += 1
ChoicePos += 1
}
GuiControl, Choose, ComboBox14, %ChoicePos%
ControlGet,Choice,Choice,,ComboBox14,ahk_id %ScriptCreater%
StringLower, Pattern, Choice
Pattern= %Pattern%`:
gosub Searching2
GetKeyState,StCtrl,Ctrl,P
if StCtrl= U
KeyWait,LButton
else
KeyWait,Ctrl
GuiControl,,Static16,
Return

3buttonНайти:
gui, 3: submit, nohide
Search1:
guicontrol,, button4, 1
ControlFocus, edit1, ahk_id %ScriptCreater%
if Nachal= 2
Send, ^{home}
guicontrolget, visMS, visible, Edit1
guicontrolget, visSS, visible, combobox1
if visMS= 1
StringLower, Pattern, MySearch
if visSS= 1
StringLower, Pattern, SelSear
Searching2:
Controlgettext, Source,, ahk_id %MyEditID%
if Source=
Return
StringLower, Source, Source
PatternLength:=StrLen(Pattern)
ForSearch= 1
gosub Searching
return

2buttonПерейти:
if Avto= 1
GuiControl,,button4,1
gui, 2: submit, nohide
if NewLab=
return
Controlgettext, Source,, ahk_id %MyEditID%
StringLower, Source, Source
StringLower, Pattern, NewLab
Pattern= `r`n%Pattern%`:
PatternLength:=StrLen(Pattern)
ControlFocus, edit1, ahk_id %ScriptCreater%
if Prygok<> 1
Send, ^{home}
Prygok= 0
ForSearch= 0
Searching:
StartSel=
EndSel=
SendMessage, 0xB0, &StartSel, &EndSel,, ahk_id %MyEditID%
StartPos:=ExtractIntegerF(EndSel)+1                      ; Перейти от счёта с 0 к счёту с 1.
  FoundPos:=InStr(Source, Pattern, 0, StartPos)           ; Искать позицию строки.
  If(!FoundPos)
  {
    if ForSearch= 0
     {
     StringTrimLeft,Pattern,Pattern,2
     goto Searching
     }
    Msgbox, Не найдено.
    exit
  }
  EndPos:=FoundPos+PatternLength                               ; Позиция конца выделения.
  SendMessage, 0xB1, FoundPos-1, EndPos-1,, ahk_id %MyEditID%  ; em_setsel, выделить.
  SendMessage, 0xB7,,,, ahk_id %MyEditID% 
ControlGet,CountLine,LineCount,,edit1,ahk_id %ScriptCreater%
ControlGet,Cline1,CurrentLine,,edit1,ahk_id %ScriptCreater%
if ForSearch= 0
{
send, {pgdn}
ControlGet,Cline2,CurrentLine,,edit1,ahk_id %ScriptCreater%
ToEnd:= CountLine - Cline1
PgSz:= Cline2 - Cline1
;ToolTip %Cline2% < %CountLine%
if Cline2 < %CountLine%  
send, {pgup}
;MsgBox ok
if Cline1 > %PgSz%
send, {PgDn}
}
SendMessage, 0xB1, FoundPos-1, EndPos-1,, ahk_id %MyEditID%
Source=
Pattern=
NumEdit= 0
GuiControl, 1: ChooseString, ComboBox14, %NewLab%
return

ExtractIntegerF(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4)
{
    Loop %pSize%
        result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1)
    if (!pIsSigned OR pSize > 4 OR result < 0x80000000)
        return result
    return -(0xFFFFFFFF - result + 1)
}

SelectLab:
gui, 2: submit, nohide
if NewLab=
return
guicontrol, enable, button2
if NumEdit<> 0
{
guicontrol, enable, button1
GuiControl,,button4,0
Avto2= %Avto%
return
}
GuiControlGet,Avto1, ,Button4
if Avto1= 1
Goto 2buttonПерейти
return

guidropfiles:
Gui, +OwnDialogs 
SplitPath,A_GuiControlEvent,,,ExtFile
if ExtFile<> ahk
{
if ExtFile<> exe
{
msgbox Файл "%A_GuiControlEvent%" `nне является скриптом ahk.
return
}
else
IfExist,%ahk_dir%\Exe2Ahk.exe
OpenFilter= *.exe
else IfExist,%A_ScriptDir%\Exe2Ahk.exe
OpenFilter= *.exe
else
{
MsgBox Декомпилятор в рабочей директории `nи в директории Autohotkey не найден.
Return
}
}
WinGetTitle, TitScr, ahk_id %ScriptCreater%
stringtrimleft, TitScr, TitScr, 16
if Saved= 0
{
msgbox, 3,,  Файл %TitScr% был изменен. Сохранить изменения?
ifmsgbox cancel
return
ifmsgbox no
goto DaleeGD
else
gosub Saving
}
DaleeGD:
if RunName= Reload%A_Tab%Ctrl+R
{
msgbox, 3,,  Скрипт "%TitScr%" загружен. Выгрузить?
ifmsgbox cancel
return
ifmsgbox no
goto NeVygr2
else
{
Send,#^!{f12}
Menu,ServMenu,rename,%RunName%,Выполнить...%A_Tab%Ctrl+R
RunName= Выполнить...%A_Tab%Ctrl+R
Menu,ServMenu,Disable,Выгрузить %A_Tab%Ctrl+Alt+Win+f12
}
}
NeVygr2:
ItemFile= %A_GuiControlEvent%
Saved= 0
goto ClearRun2

GuiSize:
wEd1:= A_GuiWidth-20
wSt1:= wEd1 + 16
hEd1:= A_GuiHeight-198
hSt1:= A_GuiHeight-7
GuiControl,Move,edit1,w%wEd1% h%hEd1%
GuiControl,Move,static12, h%hSt1%
GuiControl,Move,static13, h%hSt1% x%wSt1%
CoordMode,ToolTip,Relative
loop, parse, ListPos, `n
{
if a_loopfield=
break
stringsplit, PosArr, a_loopfield, -
if a_index in 1,3,4,53,54
continue
if a_index in 56,57,58
{
NewPosX:= A_GuiWidth-(607-PosArr2)
NewPosY:= A_GuiHeight-(PosforStyle-PosArr3)
GuiControl,MoveDraw,%PosArr1%, x%NewPosX% y%NewPosY%
continue
}
NewPosY:= A_GuiHeight-(PosforStyle-PosArr3)
if a_index between 29 and 48
{
if A_GuiWidth>1035
      {
if Position= 0
	{
	NewPosX:= PosArr2+432
	NewPosY:= NewPosY-42
	GuiControl,Move,%PosArr1%, x%NewPosX% 
	if a_index= 48
	Position= 1
	}
else
NewPosY:= NewPosY-42
      }
if A_GuiWidth<1034
      {
if Position= 1
	{
	NewPosX= %PosArr2%
	GuiControl,Move,%PosArr1%, x%NewPosX% 
	if a_index= 48
	Position= 0
	}
      }
}
GuiControl,Move,%PosArr1%, y%NewPosY%
if a_index in 5,6,8,55
{
NewPosW:= A_GuiWidth-(607-PosArr4)
GuiControl,Move,%PosArr1%, w%NewPosW%
}
guicontrolget, visCon, visible, %PosArr1%
if visCon= 1
{
GuiControl,Hide,%PosArr1%
GuiControl,Show,%PosArr1%
}
}
return

Renaming:
WinGetTitle, TitScr, ahk_id %ScriptCreater%
stringtrimleft, TitScr, TitScr, 16
StringLeft,StTitScr,TitScr,1
StringTrimLeft,TitScr,TitScr,1
WinSetTitle, ahk_id %ScriptCreater%, , ScriptCreater - %TitScr%%StTitScr%
Return

RegVars:
guicontrol,, static1,
gosub Skrytie
gosub Ochistka3
ContentVars=
LabelS= 
HotkeyS=
Shet= 0
RegVars2:
loop, parse, OpenI, `n
{
IfInString,A_LoopField,`;
{
StringSplit,Array,A_LoopField,`;
StringRight,PredPos,Array1, 1
If PredPos= ``
goto BezOtm
else
    {
if Array1<>
	{
	Loopfield= %Array1%
	goto Otmen
	}
    }
}
BezOtm:   
stringtrimright, Loopfield, A_Loopfield, 1
Otmen:
loop
{
Loopfield= %Loopfield%
stringright, EndStr, Loopfield, 1
if EndStr in %a_tab%,`;
stringtrimright, Loopfield, Loopfield, 1
else
break
}
if Loopfield<>
loop
{
stringleft, StartS, Loopfield, 1
if StartS in %А_Space%,%a_tab%
stringtrimleft, Loopfield, Loopfield, 1
else
break
}
if StartS= `:
gosub HotStr
else
{
stringright, FinStr, Loopfield, 1
if FinStr= `:
gosub FindLabel
IfInString,Loopfield,::
	{
	StringReplace,OutLoopfield,Loopfield,::,¤
	StringSplit,OutLoopfield,OutLoopfield,¤
	IfInString,OutLoopfield1,`,
	continue
	HTKey= %OutLoopfield1%
	ItHotK= 0
	loop, parse, HotkeyS, |
	{
	if a_loopfield= %HTKey%
	ItHotK= 1
	}
	if ItHotK= 0
	HotkeyS= %HotkeyS%|%HTKey%
	Menu, ServMenu, enable, Hotkeys %A_Tab%Ctrl+H
	Ifwinexist,ahk_id %IDNameW%
	Control,Enable,,Button5,ahk_id %IDNameW%
	}
}
stringsplit, LoopArr, Loopfield, `,
if LoopArr1 in ControlSend,ControlSendRaw,ControlSetText,FileAppend,IniWrite,MsgBox,RegWrite,Send,SendRaw,SendMessage,ToolTip,TrayTip,#EscapeChar,#CommentFlag
continue
ifinstring, Loopfield, `=
 {
stringleft, StartStr, Loopfield, 2
if StartStr<> if 
   {
stringsplit, Varyable, Loopfield, `=
IfInString,Varyable1,`(
continue
IfInString,Varyable1,`)
continue
stringright, DublPoi,Varyable1, 1
if DublPoi= ``
continue
if DublPoi in `:,`+,`-,`<,`>,`!,`=,`*,`.,`|,`&,`^
stringtrimright, ItVar,Varyable1, 1
else
ItVar= %Varyable1%
if Shet= 0
    {
ContentVars= |%ItVar%
Shet= 1
    }
else
    {
Nal= 0
loop, parse, ContentVars, |
	{
	if a_loopfield= %ItVar%
	{
	Nal= 1
	break
	}
	}
if Nal= 0
ContentVars= %ContentVars%|%ItVar%
    }
   }
 }
else
   {
stringleft, StartStr, Loopfield, 2
if StartStr= if
continue
else
      {
ItVar= 
loop, 9
ComArr%a_index%=
stringsplit, ComArr, Loopfield, `,
if ComArr1 in ControlGet,ControlGetFocus,ControlGetText,DriveGet,DriveSpaceFree,FileGetSize,FileGetTime,FileGetVersion,FileRead,FileReadLine,FileSelectFile,FileSelectFolder,FormatTime,GetKeyState,GuiControlGet,IniRead,Input,InputBox,PixelGetColor,Random,RegRead,SoundGet,SoundGetWaveVolume,StatusBarGetText,StringGetPos,StringLeft,StringLen,StringLower,StringMid,StringReplace,StringRight,StringSplit,StringTrimLeft,StringTrimRight,StringUpper,SysGet,Transform,WinGetActiveTitle,WinGetClass,WinGet,WinGetText,WinGetTitle
ItVar= %ComArr2%
if ComArr1 in PixelSearch,ImageSearch
ItVar= %ComArr2%|%ComArr3%
if ComArr1 in WinGetPos,WinGetActiveStats,MouseGetPos,ControlGetPos
ItVar= %ComArr2%|%ComArr3%|%ComArr4%|%ComArr5%
if ComArr1= SplitPath
ItVar= %ComArr3%|%ComArr4%|%ComArr5%|%ComArr6%|%ComArr7%
if ComArr1= FileGetShortcut
ItVar= %ComArr3%|%ComArr4%|%ComArr5%|%ComArr6%|%ComArr7%|%ComArr8%|%ComArr9%
if ComArr1 in GUI,ControlSend,ControlSendRaw,ControlSetText,FileAppend,Menu,IniWrite,MsgBox,RegWrite,Send,SendRaw,SendMessage,ToolTip,TrayTip,#EscapeChar,#CommentFlag
continue
if ItVar= 
continue
loop, parse, ItVar, |
	{
	if A_Loopfield=
	continue
	else
	NextAr%A_Index%= %A_Loopfield%
	}
if ComArr1 in ControlGet,ControlGetFocus,ControlGetText,DriveGet,DriveSpaceFree,FileGetSize,FileGetTime,FileGetVersion,FileRead,FileReadLine,FileSelectFile,FileSelectFolder,FormatTime,GetKeyState,GuiControlGet,IniRead,Input,InputBox,PixelGetColor,Random,RegRead,SoundGet,SoundGetWaveVolume,StatusBarGetText,StringGetPos,StringLeft,StringLen,StringLower,StringMid,StringReplace,StringRight,StringSplit,StringTrimLeft,StringTrimRight,StringUpper,SysGet,Transform,WinGetActiveTitle,WinGetClass,WinGet,WinGetText,WinGetTitle,PixelSearch,ImageSearch,WinGetPos,WinGetActiveStats,MouseGetPos,ControlGetPos,SplitPath,FileGetShortcut
gosub SetNewVar2
     }
   }
}
GuiControl,,ComboBox14,%LabelS%
GuiControl, Choose, ComboBox14, 1
return

HotStr:
ItHotStr= 0
loop, parse, ConHstr, |
{
if a_loopfield= %HTKey%
ItHotStr= 1
}
if ItHotStr= 0
{
if Loopfield<>
ConHstr= %ConHstr%|%Loopfield%
}
Return

FindLabel:
stringright, EndStr, Loopfield, 1
if EndStr= `:
stringtrimright, LabeL, Loopfield, 1
IfInString,LabeL,`,
Return
IfInString,LabeL, `;
Return
IfInString,LabeL,`(
Return
IfInString,LabeL,`)
Return
LabeL= %LabeL%
stringright, HotK, LabeL, 1
if HotK= ``
return
if HotK= `:
{
stringtrimright, HTKey, LabeL, 1
ItHotK= 0
loop, parse, HotkeyS, |
{
if a_loopfield= %HTKey%
ItHotK= 1
}
if ItHotK= 0
HotkeyS= %HotkeyS%|%HTKey%
else
if ZagScr2=
{
SoundPlay,*16
loop, 3
{
ControlSetText,Static1,,ahk_id %ScriptCreater%
sleep, 500
ControlSetText,Static1,!!!Возможна ошибка`: `nВ данном скрипте горячая клавиша `n"%HTKey%" продублирована!!!,ahk_id %ScriptCreater%
sleep, 500
}
}
Menu, ServMenu, enable, Hotkeys %A_Tab%Ctrl+H
Ifwinexist,ahk_id %IDNameW%
Control,Enable,,Button5,ahk_id %IDNameW%
return
}
else
{
ItLab= 0
loop, parse, LabelS, |
{
if a_loopfield= %LabeL%
ItLab= 1
}
if ItLab= 0
LabelS= %LabelS%|%LabeL%
else
if ZagScr2=
{
SoundPlay,*16
loop, 3
{
ControlSetText,Static1,,ahk_id %ScriptCreater%
sleep, 500
ControlSetText,Static1,!!!Возможна ошибка`: `nВ данном скрипте метка `n"%LabeL%" продублирована!!!,ahk_id %ScriptCreater%
sleep, 500
}
}
Menu, ServMenu, enable, Метки %A_Tab%Ctrl+L
Ifwinexist,ahk_id %IDNameW%
Control,Enable,,Button5,ahk_id %IDNameW%
}
return

removetooltip:
settimer, removetooltip, off
tooltip
return

SmenaRask:
               if A_DetectHiddenWindows = Off ; если работа со скрытыми окнами отключена, то...
        {
                DetectHiddenWindows, On ; включаем работу со скрытыми окнами
                Change_Hidden = 1 ; запоминаем, что включили работу со скрытыми окнами
        }
        if A_TitleMatchMode <> 2 ; если режим не равен "искать в любой части заголовка окна", то...
        {
                TitleMatchMode_Before := A_TitleMatchMode ; запоминаем текущий режим
                SetTitleMatchMode, 2 ; переключаемся на режим "искать в любой части заголовка окна"
                Change_TitleMatchMode = 1
                ;запоминаем, что переключились на режим "сравнивать с любой частью заголовка окна"
        }
        if A_FormatInteger <> H ; если текущий числовой формат не шестнадцатеричный, то...
        {
                SetFormat, integer, H ; переключаемся на шестнадцатеричный формат
                Change_Format = 1 ; запоминаем, что переключили формат
        }
        WinGet, Active_Window_ID, ID, ahk_id %ScriptCreater%
        Active_Window_Thread := DllCall("GetWindowThreadProcessId", "UInt", Active_Window_ID, "UInt", 0)        ;получаем для активного окна ID его потока через Win API
        Lang_In_Window := DllCall("GetKeyboardLayout", "UInt", Active_Window_Thread)        ;получаем текущую раскладку для найденного потока активного окна через Win API
        if Change_Hidden = 1 ; если включали работу со скрытыми окнами, то...
                DetectHiddenWindows, Off ; отключаем работу со скрытыми окнами
        if Change_TitleMatchMode = 1 ; если меняли режим сравнения заголовков, то...
                SetTitleMatchMode, %TitleMatchMode_Before% ; возвращаем режим сравнения заголовков
        if Change_Format = 1 ; если переключались на шестнадцатеричный формат, то...
                SetFormat, integer, D 
if Lang_In_Window = 0x4090409
{
if LangName= EN
WinMenuSelectItem,ahk_id %ScriptCreater%,,%LangName%
}
return

Vozvrat:
if LangName= RU
WinMenuSelectItem,ahk_id %ScriptCreater%,,%LangName%
return

$!<sc02A>::
IfWinNotActive, ahk_id %ScriptCreater%
{
send, !{sc02A}
Return
}
else
goto SetLang
$+<sc038>::
IfWinNotActive, ahk_id %ScriptCreater%
{
send, +{sc038}
Return
}
else
goto SetLang
$+<sc01D>::
IfWinNotActive, ahk_id %ScriptCreater%
{
send, +{sc01D}
Return
}
else
goto SetLang
$^<sc02A>::
IfWinNotActive, ahk_id %ScriptCreater%
{
send, ^{sc02A}
Return
}
else
goto SetLang
SetLang:
KeyWait,Shift
sleep, 100
DetectHiddenWindows_Before := A_DetectHiddenWindows
    DetectHiddenWindows, On
    TitleMatchMode_Before := A_TitleMatchMode
    SetTitleMatchMode, 2
    FormatInteger_Before := A_FormatInteger
    SetFormat, integer, H
    WinGet, Active_Window_ID, ID, ahk_id %ScriptCreater%
    Active_Window_Thread := DllCall("GetWindowThreadProcessId", "UInt", Active_Window_ID, "UInt", 0)
    Lang_In_Window := DllCall("GetKeyboardLayout", "UInt", Active_Window_Thread)
    DetectHiddenWindows, %DetectHiddenWindows_Before%
    SetTitleMatchMode, %TitleMatchMode_Before%
    SetFormat, integer, %FormatInteger_Before%
if Lang_In_Window = 0x4090409
{
if LangName= EN
WinMenuSelectItem,ahk_id %ScriptCreater%,,%LangName%
}
else
{
if LangName= RU
WinMenuSelectItem,ahk_id %ScriptCreater%,,%LangName%
}
Return

ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4) 
{ 
   SourceAddress := &pSource + pOffset  
   result := 0  
   Loop %pSize% 
   { 
      result := result | (*SourceAddress << 8 * (A_Index - 1))  
      SourceAddress += 1  
   } 
   if (!pIsSigned OR pSize > 4 OR result < 0x80000000) 
      return result 
   return -(0xFFFFFFFF - result + 1) 
} 

InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4) 
{ 
   mask := 0xFF  
   Loop %pSize%  
   { 
      DllCall("RtlFillMemory", UInt, &pDest + pOffset + A_Index - 1, UInt, 1 
         , UChar, (pInteger & mask) >> 8 * (A_Index - 1)) 
      mask := mask << 8  
   } 
} 

BGRtoRGB(oldValue) 
{ 
  Value := (oldValue & 0x00ff00) 
  Value += ((oldValue & 0xff0000) >> 16) 
  Value += ((oldValue & 0x0000ff) << 16)  
  return Value 
} 
return 

;BGRtoRGB(pColorBGR) 
;{ 
;   return (pColorBGR & 0xFF) << 16 | ((pColorBGR >> 8) & 0xFF) | (pColorBGR >> 16) 
;}

#IfWinActive ScriptCreater
:*B0:#Al::lowSameLineComments
:*B0:#Cl::ipboardTimeout
:*B0:#Co::mmentFlag
:*B0:#Er::rorStdOut
:*B0:#Es::capeChar
:*B0:#Inc::clude
:*B0:#Ke::yHistory
:*B0:#No::TrayIcon
:*B0:#Pe::rsistent
:*B0:#Si::ngleInstance
:*B0:#Us::eHook
:*B0:#Wi::nActivateForce
:*:Blo::BlockInput
:*:Bre::Break
:*:Cri::Critical
:*:Dll::DllCall(
:*:Get::GetKeyState
:*:Hot::Hotkey
:*:IfI::IfInString
:*:IfM::IfMsgBox
:*:Msg::MsgBox
:*:OnE::OnExit
:*:OnM::OnMessage
:*:Post::PostMessage
:*:Proc::Process
:*:Prog::Progress
:*:Ran::Random
:*:Relo::Reload
:*:Ret::Return
:*:Setn::SetNumlockState
:*:Setf::SetFormat
:*:Setk::SetKeyDelay
:*:Setm::SetMouseDelay
:*:Setb::SetBatchLines
:*:Shu::Shutdown
:*:Sus::Suspend
:*:Thr::Thread
:*:URL::URLDownloadToFile
#IfWinActive

~^<sc012>::
IfWinNotActive,ahk_id %ScriptCreater%
Return
Redact:
ControlFocus,Edit1,ahk_id %ScriptCreater%
ControlGet,Cline,CurrentLine,,edit1,ahk_id %ScriptCreater%
ControlGet,itemline,Line,%Cline%,edit1,ahk_id %ScriptCreater%
StringLeft,StartL,itemline,1
if StartL= `;
{
MsgBox Для редактирования строки`nнужно ее раскомментировать.
Return
}
StatRed= 1
StatRed2= 1
IfInString,itemline,`;
StringSplit,itemline,itemline,`;
else
itemline1= %itemline%
if itemline1<>
{
Loop,Parse,itemline1,`,
{
b_loopfield= %a_loopfield%
loop
     {
StringLeft,Startfield,b_loopfield,1  
if (Startfield = " ")
StringTrimLeft,b_loopfield,b_loopfield,1
else
if Startfield = %a_tab%
StringTrimLeft,b_loopfield,b_loopfield,1
else
if Startfield = #
	{
	DirectiV= 1
	Break
	}
else
	{
	DirectiV= 0
	Break
	}
     }
loop
     {
StringRight,Finfield,b_loopfield,1
if (Finfield = " ")
StringTrimRight,b_loopfield,b_loopfield,1
else
if Finfield = %a_tab%
StringTrimRight,b_loopfield,b_loopfield,1
else
Break
     }
if A_Index= 1
     {
gosub Vozvrat
StringLeft,Startfield,b_loopfield,1  
if Startfield in `{,`}
StringTrimLeft,b_loopfield,b_loopfield,1
ControlFocus,edit2,ahk_id %ScriptCreater%
if DirectiV= 1
send, +{sc004}
send, %b_loopfield%
sleep, 200
     }
else
     {
EditN:= A_Index + 1
guicontrolget, visE, visible, Edit%EditN%
guicontrolget, visC, visible, combobox%A_Index%
if visE= 1
	{
	Gosub SmenaRask
	ControlSetText,edit%EditN%,%b_loopfield%,ahk_id %ScriptCreater%
	}
if visC= 1
	{
	gosub Vozvrat
	Control,ChooseString,%b_loopfield%,combobox%A_Index%,ahk_id %ScriptCreater%
	sleep, 200
	}
     }
}
}
return

SelColFont:
gui, font, c%Fcolor%
guiControl,Font,Edit1
Return
