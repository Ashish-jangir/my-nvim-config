-- ~/.config/nvim/lua/plugins/cpp/init.lua
return {
  -- Mason for C++ tools
  { "mason-org/mason.nvim", opts = { ensure_installed = { "clangd", "clang-format", "codelldb" } } },

  -- CMake tools
  { "Civitasv/cmake-tools.nvim", config = true },

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
}
