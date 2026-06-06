-- bootstrap lazy.nvim, LazyVim and your plugins
vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("botright 10split")
  vim.cmd("terminal /home/mrcat/Coding/Olimpads/main/compile.sh")

  vim.cmd("startinsert")
end)

vim.cmd([[
  highlight Normal guibg=none ctermbg=none
  highlight NonText guibg=none ctermbg=none
  highlight NormalNC guibg=none ctermbg=none
  highlight NeoTreeNormal guibg=none ctermbg=none
  highlight NeoTreeNormalNC guibg=none ctermbg=none
]])

vim.keymap.set("n", "<F6>", function()
  local problem_id = vim.fn.input("Tapşırıq nömrəsi (məs: 33A): ")

  if problem_id ~= "" then
    -- Yeni bir terminal yarat və skripti icra et
    vim.cmd("split | term /home/mrcat/Coding/Olimpads/main/Compile.sh " .. problem_id)

    -- Terminal açıldıqda kursoru ona keçir
    vim.cmd("wincmd j")
  end
end, { desc = "Run CF problem with F6" })

require("config.lazy")
