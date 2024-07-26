local config = require ("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities
capabilities.offsetEncoding = {"utf-16"}

local lspconfig = require("lspconfig")

local function organize_imports()
  local params = {
  command ="_typescript.organizeImports",
  arguments={vim.api.nvim_buf_get_name(0)},
}
  vim.lsp.buf.execute_command(params)
end

local function get_typescript_server_path(root_dir)

  local global_ts = '/Users/rjtannous/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  lspconfig.util.path.join(path, 'node_modules', 'typescript', 'lib')
    if lspconfig.util.path.exists(found_ts) then
      return path
    end
  end
  if lspconfig.util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end


--[[
lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
    organizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}
--]]

lspconfig.volar.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'typescript','javascript', 'vue','json'},
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  init_options = {
    vue = {
      hybridMode = false,
    },
    languageFeatures = {
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = false,
      rename = true,
      signatureHelp = true,
      codeAction = true,
      completion = {
        defaultTagNameCase = "both",
        defaultAttrNameCase = "kebabCase",
      },
      schemaRequestService = true,
      documentHighlight = true,
      codeLens = true,
      semanticTokens = true,
      diagnostics = true,
    },
    documentFeatures = {
      selectionRange = true,
      foldingRange = true,
      linkedEditingRange = true,
      documentSymbol = true,
      documentColor = true,
    },
  },
  settings = {
    volar = {
      codeLens = {
        references = true,
        pugTools = true,
        scriptSetupTools = true,
      },
    },
  },
  root_dir = lspconfig.util.root_pattern("package.json", "vue.config.js", "vue.config.ts", "nuxt.config.js", "nuxt.config.js")
    }

lspconfig.tailwindcss.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "postcss.config.ts", "package.json", "node_modules", ".git"),
  settings = {
    tailwindCSS = {
      classAttributes = {"class", "className", "classList", "ngClass"},
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    }
  }
}

lspconfig.clangd.setup {
  on_attach = function(client,bufnr)
    client.server_capabilities.signatureHelperProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes={"python"},
}
