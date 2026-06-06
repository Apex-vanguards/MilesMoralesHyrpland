-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Alt + 1, 2, 3... ilə bufferlər arasında keçid
for i = 1, 9 do
  map(
    "n",
    string.format("<A-%d>", i),
    string.format("<Cmd>BufferLineGoToBuffer %d<CR>", i),
    { desc = "Go to buffer " .. i }
  )
end
