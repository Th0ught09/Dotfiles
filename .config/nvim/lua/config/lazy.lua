local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "tokyonight", "gruvbox" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
})

local dap = require("dap")
dap.defaults.fallback.external_terminal = {
  command = "alacritty",
  args = { "--hold" },
}

-- dap.adapters["local-lua"] = {
--   type = "executable",
--   command = "lua",
--   args = {
--     "/home/kirkm/Programs/debugger.lua/debugger.lua",
--   },
--   enrich_config = function(config, on_config)
--     if not config["extensionPath"] then
--       local c = vim.deepcopy(config)
--       c.extensionPath = "/home/kirkm/Programs/debugger.lua/"
--       on_config(c)
--     else
--       on_config(config)
--     end
--   end,
-- }
dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    "/home/kirkm/Programs/local-lua-debugger-vscode/extension/debugAdapter.js",
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      c.extensionPath = "/home/kirkm/Programs/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}

dap.configurations.lua = {
  {
    name = "Current file (local-lua-dbg, lua)",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "nlua",
      file = "${file}",
    },
    verbose = true,
    args = {},
  },
}

dap.adapters.haskell = {
  type = "executable",
  command = "haskell-debug-adapter",
  args = { "--hackage-version=0.0.33.0" },
}
dap.configurations.haskell = {
  {
    type = "haskell",
    request = "launch",
    name = "Debug",
    workspace = "${workspaceFolder}",
    startup = "${file}",
    stopOnEntry = true,
    logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
    logLevel = "WARNING",
    ghciEnv = vim.empty_dict(),
    ghciPrompt = "λ: ",
    -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
    ghciInitialPrompt = "λ: ",
    ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
  },
}
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "lsp_status" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

require("mason-lspconfig").setup({
  ensure_installed = {},
  automatic_installation = false,
})

require("lspconfig").clangd.setup({})

require("neogen").setup({
  languages = {
    python = {
      template = {
        annotation_convention = "reST",
      },
    },
  },
})

require("conform").setup({
  formatters_by_ft = {
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
  },
})
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
