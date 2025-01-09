vim.o.timeoutlen = 256
vim.o.shell = "/bin/sh"
vim.o.relativenumber = true
vim.diagnostic.config({ virtual_text = false })
-- vim.o.foldmethod = "expr"
-- vim.o.foldlevel = 8
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- typst.vim
-- vim.g.typst_conceal = 1
vim.g.typst_auto_close_toc = 1
vim.g.typst_embeded_languages = { "rust" }

lvim.colorscheme = "nord"
lvim.builtin.lualine.options.theme = 'nord'
-- lvim.transparent_window = true
-- lvim.format_on_save.enabled = false
lvim.builtin.lualine.sections.lualine_a = { 'mode' }
lvim.builtin.lualine.sections.lualine_c = { 'filename', 'hostname' }
local function getWords()
  return vim.fn.wordcount().words
end
lvim.builtin.lualine.sections.lualine_y = {
  'location',
  { getWords },
}
lvim.builtin.terminal.shell = "/bin/fish"
lvim.builtin.which_key.mappings["z"] = { "<cmd>Telescope zoxide list<CR>", "Zoxide" }
lvim.builtin.which_key.setup.plugins.presets.z = true
lvim.builtin.which_key.setup.plugins.presets.windows = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
table.insert(lvim.builtin.cmp.sources, { name = "papis" })
-- table.insert(lvim.builtin.cmp.sources, { name = "neorg" })
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

vim.g.path_to_creds = '~/.config/lvim/credentials.json'
vim.g.gdoc_file_path = '~/.config/lvim/'
vim.g.token_directory = '~/.config/lvim/'

lvim.plugins = {
  'gbprod/nord.nvim',
  'tpope/vim-fugitive',
  'nanotee/zoxide.vim',
  'jvgrootveld/telescope-zoxide',
  'allen-mack/nvim-table-md',
  'nu-scptheme/vim-wikidot',
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require('todo-comments').setup() end
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    'ellisonleao/glow.nvim',
    config = function()
      require('glow').setup {
        style = "dark",
        width = 80,
        border = ""
      }
    end,
    ft = { "markdown" }
  },
  'folke/trouble.nvim',
  {
    'AckslD/nvim-FeMaco.lua',
    config = function()
      require('femaco').setup {}
    end
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      -- local lsp_installer_servers = require("nvim-lsp-installer.servers")
      -- local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          -- options same as lsp hover / vim.lsp.util.open_floating_preview()
          hover_actions = {
            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = true,
          },
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require("rust-tools")
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
    ft = { "rust", "rs" },
  },
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = false,
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '0.1.*',
    build = function() require 'typst-preview'.update() end,
    config = function()
      require 'typst-preview'.setup {
        open_cmd = 'firefox %s -P typst-preview --class typst-preview',
      }
    end
  },
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup {}
    end
  },
  -- {
  --   "nvim-neorg/neorg",
  --   build = ":Neorg sync-parsers",
  --   -- tag = "*",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("neorg").setup {
  --       load = {
  --         ["core.defaults"] = {},  -- Loads default behaviour
  --         ["core.concealer"] = {}, -- Adds pretty icons to your documents
  --         ["core.dirman"] = {      -- Manages Neorg workspaces
  --           config = {
  --             workspaces = {
  --               notes = "~/Nextcloud/Documents/Notes",
  --               gtd = "~/Nextcloud/Documents/GTD",
  --             },
  --           },
  --         },
  --         ["core.completion"] = {
  --           config = {
  --             engine = "nvim-cmp",
  --             name = "[Neorg]"
  --           }
  --         },
  --       },
  --     }
  --   end,
  -- },
  --{
  --  "jghauser/papis.nvim",
  --  dependencies = {
  --    "kkharji/sqlite.lua",
  --    "nvim-lua/plenary.nvim",
  --    "MunifTanjim/nui.nvim",
  --    "nvim-treesitter/nvim-treesitter",
  --  },
  --  config = function()
  --    require("papis").setup({
  --      -- These are configuration options of the `papis` program relevant to papis.nvim.
  --      -- Papis.nvim can get them automatically from papis, but this is very slow. It is
  --      -- recommended to copy the relevant settings from your papis configuration file.
  --      papis_python = {
  --        dir = "~/Documents/papers",
  --        info_name = "info.yaml", -- (when setting papis options `-` is replaced with `_`
  --        -- in the keys names)
  --        notes_name = [[notes.norg]],
  --      },
  --      init_filenames = { "*.typ" },
  --    })
  --  end,
  --},
  {
    "imsnif/kdl.vim",
    ft = "kdl",
  },
  {
    'mhartington/formatter.nvim',
    config = function()
      -- Utilities for creating configurations
      local util = require "formatter.util"

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
              -- Supports conditional formatting
              if util.get_current_buffer_file_name() == "special.lua" then
                return nil
              end

              -- Full specification of configurations is down below and in Vim help
              -- files
              return {
                exe = "stylua",
                args = {
                  "--search-parent-directories",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                  "--",
                  "-",
                },
                stdin = true,
              }
            end
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        }
      }
    end
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java'
  },
  {
    'aadv1k/gdoc.vim',
    build = './install.py'
  },
  {
    'RaafatTurki/hex.nvim',
    config = function()
      require 'hex'.setup()
    end
  },
  -- {'https://github.com/Freed-Wu/rime.nvim'}
}
