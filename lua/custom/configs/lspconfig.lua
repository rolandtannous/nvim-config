local config = require ("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities
capabilities.offsetEncoding = {"utf-16"}

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local servers = {
	"pyright",
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

            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
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
    }
  }
}
