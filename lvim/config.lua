-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.builtin.lualine.style = "lvim"

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_z = { components.python_env }
lvim.builtin.lualine.sections.lualine_c = { components.filename }

lvim.colorscheme = "material-darker"


lvim.plugins = {
  { 'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({
         contrast = {
              terminal = false, -- Enable contrast for the built-in terminal
              sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
              floating_windows = false, -- Enable contrast for floating windows
              cursor_line = false, -- Enable darker background for the cursor line
              lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
              non_current_windows = false, -- Enable contrasted background for non-current windows
              filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
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
              borders = false, -- Disable borders between vertically split windows
              background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
              term_colors = false, -- Prevent the theme from setting terminal colors
              eob_lines = false -- Hide the end-of-buffer lines
    },
         high_visibility = {
              lighter = false, -- Enable higher contrast text for lighter style
              darker = true -- Enable higher contrast text for darker style
    },
      })
    end
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "lotus", -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })
    end
  },
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
  "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig", 
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
  lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
  config = function()
      require("venv-selector").setup()
    end,
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
},

}

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

lvim.builtin.which_key.mappings["M"] = {
  name = "Curl",
  c = { "<cmd>lua require('curl').open_curl_tab()<cr>", "Send selected request" },
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

