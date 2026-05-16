-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local g = vim.g

g.clipboard = "xclip"
-- Line Numbers
vim.opt.number = true -- :set number
vim.opt.relativenumber = true -- :set relativenumber

-- Indentation (4 spaces)
vim.opt.tabstop = 4 -- :set tabstop=4
vim.opt.shiftwidth = 4 -- :set sw=4
vim.opt.expandtab = true -- :set expandtab
vim.opt.autoindent = true -- :set autoindent (default in Neovim)

-- File Handling
-- Note: 'autoread' is true by default in Neovim, but can be set explicitly:
vim.opt.autoread = true -- :set autoread
