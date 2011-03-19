if has("gui_macvim")
   " disable the original Cmd-T (open new tab)
   macmenu &File.New\ Tab key=<nop>
   " map Cmd-T to the CommandT plugin
   map <D-t> :CommandT<CR>
endif

