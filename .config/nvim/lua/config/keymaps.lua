-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local api = vim.api
local function find_test()
  local bufnr = api.nvim_get_current_buf()
  local lang = "lua"
  local end_row = api.nvim_win_get_cursor(0)[1]
  local query = vim.treesitter.query.parse(
    lang,
    [[
      ((function_call
        name: (identifier) @name (#any-of? @name "describe" "it")
        arguments: (arguments
          ((string) @str)
        )
      ))
    ]]
  )

  local function get_text(root)
    local start_row = root:range()
    for id, node in query:iter_captures(root, bufnr, start_row, end_row) do
      local name = query.captures[id]
      local text = vim.treesitter.get_node_text(node, bufnr)
      assert(text and type(text) == "string")
      if name == "str" then
        -- strip leading and trailing quotes
        return text:sub(2, #text - 1)
      end
    end
    return nil
  end

  local node = vim.treesitter.get_node()
  local path = {}
  while node ~= nil do
    if node:type() == "function_call" then
      local text = get_text(node)
      if text then
        table.insert(path, text)
      end
    end
    node = node:parent()
  end

  for i = 1, math.floor(#path * 0.5) do
    local tmp = path[i]
    path[i] = path[#path - (i - 1)]
    path[#path - (i - 1)] = tmp
  end

  return path
end

local dap = require("dap")
vim.keymap.set("n", "<leader>dn", function()
  local path = find_test()
  local name = table.concat(path, " ")
  dap.run({
    name = name,
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      command = "busted",
    },
    args = {
      api.nvim_buf_get_name(0),
      '--filter="' .. name .. '"',
    },
  })
end)
