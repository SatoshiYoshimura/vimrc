"#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け

"#タブをスペースに　2文字
set tabstop=2
set expandtab
set shiftwidth=2
set noautoindent
set backspace=indent,eol,start


""#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch
set nocompatible
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
filetype off

"閉じタグ補完"
augroup MyXML
autocmd!
autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

vnoremap <silent> > >gv
vnoremap <silent> < <gv

" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-rails'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'okcompute/vim-ctags' 
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/html5.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mattn/zencoding-vim'

filetype plugin on

" Color Scheme Configure:
 syntax enable
 set background=dark
 let g:solarized_termcolors=256
 colorscheme solarized


"------------------------------------
"" endwise.vim
"------------------------------------
""{{{
let g:endwise_no_mappings=1
"}}}

" Anywhere SID.
 function! s:SID_PREFIX()
   return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
 endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'.s:SID_PREFIX() .'my_tabline()'
set showtabline=2 "

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap<silent> [Tag]'.n':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast  <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

 "" neocomplcache
 NeoBundle 'Shougo/neocomplcache'
 " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
 " " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
 " " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
 " " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

 "zencoding-vim
 let g:user_zen_leader_key = ''
"}
  " taglistの設定 coffeeを追加
   " let g:tlist_coffee_settings = 'coffee;f:function;v:variable'
  
   " QuickRunのcoffee
   " let g:quickrun_config['coffee'] = {
   "      \'command' : 'coffee',
   "      \'exec' : ['%c -cbp %s']
  "      \}
  
   "------------------------------------
   " vim-coffee-script
   "------------------------------------
   " 保存時にコンパイル
"  autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
  
   "------------------------------------
   " jasmine.vim
   "------------------------------------
   " ファイルタイプを変更
""   function! JasmineSetting()
"     au BufRead,BufNewFile *Helper.js,*Spec.js  set
"     filetype=jasmine.javascript
"     au BufRead,BufNewFile *Helper.coffee,*Spec.coffee  set
"     filetype=jasmine.coffee
""     au BufRead,BufNewFile,BufReadPre *Helper.coffee,*Spec.coffee  let
"     b:quickrun_config = {'type' : 'coffee'}
"     call jasmine#load_snippets()
"     map <buffer> <leader>m :JasmineRedGreen<CR>
"     command! JasmineRedGreen :call jasmine#redgreen()
"     command! JasmineMake :call jasmine#make()
"   endfunction
"     au BufRead,BufNewFile,BufReadPre *.coffee,*.js call JasmineSetting()

 " " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : ''
          \ }
 
          " Plugin key-mappings.
          inoremap <expr><C-g>     neocomplcache#undo_completion()
          inoremap <expr><C-l>     neocomplcache#complete_common_string()

          " Recommended key-mappings.
          " <CR>: close popup and save indent.
            " <TAB>: completion.
            inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
            " <C-h>, <BS>: close popup and delete backword char.
            inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y>  neocomplcache#close_popup()
            inoremap <expr><C-e>  neocomplcache#cancel_popup()d

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
