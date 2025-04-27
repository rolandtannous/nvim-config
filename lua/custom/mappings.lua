local M = {}

M.general = {
  n = {
        ["s"] = { "<C-w>w", "switch buffers"},

  }
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["t"] = {"<cmd> NvimTreeToggle <CR>", "Toggle nvimtree"},
    -- ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
  },
}

-- M.lspsaga = {
--   plugin = true,
--
--   n = {
--     ["fa"] = {"<cmd>Lspsaga code_action<cr>", "Code Action", opts= {silent=true}},
--     ["ff"] = {"<cmd>Lspsaga finder<cr>", "Finder", opts = {silent = true}},
--     ["fr"] = {"<cmd>Lspsaga rename<cr>", "Rename", opts = {silent = true}},
--     ["fo"] = {"<cmd>Lspsaga outline<cr>", "Outline", opts = {silent = true}},
--     ["fp"] = {"<cmd>Lspsaga peek_definition<cr>", "Peek definition", opts = {silent=true}},
--     ["ft"] = {"<cmd>Lspsaga peek_type_definition<cr>", "Peek type definition", opts = {silent=true}},
--     ["fg"] = {"<cmd>Lspsaga goto_type_definition<cr>", "Goto type definition", opts = {silent=true}},
--
--
-- },
--
-- }
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}


M.dap_go = {
  plugin=true,
  n={
    ["<leader>dgt"]={
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"]={
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}
return M
