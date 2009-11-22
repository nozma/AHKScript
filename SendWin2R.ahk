;; 概要
; Windowsのgvim上でRが使いやすくなるスクリプト．
; 選択範囲をRに送信する機能だけは他のアプリケーション(memopad, word, excel, etc.)でも基本的に使用可能．
; http://tolstoy.newcastle.edu.au/R/e7/help/09/06/0013.htmlを参考にしています．

;; 動作条件
; WindowsでRとAutoHotkeyがインストールされている
; Rguiへのパスが通っている(コマンドラインから rgui とコマンドを叩いて実行できる)
; Windows7, R 2.10.0, AutoHotkey 1.0.48.05で動作確認

;; ホットキーリスト
; F3:    選択範囲をR Consoleに送って実行．選択がない場合はクリップボード内を送る．
;        キーを離すまでウィンドウのフォーカスはRのまま．
; F4:    現在の行をR Consoleに送って実行し，次の行に進む(gvimのみ)．
; C-c v: カーソル下のオブジェクト名でヘルプを引く(gvimのみ)．
; C-M-q: R Consoleの終了
; q:     R Helpを閉じる．その際gvimが立ち上がっていればgvimをアクティブにする．

; F3 Send selected region to R. #WinActivateForce
    F3::
    {
        WinGet, active_id, ID, A
        IfWinActive, ahk_class Vim
            Send y
        else
            Send ^c
        IfWinNotExist, R Console
        {
            Run, rgui --sdi
            WinWait, R Console
        }
        WinActivate, R Console
        sendinput, {Raw}%clipboard%
        sendinput, {enter}
        KeyWait, F3
        WinActivate, ahk_id %active_id%
    }
    return

;; For vim
#IfWinActive, ahk_class Vim
; F4 Send the current line in the gvim, and moves to the next line. (for gvim)
    F4::
    {
        WinGet, active_id, ID, A
        Send 0y$j ; yank the current line and moves to the next line
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

; C-c v Get help. (for gvim)
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
#IfWinActive

; C-M-q(Ctrl+Alt+q) Quit R Console.
#IfWinExist, R Console
    !^q::
    {
        WinActivate, R Console
        sendinput, quit(save="no"){enter}
    }
return
#IfWinExist

; q Quit R Help and return to gvim.
#IfWinActive, R Help on
    q::
    IfWinExist, ahk_class Vim
    {
        Send, q
        WinActivate, ahk_class Vim
    }
    else Send, q
    WinActivate, ahk_id %active_id%
return
#IfWinActive

;; for Windows applications 
; Windowsアプリケーション(e.g. メモ帳)から便利にRを使うためのスクリプト

#IfWinnotActive, ahk_class Vim    ; VimのはSendVimtoR.ahk
;; F4 Send the current line and moves to the next line.
F4::
{
    WinGet, active_id, ID, A
        Send, {home}{shiftdown}{end}{shiftup}^c{down}{home}
        IfWinNotExist, R Console
        {
            Run, rgui --sdi
                WinWait, R Console
        }
    WinActivate, R Console
        sendinput, {Raw}%clipboard%
        sendinput, {enter}
    WinActivate, ahk_id %active_id%
}
return

;; C-c v Get help.
^c::
Input, OutputVar, C I M T1, {esc},v
if ErrorLevel = Match
{
    WinGet, active_id, ID, A
        Send, {ctrldown}{left}{shiftdown}{right}{ctrlup}{shiftup}^c{left}
    IfWinNotExist, R Console
    {
        Run, rgui --sdi
            WinWait, R Console
    }
    WinActivate, R Console
        sendinput, {Raw}help(%clipboard%)
        sendinput, {enter}
    IfWinNotExist
        WinActivate, ahk_id %active_id%
}
return


#IfWinnotActive
