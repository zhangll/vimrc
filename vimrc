" install on macvim brew install macvim --with-cscope --with-lua --HEAD brew install vim --with-lua

"git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


"nocompatible with vi{
    set nocompatible
    filetype off 
"}

" Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
" }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Basic Config                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"basic config {
    "colorscheme desert  
    "UI settings {
        if LINUX()
                set guifont=Monaco\ 10
           elseif OSX()
                set guifont=Monaco:h13 "Consolas:h14
           elseif WINDOWS()
                set guifont=Monaco:h9
                source $VIMRUNTIME/mswin.vim
                behave mswin
                au GUIEnter * simalt ~x
                "if has("gui_running")
                "    set guioptions-=l
                "    set guioptions-=L
                "    "set guioptions-=r
                "    "set guioptions-=R
                "    set guioptions-=T
                "endif
        end
    "}
    
    set nobackup  
    set autoread  
    "set clipboard+=unnamed
    "set clipboard+=unnamedplus
    set autochdir
    set hlsearch   
    set incsearch
    set ignorecase

    "python indent config
    set shiftwidth=4  
    set ts=4	
    set expandtab
    set autoindent 
    set laststatus=2            
    set cmdheight=1             
    set nu!                     
    set foldlevelstart=99
    set iskeyword+=-

    set paste " keep paste format
    
    set iskeyword+=_,$,@,%,#,-

    "set cc=120
    "highlight OverLength ctermbg=red ctermfg=white guibg=#592929 
    "match OverLength /\%121v.\+/

    nnoremap <F2> :g/^\s*$/d<CR>  "remote blank line

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    "autocmd! bufwritepost .vimrc source %  " auto reload .vimrc

    cnoremap w!! %!sudo tee > /dev/null %
   
"}

" compile and run
map <C-CR> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc


" ENCODING {
    set fencs=utf-8,gbk
    set encoding=utf-8
    set fileencodings=utf-8,gbk,cp936,latin-1
	"set encoding=prc
    source $VIMRUNTIME/delmenu.vim 
    source $VIMRUNTIME/menu.vim 
    language messages zh_CN.utf-8
"}

" Enable omni completion.{
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
"}
"{
    set completeopt=longest,menuone
    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
    inoremap <expr> <c-n> pumvisible() ? "\<c-n>" : "\<c-n>\<c-r>=pumvisible() ? \"\\<down>\" : \"\\<cr>\""
    inoremap <expr> <m-;> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>\<c-n>\<c-p>\<c-r>=pumvisible() ? \"\\<down>\" : \"\\<cr>\""
"}


"key map event binding{
    "imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>  
    map <UP> <C-W>+ 
    map <DOWN> <C-W>-
    map <LEFT> <C-W><
    map <RIGHT> <C-W>>
    let mapleader = "," 
"}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Plugins                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bundle start {
    set rtp+=~/.vim/bundle/Vundle/
    call vundle#begin()
    Bundle 'gmarik/Vundle'
"}

" Bundle List {
    "UI Inhance {
        " solarized:
        Bundle 'altercation/vim-colors-solarized'
        
        Plugin 'bling/vim-airline'
    "}
    Bundle 'Markdown'
    Bundle 'EasyMotion'
    Bundle 'surround.vim'
    " tagbar {
        Bundle 'Tagbar'
        let g:tagbar_width = 25
        nmap <F8> :TagbarToggle<CR>   
        let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8_1/bin/ctags' 
    "}



    " nerdtree:
    Bundle 'scrooloose/nerdtree'
    map <F2> :NERDTreeToggle<CR>   
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=0
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0

    " ctrlp {
        Bundle 'ctrlp.vim'
        let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$|\.class$'}
        let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'
    " }



    " pymode:
    Bundle 'klen/python-mode'
    let g:pymode_rope_autoimport = 0
    let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
    let g:pymode_utils_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_lint_ignore = "E501"
    let g:pymode_rope_complete_on_dot = 0
    "let g:pymode_rope_completion_bind = '<A-/>'
    let g:pymode_lint_cwindow = 0


    " ultisnips {
        Plugin 'honza/vim-snippets'
        Plugin 'SirVer/ultisnips'
        "let g:UltiSnipsSnippetDirectories=["UltiSnips"]  this is default value
        "let g:UltiSnipsExpandTrigger="<C-Bslash>"
        let g:UltiSnipsExpandTrigger="<D-/>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        let g:UltiSnipsEditSplit="vertical"
    "}

    " emmet:
    Plugin 'mattn/emmet-vim'
    let g:user_emmet_mode='n'    "only enable normal mode functions.
    let g:user_emmet_mode='inv'  "enable all functions, which is equal to
    let g:user_emmet_mode='a'    "enable all function in all mode.
    let g:user_emmet_install_global = 0
    autocmd FileType html,css,xml EmmetInstall
    let g:user_emmet_leader_key='<C-E>'

    Plugin 'vim-multiple-cursors'
    Plugin 'asins/vimcdoc'
    Plugin 'matchit.zip'
    Bundle 'scrooloose/syntastic'
" }

Bundle 'aklt/plantuml-syntax'

" auto complete {
    Bundle 'Shougo/neocomplete.vim'
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1

"}

" Gundo visualize your Vim undo tree  {
  Plugin 'Gundo'
  nnoremap <F3> :GundoToggle<CR>
" }

"Snake lets you use Python to its fullest extent to write Vim plugins{
    Bundle 'amoffat/snake'
"}


" Bundle end {
    call vundle#end()
    filetype plugin indent on    
" }


"SYNTAX HIGHLIGHT CONFIG{ 
    au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery 
"}

"JAVASCRIPT { 
    let javascript_enable_domhtmlcss=1 
"} 


" workdir setting { http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
    "cd ~/
    set autochdir
    "autocmd BufEnter * silent! lcd %:p:h
" }

"fix bugs E303 {
    set directory=.,$TEMP
"}


"""""""""""""""""""""""""""""""""""
"  must setting here, may be bug  "
"""""""""""""""""""""""""""""""""""

syntax enable                
if OSX()
    let g:solarized_termtrans = 1
    let g:solarized_termcolors=256
    set background=dark
    colorscheme solarized
end


"user-command
command -nargs=0 JsonFormat :%! python -m json.tool<CR><Esc>:set filetype=json<CR>


vim:set et sw=4 ts=4 tw=78:
