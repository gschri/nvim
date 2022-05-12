-- fileexplorer.lua
require('nvim-tree').setup {}
-- default setup
local map = vim.api.nvim_set_keymap

options = {noremap = true,silent = true}

-- Toggle File explorer
map('n','<C-n>',':NvimTreeToggle<CR>',options)
