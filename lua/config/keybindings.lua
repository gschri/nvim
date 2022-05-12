-- keybindings.lua

local map = vim.api.nvim_set_keymap

-- set the leader key
vim.g.mapleader = ','

options = { noremap = true }

-- Create windows 
-- Vertical
map('n','<leader>v','<C-w>v<C-w>l',options)
-- Horizontal
map('n','<leader>m','<C-w>s<C-w>j',options)
-- Delete Current
map('n','<leader>d','<C-w>q',options)

-- Navigate windows
-- Use Ctrl+{h,j,l,k} to navigate windows
map('n','<C-h>','<C-w>h',options)
map('n','<C-j>','<C-w>j',options)
map('n','<C-k>','<C-w>k',options)
map('n','<C-l>','<C-w>l',options)

-- Maps <C-c> to <esc>
map('n','<C-c>','<esc>',options)

-- Line Movement
-- Go to the start of line with H and to the end with L
map('n','L','$',options)
map('n','H','^',options)


