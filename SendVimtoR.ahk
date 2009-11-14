; F3 �I��͈͂�R Console�ɑ��� #WinActivateForce
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

; F4 ���݂̍s��R Console�ɑ����Ď��̍s��.�@ESS��C-n�Ɠ����D (for gvim)
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

; C-c v�Ō��݂̃J�[�\�����̃I�u�W�F�N�g�̃w���v������. (for gvim)
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

; C-M-q(Ctrl+Alt+q) R Console�������オ���Ă���ΏI��������
    #IfWinExist, R Console
    !^q::
    {
        WinActivate, R Console
        sendinput, quit(save="no"){enter}
    }
return

; q��Rgui�̃w���v������Ƃ���gvim�̃E�B���h�E������΃A�N�e�B�u�ɂ���
    #IfWinActive, R Help on
    q::
    IfWinExist, ahk_class Vim
    {
        Send, q
        WinActivate, ahk_class Vim
    }
return


