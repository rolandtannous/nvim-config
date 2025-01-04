local config = require ("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities
-- capabilities.offsetEncoding = {"utf-16"}

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local servers = {
	"pylsp",
	"ruff",
}

for _,lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach=on_attach,
		capabilities=capabilities,
		filetypes={"python"},
	})
end

-- Create a custom on_attach function that combines the original on_attach
-- with the new imports functionality
local gopls_on_attach = function(client, bufnr)
    -- Call the original on_attach
    on_attach(client, bufnr)

    -- Add the imports organization autocmd
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}

            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
            vim.lsp.buf.format({async = false})
        end
    })
end



lspconfig.gopls.setup {
  -- on_attach = on_attach,
  on_attach = gopls_on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork","gotmpl"},
  root_dir = util.root_pattern("go.work","go.mod"),
  settings = {
    completeUnimported = true,
    usePlaceholders = true,
    analyses = {
      unusedparams = true,
    },
  }
}


lspconfig.pylsp.setup {
  on_attach=on_attach,
  capabilities=capabilities,
  settings={
    pylsp = {
      plugins={
        pycodestyle={
          ignore={'E501','E231'},
          maxLineLength=120,
        }
      }
    }
  }
}

-- Update ruff settings
lspconfig.ruff.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        settings = {
            -- Enable ERA rules
            select = {"ERA"},
        }
    }
}


-- source: https://www.reddit.com/r/neovim/comments/tttofk/how_to_disable_annoying_pylint_warningespecially/
-- lspconfig.pylsp.setup {
-- on_attach=on_attach,
-- filetypes = {'python'},
-- capabilities=capabilities,
-- settings = {
-- configurationSources = {"flake8"},
-- formatCommand = {"black"},
-- pylsp = {
-- plugins = {
-- -- jedi_completion = {fuzzy = true},
-- -- jedi_completion = {eager=true},
-- jedi_completion = {
-- include_params = true,
-- },
-- jedi_signature_help = {enabled = true},
-- jedi = {
-- extra_paths = {'~/projects/work_odoo/odoo14', '~/projects/work_odoo/odoo14'},
-- -- environment = {"odoo"},
-- },
-- pyflakes={enabled=true},
-- -- pylint = {args = {'--ignore=E501,E231', '-'}, enabled=true, debounce=200},
-- pylsp_mypy={enabled=false},
-- pycodestyle={
-- enabled=true,
-- ignore={'E501', 'E231'},
-- maxLineLength=120},
-- yapf={enabled=true}
-- }
-- }
-- }
-- }
