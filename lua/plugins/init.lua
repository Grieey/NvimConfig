local plugins = {

  ["nvim-lua/plenary.nvim"] = { module = "plenary" },

  -- flutter 的工具,主要提供编译相关的命令,不用再启动命令行
  ["akinsho/flutter-tools.nvim"] = {
    wants = "nvim-lua/plenary.nvim",
    config = function()
      local present, flutter = pcall(require, "flutter-tools")
      if present then
        flutter.setup()
      end
    end,
  },

  -- 代码提示
  ["kosayoda/nvim-lightbulb"] = {
    wants = "antoinemadec/FixCursorHold.nvim",
    disable = true,
    config = function()
      local ok, light = pcall(require, "nvim-lightbulb")
      if ok then
        light.setup { autocmd = { enabled = true } }
      end
    end,
  },

  ["lewis6991/impatient.nvim"] = {},

  -- 代码优化
  ["glepnir/lspsaga.nvim"] = {
    branch = "main",
    disable = true,
    config = function()
      -- require "plugins.configs.lspsaga"
      local ok, saga = pcall(require, "lspsaga")
      if ok then
        saga.init_lsp_saga {
          use_saga_diagnostic_sign = false,
          border_style = "round",
        }
      end
    end,
  },

  ["folke/trouble.nvim"] = {
    wants = "kyazdani42/nvim-web-devicons",
    disable = true,
    config = function()
      local ok, trouble = pcall(require, "trouble")
      if ok then
        trouble.setup()
      end
    end,
  },

  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },

  -- 代码格式化
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "plugins.configs.null-ls"
    end,
  },

  ["NvChad/extensions"] = { module = { "telescope", "nvchad" } },

  ["NvChad/base46"] = {
    config = function()
      local ok, base46 = pcall(require, "base46")

      if ok then
        base46.load_theme()
      end
    end,
  },

  ["NvChad/ui"] = {
    after = "base46",
    config = function()
      local present, nvchad_ui = pcall(require, "nvchad_ui")

      if present then
        nvchad_ui.setup()
      end
    end,
  },

  ["NvChad/nvterm"] = {
    module = "nvterm",
    config = function()
      require "plugins.configs.nvterm"
    end,
    setup = function()
      require("core.utils").load_mappings "nvterm"
    end,
  },

  ["kyazdani42/nvim-web-devicons"] = {
    after = "ui",
    module = "nvim-web-devicons",
    config = function()
      require("plugins.configs.others").devicons()
    end,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
      require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  ["NvChad/nvim-colorizer.lua"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-colorizer.lua"
    end,
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    cmd = require("core.lazy_load").treesitter_cmds,
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  -- git stuff
  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  },

  -- lsp stuff
  ["williamboman/mason.nvim"] = {
    cmd = require("core.lazy_load").mason_cmds,
    config = function()
      require "plugins.configs.mason"
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  -- 代码补齐引擎
  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  -- 代码片段引擎
  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

  -- 补全源
  ["saadparwaiz1/cmp_luasnip"] = { after = "LuaSnip" },
  ["hrsh7th/cmp-nvim-lua"] = { after = "cmp_luasnip" },
  ["hrsh7th/cmp-nvim-lsp"] = { after = "cmp-nvim-lua" },
  ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
  ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

  -- misc plugins
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },

  ["goolord/alpha-nvim"] = {
    after = "base46",
    disable = false,
    config = function()
      require "plugins.configs.alpha"
    end,
  },

  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
    setup = function()
      require("core.utils").load_mappings "comment"
    end,
  },

  -- file managing , picker etc
  ["kyazdani42/nvim-tree.lua"] = {
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
    setup = function()
      require("core.utils").load_mappings "nvimtree"
    end,
  },
  -- smooth scroll
  ["karb94/neoscroll.nvim"] = {
    disable = false,
    config = function()
      local present, scroll = pcall(require, "neoscroll")

      if present then
        scroll.setup {
          -- All these keys will be mapped to their corresponding default scrolling animation
          mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
          hide_cursor = true, -- Hide cursor while scrolling
          stop_eof = true, -- Stop at <EOF> when scrolling downwards
          respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
          cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
          easing_function = nil, -- Default easing function
          pre_hook = nil, -- Function to run before the scrolling animation starts
          post_hook = nil, -- Function to run after the scrolling animation ends
          performance_mode = false, -- Disable "Performance Mode" on all buffers.
        }
      end
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  ["stevearc/dressing.nvim"] = {
    config = function()
      local ok, dressing = pcall(require, "dressing")
      if ok then
        dressing.setup {
          select = {
            backend = 'nui',
            nui = {
              position = "50%",
              size = nil,
              relative = "editor",
              border = {
                style = "rounded",
              },
              buf_options = {
                swapfile = false,
                filetype = "DressingSelect",
              },
              win_options = {
                winblend = 10,
              },
              max_width = 80,
              max_height = 40,
              min_width = 40,
              min_height = 10,
            },
            -- builtin = {
            --   -- These are passed to nvim_open_win
            --   anchor = "NW",
            --   border = "rounded",
            --   -- 'editor' and 'win' will default to being centered
            --   relative = "editor",
            --
            --   -- Window transparency (0-100)
            --   winblend = 10,
            --   -- Change default highlight groups (see :help winhl)
            --   winhighlight = "",
            --
            --   -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            --   -- the min_ and max_ options can be a list of mixed types.
            --   -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            --   width = nil,
            --   max_width = { 140, 0.8 },
            --   min_width = { 40, 0.2 },
            --   height = nil,
            --   max_height = 0.9,
            --   min_height = { 10, 0.2 },
            --
            --   -- Set to `false` to disable
            --   mappings = {
            --     ["<Esc>"] = "Close",
            --     ["<C-c>"] = "Close",
            --     ["<CR>"] = "Confirm",
            --   },
            --
            --   override = function(conf)
            --     -- This is the config that will be passed to nvim_open_win.
            --     -- Change values here to customize the layout
            --     return conf
            --   end,
            -- },
          },
        }
      end
    end,
  },

  -- Only load whichkey after all the gui
  ["folke/which-key.nvim"] = {
    disable = false,
    module = "which-key",
    keys = "<leader>",
    config = function()
      require "plugins.configs.whichkey"
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },
}

-- Load all plugins
local present, packer = pcall(require, "packer")

if present then
  vim.cmd "packadd packer.nvim"

  -- Override with default plugins with user ones
  plugins = require("core.utils").merge_plugins(plugins)

  -- load packer init options
  local init_options = require("plugins.configs.others").packer_init()
  init_options = require("core.utils").load_override(init_options, "wbthomason/packer.nvim")
  packer.init(init_options)

  for _, v in pairs(plugins) do
    packer.use(v)
  end
end
