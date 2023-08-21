set nocompatible              " be iMproved, required
filetype off                  " required
"------------------------------------------------------------

"Plugins
"------------------------------------------------------------
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'patstockwell/vim-monokai-tasty'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-commentary'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'uiiaoo/java-syntax.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-unimpaired'
"All of your Plugins must be added before the following line
call vundle#end() 

"Pathogen Support
execute pathogen#infect()

filetype plugin indent on
"------------------------------------------------------------

"Plugin Configs
"------------------------------------------------------------
"Fzf
"<C-t> : new tab, <C-v> : vertical split, <C-x> horizontal split
"Arrow keys for navigation
":Rg - ripgrep, :Buffers, :Colors, :Snippets
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
nnoremap <C-p> :Files<CR>

"Monokai
let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty
let g:airline_theme='monokai_tasty'

"Solarized
"let g:solarized_termcolors=256
"set background=light
"colorscheme solarized

"Airline  
let g:airline#extensions#whitespace#enabled = 0

"Advanced Higlight (octol) 
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1

"UltiSnips 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Undo tree  
nnoremap <F5> :UndotreeToggle<CR>

"Error Marker
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
let errormarker_disablemappings = 1
let mapleader = "["
nmap <leader>cc :ErrorAtCursor<CR>
nmap <leader>cr :RemoveErrorMarkers<CR>
"------------------------------------------------------------

"General editor settings
"------------------------------------------------------------
set tabstop=4
set nocompatible
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set ruler
set showcmd
set incsearch
set shellslash
set number
set relativenumber
set cino+=L0
set cb=unnamed
set t_Co=256
set foldmethod=marker
syntax on
setlocal indentkeys-=:
"------------------------------------------------------------
"Don't auto highlight missing curlies : 
let c_no_curly_error = 1

"Java Syntax Highlighting : 
highlight link javaDelimiter NONE
highlight link javaIdentifier NONE

"Netrw display and toggle :
inoremap <c-f> <Esc>:Lex<CR>:vertical resize 30<CR>
nnoremap <c-f> <Esc>:Lex<CR>:vertical resize 30<CR>

"Keybindings for { completion
inoremap {<CR>  {<CR>}<Esc>O
inoremap {}     {}
"Escape key too far
imap jk         <Esc>
"Select all
map <C-a> <esc>ggVG<CR>
"Disable bell sound
set belloff=all

"Document shortcuts : 
let mapleader = "."
"Copy all to clipboard
nmap<leader>c :%y<CR>
"Source file
nmap<leader>so :source %<CR>
"Indent whole document
nmap<leader>i ggVG=

"cpp specific shortcuts : 
let mapleader = ","
nmap<leader>s gg/solve<CR>o
nmap<leader>d gg/cin >> tc<CR>gcc<CR>?solve<CR>o
nmap<leader>b ggdG:0r ~/templates/basic.cpp<CR>
nmap<leader>a ggdG:0r ~/templates/Template.cpp<CR>

"General shortcuts and aliases : 
cnoreabbrev <expr> te getcmdtype() == ":" && getcmdline() == 'te' ? 'tabedit' : 'te'
"Enter key to quicly switch between splits 
nmap mw <C-w>w
"Undo accidentally pressing enter
inoremap <C-\> <C-o>:left 0<CR><BS>

"Load C++ template into new files : 
autocmd BufNewFile *.cpp 0r ~/templates/Template.cpp
"autocmd BufNewFile *.cpp 0r ~/templates/basic.cpp
"Load makefile template into new files : 
 :autocmd BufNewFile  makefile 0r ~/templates/makefile_tmpl
"------------------------------------------------------------

"Build 
"------------------------------------------------------------
"C++
autocmd filetype cpp nnoremap <F9> :w <bar> !build.sh %:r <CR>
set makeprg=build.sh\ %:r
autocmd filetype cpp nnoremap <F9> :w <bar> Make <CR>
autocmd filetype cpp nnoremap <F10> :!./%:r<CR>

"C
autocmd filetype c nnoremap<F9> :w <bar> !gcc -lm -Wall % -o %:r <CR>
autocmd filetype c nnoremap<F10> :!./%:r<CR>

"Java
autocmd filetype java nnoremap<F9> :w <bar> !javac %<CR>
autocmd filetype java nnoremap<F10> :!java %:r<CR>
"------------------------------------------------------------

"Added Functionality
"------------------------------------------------------------
"Link Clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
        augroup WSLYank
                    autocmd!
                            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
                                augroup END
                            endif

"Cursor Management :
if &term =~ 'xterm'
  let &t_SI = "\<Esc>[1 q"
  let &t_EI = "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif
"------------------------------------------------------------
" Misc
"------------------------------------------------------------
