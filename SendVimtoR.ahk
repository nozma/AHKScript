; F3 選択範囲をR Consoleに送る #WinActivateForce
    F3::
    {
        WinGet, active_id, ID, A
        IfWinActive, ahk_class Vim
            Send y ;yank selected region
        else
            Send ^c  ; copy selection to clipboard
        IfWinNotExist, R Console
        {
            Run, rgui --sdi
            WinWait, R Console
        }
        WinActivate, R Console
        sendinput, {Raw}%clipboard%
        sendinput, {enter}
        ;Sleep 1000
        WinActivate, ahk_id %active_id%
    }
return

; F4 現在の行をR Consoleに送って次の行へ.　ESSのC-nと同じ． (for gvim)
    #IfWinActive, ahk_class Vim
    F4::
    {
        WinGet, active_id, ID, A
        Send 0y$j ; yank current line and go next line
        IfWinNotExist, R Console
        {
            Run, rgui  --sdi
            WinWait, R Console
        }
        WinActivate, R Console
        sendinput, {Raw}%clipboard%
        sendinput, {enter}
        WinActivate, ahk_id %active_id%
    }
return 

; C-c vで現在のカーソル下のオブジェクトのヘルプを引く. (for gvim)
    #IfWinActive, ahk_class Vim
    ^c::
    Input, OutputVar, C I M T1, {Esc},v
    if ErrorLevel = Match 
    {
        WinGet, active_id, ID, A
        Send yiw ; yank word
        IfWinNotExist, R Console
        {
            Run, rgui --sdi
            WinWait, R Console
        }
        WinActivate, R Console
        sendinput, {Raw}help(%clipboard%)
        sendinput, {enter}
        IfWinNotExist, R help on
            WinActivate, ahk_id %active_id%
    }
return

; C-M-q(Ctrl+Alt+q) R Consoleが立ち上がっていれば終了させる
    #IfWinExist, R Console
    !^q::
    {
        WinActivate, R Console
        sendinput, quit(save="no"){enter}
    }
return

; qでRguiのヘルプを閉じたときにgvimのウィンドウがあればアクティブにする
    #IfWinActive, R Help on
    q::
    IfWinExist, ahk_class Vim
    {
        Send, q
        WinActivate, ahk_class Vim
    }
return


