-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.builtin.lualine.style = "lvim"
local map = vim.keymap.set

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_z = { components.python_env }
lvim.builtin.lualine.sections.lualine_c = { components.filename }
map("t", "<Esc>", "<C-\\><C-N>", { desc = "Enter Terminal Normal Mode" })

lvim.colorscheme = "material-darker"

lvim.plugins = {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   enabled = false,
  -- },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({
        contrast = {
          terminal = false,            -- Enable contrast for the built-in terminal
          sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false,    -- Enable contrast for floating windows
          cursor_line = false,         -- Enable darker background for the cursor line
          lsp_virtual_text = false,    -- Enable contrasted background for lsp virtual text
          non_current_windows = false, -- Enable contrasted background for non-current windows
          filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
        },

        styles = { -- Give comments style such as bold, italic, underline etc.
          comments = { --[[ italic = true ]] },
          strings = { --[[ bold = true ]] },
          keywords = { --[[ underline = true ]] },
          functions = { --[[ bold = true, undercurl = true ]] },
          variables = {},
          operators = {},
          types = {},
        },
        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false,        -- Disable borders between vertically split windows
          background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false,    -- Prevent the theme from setting terminal colors
          eob_lines = false       -- Hide the end-of-buffer lines
        },
        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = true    -- Enable higher contrast text for darker style
        },
      })
    end
  },
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = 'BufEnter',
    config = function()
      require('codeium').setup({
        -- configurable options
        virtual_text = {
          enabled = true
        },
        opts = {
          key_bindings = {
            -- set accept like alt + tab
            accept = "<C-i>",

            accept_word = "<M-l>",
            accept_line = "<S-l>",

          }
        }
      })
    end

  },
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
    -- Table of strings to specify default headers to be included in each request, i.e. "-i"
    default_flags = {},
    -- Specify an alternative curl binary that will be used to run curl commands
    -- String of either full path, or binary in path
    curl_binary = nil,
    open_with = "tab", -- use "split" to open in horizontal split
    mappings = {
      execute_curl = "<CR>"
    }
  },

}

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup { { name = "ruff" }, }
-- lvim.format_on_save.enabled = true
-- lvim.format_on_save.pattern = { "*.py" }


lvim.builtin.which_key.mappings["M"] = {
  name = "Curl",
  c = { "<cmd>lua require('curl').open_curl_tab()<cr>", "Send selected request" },
  C = { "<cmd>lua require('curl').create_scoped_collection()<cr>", "Create collection" },
  p = { "<cmd>lua require('curl').pick_scoped_collection()<cr>", "Create collection" },
}

lvim.builtin.which_key.mappings["vs"] = { "<cmd>VenvSelect<cr>",
  "Select venv" }

lvim.builtin.which_key.mappings["vc"] = { "<cmd>VenvSelectCached<cr>",
  "Select cache venv"
}

-- material ui selector
lvim.builtin.which_key.mappings["m"] = {
  name = "Material UI",
  p = { "<cmd>lua require('material.functions').change_style('palenight')<cr>", "Togle palenight style" },
  o = { "<cmd>lua require('material.functions').change_style('deep-ocean')<cr>", "Togle deep-ocean style" },
  d = { "<cmd>lua require('material.functions').change_style('darker')<cr>", "Togle darker style" },
  l = { "<cmd>lua require('material.functions').change_style('lighter')<cr>", "Togle lighter style" },
  c = { "<cmd>lua require('material.functions').change_style('oceanic')<cr>", "Togle oceanic style" },
  f = { "<cmd>lua require('material.functions').find_style()<cr>", "Find style" },
  i = { "<cmd>call codeium#Chat()<cr>", "Find style" },
}

lvim.builtin.which_key.mappings["vb"] = { "<cmd>:reg<cr>",
  "Show reg"
}

lvim.builtin.which_key.mappings["Z"] = {
  name = "Buffer",
  c = { "<cmd>:reg<cr>", "Show reg" },
}
