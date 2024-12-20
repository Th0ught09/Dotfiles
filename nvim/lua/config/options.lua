-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.hidden = true
vim.o.grepprg = "rg --vimgrep --smart-case --follow"
vim.g.lazyvim_picker = "fzf"
vim.o.scrolloff = 8
-- vim.o.syntax = "enable"
-- vim.o.filetype = "plugin indent on"
-- vim.o.clipboard = "unnamedplus"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.foldmethod = "manual"
vim.o.background = "light"
-- vim.o.nnoremap = "<C-w> "
-- vim.o.clipboard = {
--   name = "xclip",
--   copy = {
--     ["+"] = "xclip -selection clipboard",
--     ["*"] = "xclip -selection primary",
--   },
--   paste = {
--     ["+"] = "xclip -selection clipboard -o",
--     ["*"] = "xclip -selection primary -o",
--   },
--   cache_enabled = 0,
-- }
