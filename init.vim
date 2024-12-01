:set number
:set relativenumber
:set tabstop=4
:set expandtab
:set sw=4
:set autoindent
:set autoread
:autocmd FocusGained,BufEnter * checktime

call plug#begin()
"Plug 'puremourning/vimspector' "Didn't work for php debugging for me.
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
call plug#end()

let mapleader=","
"let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"Short cuts for coc autocompletion
nmap <silent> gd <Plug>(coc-definition)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Lazygit with toggleterm
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
