-- ~/.config/nvim/lua/plugins/cpp/init.lua
return {
  -- Mason for C++ tools
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "clangd", "clang-format", "codelldb", "cmakelang", "cmakelint" } },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cpp" })
      opts.ensure_installed = require("core.utils").tbl_unique(opts.ensure_installed)
      return opts
    end,
  },
  -- CMake tools
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load({ plugins = { "cmake-tools.nvim" } })
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = {},
  },
  -- GLSL syntax highlighting
  -- { "tikhomirov/vim-glsl", ft = { "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" } },

  -- GLSL language server placeholder
  -- { "svenstaro/glsl-language-server", enabled = false },

  -- Debugging: nvim-dap + codelldb
  { "mfussenegger/nvim-dap" }, -- no config needed here

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}, -- you can add custom dap handlers here
    },
  },
  --Debugging UI for nvim-dap
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- Language Server for c++ ico system
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       clangd = {
  --         -- optional clangd-specific settings
  --         cmd = {
  --           "clangd",
  --           "--background-index",
  --           "--clang-tidy",
  --           "--completion-style=detailed",
  --         },
  --         root_dir = require("lspconfig.util").root_pattern(
  --           "compile_commands.json",
  --           "compile_flags.txt",
  --           "CMakeLists.txt",
  --           ".git"
  --         ),
  --       },
  --       -- optional: neocmake if you use a cmake LSP for CMakeLists themselves
  --       neocmake = {},
  --       -- glslls for GLSL if you install it:
  --       -- glslls = {}
  --     },
  --   },
  -- },
}
