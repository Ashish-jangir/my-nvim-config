local plugins = {
  -- GitHub Copilot integration
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>", --Ctrl+l to accept suggestion
            next = "<M-]>", -- Alt+] to go to next suggestion
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
          lua = true,
          cpp = true,
        },
      })
    end,
  },

  -- Optional: Copilot completion source for nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- Copilot Chat plugin
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- ensure Copilot core is installed
      { "nvim-lua/plenary.nvim" }, -- required dependency
    },
    config = function()
      local chat = require("CopilotChat")
      chat.setup({
        debug = false,
        show_help = true,
        window = {
          layout = "float",
          width = 0.6,
          height = 0.6,
          relative = "editor",
        },
      })
      -- Keybinding: <localleader>cc to toggle Copilot Chat
      vim.keymap.set("n", "<localleader>cc", function() --\ is local leader
        chat.toggle()
      end, { desc = "Toggle Copilot Chat" })
    end,
  },
}

return plugins
