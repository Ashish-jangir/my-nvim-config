-- Prefer clang-format for C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.b.autoformat = true
  end,
})
