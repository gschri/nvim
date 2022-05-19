require('config.main')

local set = vim.opt
-- Show line numbers
set.number = true
-- Case-insensitive searching
set.ignorecase = true
-- Faster completion
set.updatetime = 300
-- Show cursor position
set.ruler = true
-- Highlight matches as you go
set.incsearch = true
-- Display lines as one long line
set.wrap = false
set.hidden = true
-- Global tab width
set.tabstop = 2
-- And again, related
set.shiftwidth = 2
-- Converts, tabs to spaces
set.expandtab = true
-- Set number column width to 2 (default 4)
set.numberwidth = 4

-- Filetypes
------------------------------------
-- Javascript
vim.cmd [[au BufNewFile,BufRead *.es6 setf javascript]]
-- Typescript
vim.cmd [[au BufNewFile,BufRead *.tsx setf typescriptreact]]
-- Markdown
vim.cmd [[au BufNewFile,BufRead *.md set filetype=markdown]]
vim.cmd [[au BufNewFile,BufRead *.mdx set filetype=markdown]]
-- YAML
vim.cmd [[autocmd FileType yaml setlocal shiftwidth=2 tabstop=2]]
