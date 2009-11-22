;; �T�v
; Windows��gvim���R���g���₷���Ȃ�X�N���v�g�D
; �I��͈͂�R�ɑ��M����@�\�����͑��̃A�v���P�[�V����(memopad, word, excel, etc.)�ł���{�I�Ɏg�p�\�D
; http://tolstoy.newcastle.edu.au/R/e7/help/09/06/0013.html���Q�l�ɂ��Ă��܂��D

;; �������
; Windows��R��AutoHotkey���C���X�g�[������Ă���
; Rgui�ւ̃p�X���ʂ��Ă���(�R�}���h���C������ rgui �ƃR�}���h��@���Ď��s�ł���)
; Windows7, R 2.10.0, AutoHotkey 1.0.48.05�œ���m�F

;; �z�b�g�L�[���X�g
; F3:    �I��͈͂�R Console�ɑ����Ď��s�D�I�����Ȃ��ꍇ�̓N���b�v�{�[�h���𑗂�D
;        �L�[�𗣂��܂ŃE�B���h�E�̃t�H�[�J�X��R�̂܂܁D
; F4:    ���݂̍s��R Console�ɑ����Ď��s���C���̍s�ɐi��(gvim�̂�)�D
; C-c v: �J�[�\�����̃I�u�W�F�N�g���Ńw���v������(gvim�̂�)�D
; C-M-q: R Console�̏I��
; q:     R Help�����D���̍�gvim�������オ���Ă����gvim���A�N�e�B�u�ɂ���D

; C-M-r Run R, and return focus.
!^r::
{
    WinGet, active_id, ID, A
        Run, rgui --sdi
        WinWait, R Console
        WinActivate, ahk_id %active_id%
}
return

; C-M-Shift-r Run R.
+!^r::
{
    Run, rgui --sdi
        WinWait, R Console
}
return

; Activate hotkeys while exists R Console.
#IfWinExist R Console
; F3 Send selected region to R. #WinActivateForce
F3::
{
    WinGet, active_id, ID, A
        IfWinActive, ahk_class Vim
        Send y
        else Send ^c
        WinActivate, R Console
            sendinput, {Raw}%clipboard%
            sendinput, {enter}
        KeyWait, F3
            WinActivate, ahk_id %active_id%
}
return

; F4 Send the current line, and moves to the next line.
F4::
{
    WinGet, active_id, ID, A
    IfWinActive, ahk_class Vim
    Send 0y$j ; for gvim
    else Send {home}{shiftdown}{end}{left}{shiftup}^c{down}{home} ; for other windows application
    WinActivate, R Console
        sendinput, {Raw}%clipboard%
        sendinput, {enter}
    WinActivate, ahk_id %active_id%
}
return 

; C-c v Get help. 
#IfWinNotActive, ahk_class Vim
~^c::
Input, OutputVar, C I M T1, {Esc},v
if ErrorLevel = Match 
{
    WinGet, active_id, ID, A
    Send {ctrldown}{left}{shiftdown}{right}{ctrlup}{shiftup}^c{left}
    WinActivate, R Console
        sendinput, {Raw}help(%clipboard%)
        sendinput, {enter}
    IfWinNotExist, R help on
        WinActivate, ahk_id %active_id%
}
return
#IfWinNotActive
; for gvim
#IfWinActive, ahk_class Vim
^c::
Input, OutputVar, C I M T1, {Esc},v
if ErrorLevel = Match 
{
    WinGet, active_id, ID, A
    Send yiw ; yank word
    WinActivate, R Console
        sendinput, {Raw}help(%clipboard%)
        sendinput, {enter}
    IfWinNotExist, R help on
        WinActivate, ahk_id %active_id%
}
return
#IfWinActive

; C-M-q(Ctrl+Alt+q) Quit R Console.
!^q::
{
    WinActivate, R Console
        sendinput, quit(save="no"){enter}
}
return

; q Quit R Help and return to window.
#IfWinActive, R Help on
q::
{
    Send, q
        WinActivate, ahk_id %active_id%
}
return
#IfWinActive

#IfWinExist
