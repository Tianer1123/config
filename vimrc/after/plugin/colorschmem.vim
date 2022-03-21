set background=dark
" set background=light
" {{{
let g:gruvbox_material_palette = 'original'
"let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
"let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_transparent_background = 1
"let &t_ZH="\e[3m"
"let &t_ZR="\e[23m"
colorscheme gruvbox-material
" }}}
"
" {{{
"colorscheme dracula
" }}}
"
" {{{
" solarized setting
" colorscheme solarized8
" }}}
" 背景透明transparent bg
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
