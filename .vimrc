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
Plugin 'voldikss/vim-floaterm'
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
nmap [cc :ErrorAtCursor<CR>
nmap ]cr :RemoveErrorMarkers<CR>
nmap [tg :copen<CR>
nmap ]tg :cclose<CR>

"Floaterm
let g:floaterm_wintype='float'
let g:floaterm_autoclose=0
nnoremap   <silent>   <F6>   :FloatermToggle<CR>
tnoremap   <silent>   <F6>   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <F7>   :FloatermNew<CR>
tnoremap   <silent>   <F7>   <C-\><C-n>:FloatermKill<CR>
"------------------------------------------------------------

"General editor settings
"------------------------------------------------------------
set tabstop=4
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
set timeoutlen=1000
set ttimeoutlen=10
"------------------------------------------------------------
"Enable persistent undo :
let &undodir = expand('~/.vim/UndoDump/')
set undofile

"Don't auto highlight missing curlies : 
let c_no_curly_error = 1

"Ignore whitespace in diff :
if &diff
    set diffopt+=iwhite
endif

"Java Syntax Highlighting : 
highlight link javaDelimiter NONE
highlight link javaIdentifier NONE

"Netrw display and toggle :
inoremap <c-f> <Esc>:Lex<CR>:vertical resize 30<CR>
nnoremap <c-f> <Esc>:Lex<CR>:vertical resize 30<CR>

"Keybindings for { completion
inoremap {<CR>  {<CR>}<Esc>O
inoremap {}     {}
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

"Splits control
nmap fw <C-w>w
nmap fj <C-w>j
nmap fk <C-w>k
nmap fl <C-w>l
nmap fh <C-w>h
nmap fo <C-w>o

"Undo accidentally pressing enter
inoremap <C-\> <C-o>:left 0<CR><BS>

"Moving lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"Load C++ template into new files : 
autocmd BufNewFile *.cpp 0r ~/templates/Template.cpp
"autocmd BufNewFile *.cpp 0r ~/templates/basic.cpp
"Load makefile template into new files : 
 :autocmd BufNewFile  makefile 0r ~/templates/makefile_tmpl
"------------------------------------------------------------

"Build 
"------------------------------------------------------------
"C++
autocmd filetype cpp nnoremap <F8> :w <bar> !build.sh %:r <CR>
set makeprg=build.sh\ %:r
autocmd filetype cpp nnoremap <F9> :w <bar> Make <CR>
autocmd filetype cpp nnoremap <F10> :call CppOutputBuilder()<CR> 
autocmd filetype cpp nnoremap <F11> :!./%:r <CR>
autocmd filetype cpp nnoremap <F12> :call RunSampleTests()<CR>

"C
autocmd filetype c nnoremap<F9> :w <bar> !gcc -lm -Wall % -o %:r <CR>
autocmd filetype c nnoremap<F10> :!./%:r<CR>

"Java
autocmd filetype java nnoremap<F9> :w <bar> !javac %<CR>
autocmd filetype java nnoremap<F10> :!java %:r<CR>

"Python
autocmd filetype py nnoremap<F9> :w <bar> python3 %<CR>
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

" My Functions
"------------------------------------------------------------
function! ExecuteWithTimeout(exec_cmd, timeout)
    let timeout_cmd = "timeout " . a:timeout/1000 . "s " . a:exec_cmd
    let output = system(timeout_cmd)
    return output
endfunction

function! IsTermRunning(buf)
    return getbufvar(a:buf, '&buftype') !=# 'terminal' ? 0 :
        \ has('terminal') ? term_getstatus(a:buf) =~# 'running' :
        \ 0
endfunction

function! s:PeriodicChecker(timer_id) abort
    let done = (IsTermRunning(bufnr('%')) == 0)
    " If terminal is in finished state, stop the timer
    if done
        call timer_stop(a:timer_id)
        wincmd l
        vsplit
        wincmd l
        bel terminal cat /tmp/stderr.txt
        wincmd k
        edit /tmp/stdout.txt
        wincmd h
    endif
endfunction

function! CppOutputBuilder()
    " If there are multiple buffers open, keep only current
    if len(getbufinfo({'buflisted':1})) != 1
        wincmd o
    endif
    " Run the executable in a terminal split
    vertical terminal ++shell ++cols=40 ./%:r >/tmp/stdout.txt 2>/tmp/stderr.txt
    " Wait for input by checking if terminal is running every 0.5s
    let timer_id = timer_start(500, 's:PeriodicChecker', {'repeat': -1})
endfunction

function! RunSampleTests()
    let F = expand("%:r")
    let tc_dir = expand("%:p:h").'/'."testcases"
    let pattern = tc_dir.'/'.F."_in".'*'.".txt"
    
    let noTC = 1
    for input_file in glob(pattern,0,1)
        let noTC = 0
        let exec_cmd = "./".F." < ".input_file." > /tmp/tmpout.txt 2>/dev/null"
        call ExecuteWithTimeout(exec_cmd,5000)
        if v:shell_error
            echo "ERROR: File Execution Failed"
            return
        endif
        let test_number = matchstr(fnamemodify(input_file, ":r"), '.$')
        let tmp_output = "/tmp/tmpout.txt"
        let correct_output = tc_dir.'/'.F."_out".test_number.".txt"
        
        let tmp_lines = readfile(tmp_output)
        for i in range(len(tmp_lines))
            let tmp_lines[i] = substitute(tmp_lines[i], '\s\+$', '', '')
        endfor
        let correct_lines = readfile(correct_output)

        if join(correct_lines) != join(tmp_lines)
            execute "FloatermNew --height=0.8 --width=0.8 vimdiff -d ".tmp_output." ".correct_output
            return
        endif
    endfor
    
    if noTC == 1
        echo "No TCs found for this problem"
        return
    endif

    hi Col guifg=#ff0000 ctermfg=green
    echohl Col
    echo "≡ƒÄè AC ≡ƒÄè"
    echohl NONE

endfunction
