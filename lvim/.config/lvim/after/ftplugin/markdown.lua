vim.api.nvim_set_keymap("n", "<Leader>tf", ':lua require("tablemd").format()<cr>',
  { noremap = true, desc = "Format" })
vim.api.nvim_set_keymap("n", "<Leader>tc", ':lua require("tablemd").insertColumn(false)<cr>',
  { noremap = true, desc = "Insert Column" })
vim.api.nvim_set_keymap("n", "<Leader>td", ':lua require("tablemd").deleteColumn()<cr>',
  { noremap = true, desc = "Delete Column" })
vim.api.nvim_set_keymap("n", "<Leader>tr", ':lua require("tablemd").insertRow(false)<cr>',
  { noremap = true, desc = "Intert Row (false)" })
vim.api.nvim_set_keymap("n", "<Leader>tR", ':lua require("tablemd").insertRow(true)<cr>',
  { noremap = true, desc = "Intert Row (true)" })
vim.api.nvim_set_keymap("n", "<Leader>tj", ':lua require("tablemd").alignColumn("left")<cr>',
  { noremap = true, desc = "Align Column (left)" })
vim.api.nvim_set_keymap("n", "<Leader>tk", ':lua require("tablemd").alignColumn("center")<cr>',
  { noremap = true, desc = "Align Column (center)" })
vim.api.nvim_set_keymap("n", "<Leader>tl", ':lua require("tablemd").alignColumn("right")<cr>',
  { noremap = true, desc = "Align Column (right)" })

require('wrapping').soft_wrap_mode()


vim.api.nvim_set_keymap("n", "j", 'gj', { noremap = true })
vim.api.nvim_set_keymap("n", "k", 'gk', { noremap = true })
vim.api.nvim_set_keymap("n", "^", 'g^', { noremap = true })
vim.api.nvim_set_keymap("n", "$", 'g$', { noremap = true })
vim.api.nvim_set_keymap("n", "gj", 'j', { noremap = true })
vim.api.nvim_set_keymap("n", "gk", 'k', { noremap = true })
vim.api.nvim_set_keymap("n", "g^", '^', { noremap = true })
vim.api.nvim_set_keymap("n", "g$", '$', { noremap = true })
