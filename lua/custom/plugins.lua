local plugins = {

  {
    "nvim-neotest/nvim-nio",
  },
  -- { "nvim-tree/nvim-web-devicons", opts = {} },
  -- {
  --   'nvimdev/lspsaga.nvim',
  --   config = function()
  --     require "custom.configs.lspsaga"
  --     require("core.utils").load_mappings("lspsaga")
  --   end,
  --   dependencies = {
  --       'nvim-treesitter/nvim-treesitter', -- optional
  --       'nvim-tree/nvim-web-devicons',     -- optional
  --   }
  -- },
    {
    "klen/nvim-config-local",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      print("Setting up nvim-config-local")
    require('config-local').setup {
      -- Default options (optional)

      -- Config file patterns to load (lua supported)
      config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

      -- Where the plugin keeps files data
      hashfile = vim.fn.stdpath("data") .. "/config-local",

      autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
      commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalDeny)
      silent = false,             -- Disable plugin messages (Config loaded/denied)
      lookup_parents = true,     -- Lookup config files in parent directories
    }
  end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event="VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    }
  },
  {
    "nvimtools/none-ls.nvim",
    -- ft={"python","go"},
    ft={"go"},
    event="VeryLazy",
    opts=function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft="go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }
     local listener = require("dap").listeners
     listener.after.event_initialized["dapui_config"] = function()
       require("dapui").open()
     end
     listener.before.event_terminated["dapui_config"] = function()
       require("dapui").close()
     end
     listener.before.event_exited["dapui_config"] = function()
       require("dapui").close()
     end
     vim.keymap.set("n", "<localleader>T", function()
        require("dapui").toggle()
     end, { desc = "Toggle DAP UI" })
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- require "custom.configs.dap"
     require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft="go",
    dependencies="mfussenegger/nvim-dap",
    config=function(_,opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function ()
      require "custom.configs.lint"
    end

  },
  {
    "mfussenegger/nvim-dap-python",
    ft={"python"},
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path, {})
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "gopls",
      }
    }
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    config = function()
      require("avante").setup(require "custom.configs.avante")
    end,
    build = "make", -- or use the Windows command if needed
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    config = function()
      require("img-clip").setup(require "custom.configs.img-clip")
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
    },
  },
}
return plugins
