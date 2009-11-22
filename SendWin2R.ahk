;; 概要
; Windowsアプリケーション(e.g. メモ帳)から便利にRを使うためのスクリプト
; SendVimtoR.ahkをgvim以外のアプリに拡張したもの

;; F3 選択範囲を送信
; c.f. SendVimtoR.ahk

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
