""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice GUI configuration loader
"
" Created by peromage 2021/03/14
" Last modified 2021/03/14
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Read global config variables
"-------------------------------------------------------------------------------
let s:rt = {}

" Color
if rice#get_var('rice_gui_font', s:rt)
    let &guifont = s:rt.value
endif

" Frontend
if has('nvim')
    if rice#get_var('rice_gui_neovim_frontend', s:rt)
        execute "IncRiceGui " . s:rt.value . '.vim'
    endif
else
    if rice#get_var('rice_gui_vim_frontend', s:rt)
        execute "IncRiceGui " . s:rt.value . '.vim'
    endif
endif
