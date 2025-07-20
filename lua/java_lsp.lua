local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/java-lsp/jdtls"
local java_exe = "C:/portable-bin-apps/zulu-jdk-17/bin/java.exe"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/java-workspaces/" .. project_name
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- Go to definition
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

  -- Show documentation (hover)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  
   -- 🔍 Find references (usages)
   vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
end
local root_dir = require('jdtls.setup').find_root({'.git', 'pom.xml', 'build.gradle'})

local config = {
    cmd = {
        java_exe,
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens=java.base/java.util=ALL-UNNAMED',
        '--add-opens=java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.fn.expand(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', 
        vim.fn.expand(jdtls_path .. '/config_win'),
        '-data', 
        vim.fn.expand(workspace_dir),
    },
    on_attach = on_attach,
    root_dir = root_dir
}

require('jdtls').start_or_attach(config)

-- In Lua config
local cmp = require('cmp')
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
    -- Add more sources as needed
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  })
}

