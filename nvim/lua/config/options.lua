-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.hidden = true
vim.o.grepprg = "rg --vimgrep --smart-case --follow"
vim.g.lazyvim_picker = "fzf"
vim.opt.clipboard = unnamed
