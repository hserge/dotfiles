set nocompatible    " turn off compatibility with the old vi
set ls=2            " always show status line
set hlsearch        " do not highlight words  set hlsearch
set ai              " set auto-indenting on for programming
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set number          " show line numbers
set title           " show title in console title bar
set ttyfast         " smoother changes
set novisualbell    " turn off visual bell
set noerrorbells    " turn off audible bell
set lbr             " turn on wrap at word
set showmatch       " automatically show matching brackets
set matchtime=15    " Wait 1.5 seconds for showmatch
set binary noeol    " do NOT put a carriage return at the end of the last line!
set backspace=indent,eol,start  " make the backspace key work the way it should
set mouse=a         " mouse support
set wrap

set linebreak
set nolist          " list disables line break
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set textwidth=0
set wrapmargin=0
set formatoptions+=l
set tabstop=4       " set our tabs to four spaces
set shiftwidth=4    " indent to four spacer
set expandtab       " tabs as spaces

set enc=utf-8
au BufNewFile,BufRead *.ejs set filetype=html
au! BufRead,BufNewFile *.json set filetype=json

" Set color based on terminal
if $TERM == 'xterm-256color'
    set t_Co=256
else
    set t_Co=16
endif

syntax on           " syntax highlighing
colorscheme default

set cursorline cursorcolumn

set printoptions=paper:letter

" Mapping
map <ESC>[A <Up>
map <ESC>[B <Down>
map <ESC>[C <Right>
map <ESC>[D <Left>
imap <ESC>[A <Up>
imap <ESC>[B <Down>
imap <ESC>[C <Right>
imap <ESC>[D <Left>

map <ESC>[19~ :split<C-M>
map <ESC>[20~ :bp<C-M>
map <ESC>[23~ :bn<C-M>
map <ESC>[31~ :bd<C-M>

" Editing a protected file as 'sudo', save the changes use :W instead of :w
cmap W w !sudo tee % >/dev/null<CR>


" Toggle Paste Stage
map <Leader>p :set paste!<CR>

" Toggle Line Numbers
map <Leader>l :set nonu!<CR>

" Open Buffers
map <Leader>b :buffers<CR>

" open Marks
map <Leader>m :marks<CR>

" Toggle Paste Stage
map <Leader>p :set paste!<CR>

" Clean up
map <Leader>w :%s/\s\+$//<CR>

" Functions
if v:version >= 700
    let b:lastspelllang='en'
    function! ToggleSpell()
    if &spell == 1
        let b:lastspelllang=&spelllang
        setlocal spell!
    elseif b:lastspelllang
        setlocal spell spelllang=b:lastspelllang
    else
        setlocal spell spelllang=en
    endif
    endfunction

    nmap <Leader>s :call ToggleSpell()<CR>

    setlocal spell spelllang=en
    setlocal nospell
endif

" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Git handling
noremap <Leader>g :!clear; git status<CR>
noremap <Leader>d :!clear; git diff %<CR>

" Search for word
noremap <Leader>a :Ack <cword><CR>

" PHP Validation
map <Leader>v :!clear; php -l %<CR>

" JSLint Validation
"   https://github.com/reid/node-jslint
map <Leader>j :!clear; jslint %<CR>


" Online doc search
function! OnlineDoc()
    if &ft =~ "php"
        let s:urlTemplate  = "http://www.php.net/manual-lookup.php?pattern=%&lang=en&scope=quickref"
    elseif &ft =~ "perl"
        let s:urlTemplate  = "http://perldoc.perl.org/search.html?q=%"
    elseif &ft =~ "javascript"
        let s:urlTemplate  = "https://developer.mozilla.org/en-US/search?q=%"
    elseif &ft =~ "java"
        let s:urlTemplate  = "http://search.oracle.com/search/search?search.                                                        timezone=480&search_startnum=&search_endnum=&num=10&search_dupid=&exttimeout=false&actProfId=0&q=%&group=Documentation&sw=t&search_p_main_operator=all&search_p_atname=&adn=&search_p_op=equals&search_p_val=&search_p_atname=&adn=&search_p_op=equals&search_p_val="
    elseif &ft =~ "ruby"
        let s:urlTemplate  = "http://ruby-doc.com/search.html?q=%"
    elseif &ft =~ "python"
        let s:urlTemplate  = "http://docs.python.org/2.6/search.html?q=%&check_keywords=yes&area=default"
    elseif &ft =~ "lua"
        let s:urlTemplate  = "http://www.lua.org/manual/5.2/"
    elseif &ft =~ "conf"
        let s:urlTemplate  = "https://www.google.com/search?q=%+site:httpd.apache.org"
    elseif &ft =~ "sh"
        let s:urlTemplate  = "http://man.cx/%"
    else
        let s:urlTemplate  = "http://www.google.com/search?q=%"
    endif

    let s:wordUnderCursor = expand("<cword>")
    let s:url = substitute(s:urlTemplate, "%", s:wordUnderCursor, "g")
    exec "!elinks \"" . s:url . "\""
    redraw!
endfunction

map <Leader>k :call OnlineDoc()<CR>


" Open URL
function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!elinks \"" . s:uri . "\""
        redraw!
    else
        echo "No URI found in line."
    endif
endfunction

map <Leader>o :call HandleURI()<CR>
