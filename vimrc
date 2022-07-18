set nocompatible
syntax on
filetype plugin indent on

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set encoding=utf-8
" cp936 is gbk, euc-cn is gb2312
set fileencodings=utf-8,cp936,gbk,euc-cn,gb2312,utf-16le,utf-16,ucs-bom,gb18030,iso-8859-2,iso-885915
set noerrorbells
set mouse=a
set autochdir

set termguicolors
set background=dark
set cursorline

" ======== indent settings ========
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
autocmd Filetype markdown,html,xml,yaml,toml,svg
            \ setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype go setlocal noexpandtab
set cindent
set autoindent
set smartindent
set shiftround

set ignorecase
set smartcase
set hlsearch
set incsearch
noremap <space><cr> :nohlsearch<cr>
noremap <leader><leader> <esc>/<++><cr>:nohlsearch<cr>c4l

set number
set relativenumber
set signcolumn=yes

set laststatus=2
set scrolloff=5
set ruler
set wrap

set wildmenu
set wildmode=list:longest,full
set backspace=indent,eol,start

vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pi
nnoremap <m-v> <c-v>

noremap <up> :resize +1<cr>
noremap <down> :resize -1<cr>
noremap <left> :vertical resize -1<cr>
noremap <right> :vertical resize +1<cr>


call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'junegunn/vim-easy-align'
Plug 'skywind3000/quickmenu.vim'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'ryanoasis/vim-devicons'

Plug 'preservim/nerdcommenter'

Plug 'voldikss/vim-floaterm'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'voldikss/LeaderF-floaterm'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'

Plug 'tpope/vim-surround'
call plug#end()



"----------------------------------------------------------------------
" +++ theme
"----------------------------------------------------------------------

colorscheme dracula



"----------------------------------------------------------------------
" +++ vim-easy-align
"----------------------------------------------------------------------

xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)



"----------------------------------------------------------------------
" +++ quickmenu.vim
"----------------------------------------------------------------------

" clear all the items
call quickmenu#reset()
" enable cursorline (L) and cmdline help (H)
let g:quickmenu_options = "HL"
" use your favorite key to show / hide quickmenu
noremap <silent><F12> :call quickmenu#toggle(0)<cr>



"----------------------------------------------------------------------
" +++ nerdtree
"----------------------------------------------------------------------

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif



"----------------------------------------------------------------------
" +++ emmet-vim
"----------------------------------------------------------------------
let g:user_emmet_leader_key='<c-x>'



"----------------------------------------------------------------------
" +++ coc.nvim
"----------------------------------------------------------------------

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

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-floaterm', 'coc-highlight', 'coc-pairs',
            \ 'coc-json', 'coc-tsserver', 'coc-prettier', 
            \ 'coc-html', 'coc-css', 'coc-htmlhint', 'coc-cssmodules', 
            \ 'coc-html-css-support',
            \ 'coc-svg', 'coc-xml', 'coc-go', 'coc-jedi']


"----------------------------------------------------------------------
" +++  coc-prettier
"----------------------------------------------------------------------
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

