-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local is_linux = vim.loop.os_uname().sysname == "Linux"

if is_linux then
  local g = vim.g

  g.clipboard = "xclip"
end
