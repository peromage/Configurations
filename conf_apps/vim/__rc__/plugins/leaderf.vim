""
"" Created by peromage on 2020/06/04
""
"" LeaderF settings
""

Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}


let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
"let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
"let g:Lf_PreviewResult = {'Function': 1, 'Colorscheme': 1, 'BufTag': 1, 'File': 1}
let g:Lf_StlSeparator = {'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline"}
let g:Lf_ShowHidden = 1
let g:Lf_JumpToExistingWindow = 0

nnoremap <leader>fF :Leaderf<space>
nnoremap <silent> <leader>fp :Leaderf file --no-ignore<CR>
nnoremap <silent> <leader>fb :Leaderf buffer<CR>
nnoremap <silent> <leader>fm :Leaderf mru<CR>
nnoremap <silent> <leader>ft :Leaderf tag<CR>
nnoremap <silent> <leader>fT :Leaderf bufTag<CR>
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>f# :Leaderf line --cword<CR>
nnoremap <silent> <leader>fg :Leaderf rg<CR>
nnoremap <silent> <leader>fG :Leaderf rg --all-buffers<CR>
nnoremap <silent> <leader>f* :Leaderf rg --cword<CR>
nnoremap <silent> <leader>fn :Leaderf --next<CR>
nnoremap <silent> <leader>fN :Leaderf --previous<CR>
nnoremap <silent> <leader>ff :Leaderf --recall<CR>
nnoremap <silent> <leader>fh :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fw :Leaderf window<CR>
nnoremap <silent> <leader>fi :Leaderf self<CR>

