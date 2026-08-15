local opencode_cmd = "opencode --port"
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}

---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    start = function()
      require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
    end,
  },
}

-- Can also leverage toggle functionality.
-- If you use <leader> here, remove 't' — otherwise Neovim will add input delay to your <leader> when typing in the terminal to watch for the mapping.
vim.keymap.set({ "n", "t" }, "<C-.>", function()
  require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
end, { desc = "Toggle OpenCode" })

-- Optionally show upon submitting prompt
vim.api.nvim_create_autocmd("User", {
  pattern = { "OpencodeEvent:tui.command.execute" },
  callback = function(args)
    ---@type opencode.server.Event
    local event = args.data.event
    if event.properties.command == "prompt.submit" then
      local win = require("snacks.terminal").get(opencode_cmd, { create = false })
      if win then
        win:show()
      end
    end
  end,
})
local plugins = {
  -- GitHub Copilot integration
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
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
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          input = {
            enabled = true, -- Enhances Ask
          },
          picker = {
            enabled = true, -- Enhances Select
            win = {
              input = {
                keys = {
                  ["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
            actions = {
              opencode_send = function(picker) ---@param picker snacks.Picker
                local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
                  return item.file
                      and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                    or item.text
                end, picker:selected({ fallback = true }))
                require("opencode").prompt(table.concat(items, ", ") .. " ")
              end,
            },
          },
        },
      },
      {
        "folke/which-key.nvim",
        opts = {
          spec = {
            { "<leader>a", group = "OpenCode" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>ao",
        function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
        mode = { "n", "v", "t" },
        desc = "Toggle OpenCode…",
      },
      {
        "<leader>aa",
        "<cmd>lua require('opencode').ask('@this: ', {submit = true})<cr>",
        mode = { "n", "v" },
        desc = "Ask OpenCode…",
      },
      { "<leader>as", "<cmd>lua require('opencode').select()<cr>", mode = { "n", "v" }, desc = "Select OpenCode…" },
      { "go", "<cmd>lua return require('opencode').operator('@this ')<cr>", desc = "Append range to OpenCode" },
      { "goo", "<cmd>lua return require('opencode').operator('@this ') .. '_' <cr>", desc = "Append line to OpenCode" },
      { "<S-C-u>", "<cmd>lua require('opencode').command('session.half.page.up')<cr>", desc = "Scroll OpenCode up" },
      {
        "<S-C-d>",
        "<cmd>lua require('opencode').command('session.half.page.down')<cr>",
        desc = "Scroll OpenCode down",
      },
    },
  },
}
return plugins

-- Optional: Copilot completion source for nvim-cmp
--   {
--     "zbirenbaum/copilot-cmp",
--     enabled = true,
--     lazy = true,
--     dependencies = { "zbirenbaum/copilot.lua" },
--     config = function()
--       require("copilot_cmp").setup()
--     end,
--   },
--   -- Copilot Chat plugin
--   {
--     "CopilotC-Nvim/CopilotChat.nvim",
--     enabled = true,
--     lazy = true,
--     branch = "main",
--     dependencies = {
--       { "zbirenbaum/copilot.lua" }, -- ensure Copilot core is installed
--       { "nvim-lua/plenary.nvim" }, -- required dependency
--     },
--     config = function()
--       local chat = require("CopilotChat")
--       chat.setup({
--         debug = false,
--         show_help = true,
--         window = {
--           layout = "float",
--           width = 0.6,
--           height = 0.6,
--           relative = "editor",
--         },
--       })
--       -- Keybinding: <localleader>cc to toggle Copilot Chat
--       vim.keymap.set("n", "<localleader>cc", function() --\ is local leader
--         chat.toggle()
--       end, { desc = "Toggle Copilot Chat" })
--     end,
--   },
-- }

-- return plugins
