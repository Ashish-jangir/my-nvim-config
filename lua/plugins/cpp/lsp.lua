-- ~/.config/nvim/lua/plugins/user/lsp.lua
local plugins = {}

-- Add clangd to ensure it's installed by mason + configure a couple handy settings
plugins["neovim/nvim-lspconfig"] = {
  opts = {
    servers = {
      clangd = {
        -- optional clangd-specific settings
        cmd = { "clangd", "--background-index" },
        root_dir = require("lspconfig.util").root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          "CMakeLists.txt",
          ".git"
        ),
      },
      -- optional: neocmake if you use a cmake LSP for CMakeLists themselves
      neocmake = {},
      -- glslls for GLSL if you install it:
      -- glslls = {}
    },
  },
}

return plugins
