""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice (Neo)Vim initialization
"
" Created by peromage 2021/02/24
" Last modified 2021/03/16
"
"
" This section should remain untouched
" General initialization (use :PlugInstall for the first time)
"
let g:init_home = expand('<sfile>:p:h')
let g:init_file = expand('<sfile>:p')
comm! InitFile exec 'edit '.g:init_file
exec 'set rtp+='.g:init_home
"
" Initialization template. To avoid merge conflicts, copy lines below to the
" end of the file to start your customization.
"
call rice#begin()
"
" Examples of configuration options
"
" Color scheme. Leave this unset to use default color.
"-----------------------------------------------------
"let g:rice_color = 'dracula'
"
" Check 'rice/init-plugs.vim' for more groups
"--------------------------------------------
"let g:rice_plug_group = ['basic', 'syntax', 'coc', 'git']
"
" Set Python runtime for Vim or NeoVim
"-------------------------------------
"let g:rice_neovim_python_interpreter = 'python3'
"let g:rice_vim_python_home = '/path/to/python_dir'
"let g:rice_vim_python_dll = '/path/to/python.dll'
"
" Extra Coc plugins
" To override default extensions define this variable after rice#end()
"---------------------------------------------------------------------
"let g:coc_global_extensions = [
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]
"
" Extra plugins via vim-plug
" To override default bundles define vim-plug after rice#end()
"-------------------------------------------------------------
"Plug 'Kenta11/helloworld-vim'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"### Rice config should start before this line ###
call rice#end()
"### Other config should start after this line ###
