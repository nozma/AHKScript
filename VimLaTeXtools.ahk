;; Vim-LaTeX[http://vim-latex.sourceforge.net/]使用時にちょっと楽する
#IfWinExist ahk_class SUMATRA_PDF_FRAME
#IfWinActive ahk_class Vim
^g:: winactivate ahk_class SUMATRA_PDF_FRAME
#IfWinActive ahk_class SUMATRA_PDF_FRAME
^g:: winactivate ahk_class Vim
#IfWinActive
#IfWinExist
