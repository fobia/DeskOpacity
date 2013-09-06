; ПРИМЕР №1: Этот скрипт добавляет новый пункт внизу меню в трее.

#Persistent  ; Выполнять скрипт, пока не закроет пользователь.
Menu, tray, add  ; Добавить разделитель.
Menu, tray, add, Пункт1, MenuHandler  ; Добавить новый пункт.
return

MenuHandler:
MsgBox Вы выбрали %A_ThisMenuItem% из меню %A_ThisMenu%.
return 