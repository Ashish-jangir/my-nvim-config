-- ~/.config/nvim/lua/plugins/cpp/cpp_opengl.lua
return {
  -- Optional: adapter manager for codelldb in mason
  { "williamboman/mason.nvim", opts = { ensure_installed = { "clangd", "clang-format" } } },

  -- none-ls (maintained fork of null-ls)
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim", -- optional, for extra sources
      "williamboman/mason.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- FORMATTERS
          null_ls.builtins.formatting.clang_format,

          -- LINTERS (optional)
          -- null_ls.builtins.diagnostics.cppcheck,
          -- null_ls.builtins.diagnostics.clang_check,

          -- Other useful formatters:
          -- null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.formatting.stylua,
        },
      })
    end,
  },

  -- CMake tools
  { "Civitasv/cmake-tools.nvim", config = true },

  -- GLSL syntax highlighting
  { "tikhomirov/vim-glsl", ft = { "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" } },

  -- GLSL language server (optional) - register in lspconfig if you want LSP features
  -- Server repo: svenstaro/glsl-language-server or KubaP/glsl-lsp (choose one)
  -- We'll ensure it's available via mason or manual install; see docs below.
  { "svenstaro/glsl-language-server", enabled = false }, -- placeholder; install manually or via mason

  -- C++/clangd handled by lspconfig; ensure mason installs clangd
  -- Debugging: nvim-dap + codelldb
  { "mfussenegger/nvim-dap", config = true },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
}
