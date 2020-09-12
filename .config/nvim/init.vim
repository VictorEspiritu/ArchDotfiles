call plug#begin('~/.config/nvim/plugged')

" siderbar to file browser
Plug 'scrooloose/nerdtree'  " Mostrar sidebar
Plug 'vim-airline/vim-airline'   " Mostrar Barra de1 estado en la edicion
Plug 'vim-airline/vim-airline-themes'  " Temas para airline
Plug 'Yggdroot/indentLine'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'gko/vim-coloresque' " Muestra el color del codigo 
Plug 'prettier/vim-prettier', {'do': 'yarn install'} " Formato code pretty
Plug 'honza/vim-snippets' " Snippets to code 
Plug 'uiiaoo/java-syntax.vim' "Muestra mas colores en la sintaxis de java 
Plug 'tpope/vim-commentary' "Comentar y descomentar codigo
Plug 'mikelue/vim-maven-plugin' "Plugin for maven 
Plug 'neoclide/coc-pyls'

call plug#end()

let g:NERDTreeChDirMode = 2  " Cambia el directorio actual al nodo padre actual
let g:airline#extensions#tabline#enabled = 1  " Mostrar buffers abiertos (como pestañas)
let g:airline#extensions#tabline#fnamemod = ':t'  " Mostrar sólo el nombre del archivo

" Cargar fuente Powerline y símbolos (ver nota)
let g:airline_powerline_fonts = 1

" No mostrar en ciertos tipos de buffers y archivos
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" Archivos ignorados
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Ignorar archivos en .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

set noshowmode  " No mostrar el modo actual (ya lo muestra la barra de estado)

" Maps requeridos
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

" Quitar resaltado luego de buscar
let g:incsearch#auto_nohlsearch = 1

map <F2> :NERDTreeToggle<CR>

" ======================================= Start COC Configuration 
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json',
  \ 'coc-java', 
  \ 'coc-lists', 
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ========================================================== END COC CONFIG
noremap <C-S> :update<CR>

augroup codecompilerun

    nnoremap <F9> :call <SID>compile_code()<CR>
    nnoremap <F10> : call <SID>run_code()<CR>
    nnoremap <silent>mc :Mvn! clean<CR>
    nnoremap <silent>mp :Mvn! clean package<CR>
    nnoremap <silent>mi :Mvn! clean install<CR>
    nnoremap <silent>mt :Mvn! clean test<CR>
    
    function! s:compile_code()                 
       execute "update"                            
       if (&filetype == 'java')                    
           ":set makeprg=javac\ %                   
           "execute 'make'
           execute "Mvn! compile"    
        elseif (&filetype == 'go')
           execute "!go build %"
       endif
    endfunction

    function! s:run_code()
        if (&filetype == 'java')
           "execute '!java -cp %:p:h %:t:r'
            execute "!./mvnw spring-boot:run"
            "execute "Mvn! clean install"   
         elseif (&filetype == 'javascript')
            execute "!node\ %"
        elseif (&filetype == 'python')
            execute "!python %"
        elseif (&filetype == 'go')
            execute "!go run %"
        elseif (&filetype == 'sh')
            execute "!bash %"
        elseif (&filetype == 'html')
            execute "!vimb %"
        elseif (&filetype == 'txt')
            execute "!cat %"
        endif 
    endfunction
augroup end

augroup idecode
    " Go to next and before buffer 
    nnoremap <silent> gn :bn<CR>
    nnoremap <silent> ga :bp<CR>
    " Format code Ctrl-F 
    nnoremap <C-A> :Format<CR>
    " Fix imports Ctrl-I 
    nnoremap <C-I> :OR<CR>
    " Code Action Alt-Insert 
    nnoremap <A-CR> :CocList actions<CR>
    " Code Word Action Alt-Enter
    nmap <silent> ce <Plug>(coc-codeaction)
    " Show list errors     
    nnoremap <silent> co :copen<CR>
    nnoremap <silent> cx :cclose<CR>
    nnoremap <silent> cf :cfirst<CR>
    nnoremap <silent> cl :clast<CR>
    nnoremap <silent> cn :cnext<CR>
    nnoremap <silent> cm :cprevious<CR>
    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    " Mappings using CoCList: Show all diagnostics.
    nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    nnoremap <silent> <space>l  :<C-u>CocList<CR>
    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)
    
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

augroup end

augroup resizeedit

    nnoremap <C-h> :vertical resize -5<CR>
    nnoremap <C-l> :vertical resize +5<CR>
    nnoremap <C-j> :res +5<CR>
    nnoremap <C-k> :res -5<CR>

augroup end


" =========================================================== END IDE CONFIG 

set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
set encoding=UTF-8
set clipboard=unnamedplus

:set number
:set tabstop=3
:set shiftwidth=3
:set expandtab

set autoread
set spelllang=en,es "Corrige palabras usando diccionarios de ingles y espanol
au FocusGained * :checktime

set t_md=

:highlight LineNr ctermfg=DarkGrey
:set fillchars+=vert:\ 
":hi VertSplit ctermfg=8
:highlight VertSplit cterm=NONE
:hi! Comment ctermfg=DarkGrey         
:set foldcolumn=0

set guifont=DroidSansMono_Nerd_Font:h11
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_unite = 1
let g:webdevicons_enable_denite = 1
let g:webdevicons_enable_vimfiler = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_startify = 1
let g:webdevicons_enable_flagship_statusline = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
"let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
"let g:WebDevIconsTabAirLineAfterGlyphPadding = ' '
"let g:WebDevIconsTabAirLineBeforeGlyphPadding = ' '
"let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'x'
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderPatternMatching = 1
"let g:DevIconsDefaultFolderOpenSymbol = 'ƛ'

" NERDTrees File highlighting only the glyph/icon
"autocmd filetype nerdtree highlight haskell_icon ctermbg=none ctermfg=Red guifg=#ffa500
"autocmd filetype nerdtree highlight html_icon ctermbg=none ctermfg=Red guifg=#ffa500
"autocmd filetype nerdtree highlight go_icon ctermbg=none ctermfg=Red guifg=#ffa500
"autocmd filetype nerdtree syn match haskell_icon ## containedin=NERDTreeFlags
"autocmd filetype nerdtree syn match html_icon ## containedin=NERDTreeFlags,html
"autocmd filetype nerdtree syn match go_icon ## containedin=NERDTreeFlags


