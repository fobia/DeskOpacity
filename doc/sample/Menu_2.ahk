; ПРИМЕР №2: Этот скрипт создаёт всплывающее меню, вызываемое комбинацией Win-Z.

; Создать всплывающее меню добавлением пунктов в него.
Menu, MyMenu, Add, Item1, MenuHandler
Menu, MyMenu, Add, Item2, MenuHandler
Menu, MyMenu, Add  ; Добавить разделитель.

; Создать другое меню для использования его как подменю.
Menu, Submenu1, Add, Item1, MenuHandler
Menu, Submenu1, Add, Item2, MenuHandler

; Добавить подменю в первое меню.
Menu, MyMenu, Add, My Submenu, :Submenu1

Menu, MyMenu, Add  ; Добавить разделитель ниже подменю.
Menu, MyMenu, Add, Item3, MenuHandler  ; Добавить новый пункт ниже подменю.
return  ; Конец секции автовыполнения.

MenuHandler:
MsgBox Вы выбрали %A_ThisMenuItem% из меню %A_ThisMenu%.
return

#z::Menu, MyMenu, Show  ; Показывать меню по нажатию Win-Z. 