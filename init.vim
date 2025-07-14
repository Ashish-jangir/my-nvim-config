:set number
:set relativenumber
:set tabstop=4
:set expandtab
:set sw=4
:set autoindent
:set autoread
:autocmd FocusGained,BufEnter * checktime
" For windows nvim only
if has('win32') || has('win64')
  let &shell = '"C:\\Program Files\\Git\\bin\\bash.exe"'
  let &shellcmdflag = '-c'
  let &shellquote = ''
  let &shellxquote = ''
endif

call plug#begin()
Plug 'preservim/nerdtree'  "Works both in vim and neovim
Plug 'tpope/vim-commentary'  "Works both in vim and neovim
Plug 'nvim-lua/plenary.nvim'  "Only in neovim, It is required for telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }  "Only in neovim, It is fuzzy finder with ripgrep command
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}  "Only in neovim
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

" Java Development LSP & tools
" LSP support
Plug 'neovim/nvim-lspconfig'
" Java LSP helper (optional but recommended)
Plug 'mfussenegger/nvim-jdtls'
" Completion (optional, but enhances experience)
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippet support (optional)
Plug 'L3MON4D3/LuaSnip'
autocmd FileType java lua require('java_lsp')

"telescope alternative for vim
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Dependencies=choco install fzf bat ripgrep universal-ctags ag strawberryperl
"Plug 'neoclide/coc.nvim', {'branch': 'release'}  "Works both in vim and neovim, It is pure bullshit
"Plug 'puremourning/vimspector' "Didn't work for php debugging for me.
call plug#end()

let mapleader=","

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

"ONly for neovim, Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-t>]],
  direction = 'horizontal',
  insert_mappings = true, -- Whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- Whether or not the open mapping applies in the opened terminals
}
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit", 
    hidden = true,
    direction = "float"
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
-- Mapping to exit terminal mode quickly
vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
EOF

"let g:vimspector_enable_mappings = 'HUMAN'
"when using fzf.vim
"nnoremap <leader>ff <cmd>Files<cr>
"nnoremap <leader>fg <cmd>RG<cr>

"Short cuts for coc autocompletion
" nmap <silent> gd <Plug>(coc-definition)
" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" Lazygit with toggleterm
