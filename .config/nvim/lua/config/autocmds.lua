-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.txt" },
  command = "silent loadview",
})
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.txt" },
  command = "mkview",
})
