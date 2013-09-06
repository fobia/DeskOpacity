; ПРИМЕР №3: Этот скрипт демонстрирует разнообразные команды меню.

#Persistent
#SingleInstance
menu, tray, add ; separator
menu, tray, add, TestToggle&Check
menu, tray, add, TestToggleEnable
menu, tray, add, TestDefault
menu, tray, add, TestStandard
menu, tray, add, TestDelete
menu, tray, add, TestDeleteAll
menu, tray, add, TestRename
menu, tray, add, Test
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TestToggle&Check:
menu, tray, ToggleCheck, TestToggle&Check
menu, tray, Enable, TestToggleEnable ; Разблокирует пункт TestToggleEnable.
menu, tray, add, TestDelete ; Similar to above.
return

TestToggleEnable:
menu, tray, ToggleEnable, TestToggleEnable
return

TestDefault:
if default = TestDefault
{
    menu, tray, NoDefault
    default =
}
else
{
    menu, tray, Default, TestDefault
    default = TestDefault
}
return

TestStandard:
if standard <> n
{
    menu, tray, NoStandard
    standard = n
}
else
{
    menu, tray, Standard
    standard = y
}
return

TestDelete:
menu, tray, delete, TestDelete
return

TestDeleteAll:
menu, tray, DeleteAll
return

TestRename:
if NewName <> renamed
{
    OldName = TestRename
    NewName = renamed
}
else
{
    OldName = renamed
    NewName = TestRename
}
menu, tray, rename, %OldName%, %NewName%
return

Test:
MsgBox, Вы выбрали "%A_ThisMenuItem%" из меню "%A_ThisMenu%".
return