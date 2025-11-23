local plugins = {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-t>]],
        direction = "horizontal",
        insert_mappings = true, -- Whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- Whether or not the open mapping applies in the opened terminals
      })
    end,
  },
}
return plugins
