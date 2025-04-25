-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.hidden = true
vim.o.grepprg = "rg --vimgrep --smart-case --follow"
-- vim.g.lazyvim_picker = "fzf"
vim.o.scrolloff = 8
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.foldmethod = "manual"
vim.o.background = "light"
vim.g.snacks_animate = false

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })
