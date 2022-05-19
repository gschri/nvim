-- fuzzyfinder.lua
-- telescope config
local map = vim.api.nvim_set_keymap

options = {noremap = true}

map('n','<leader>ff','<cmd>Telescope find_files<cr>',options)
map('n','<leader>fg','<cmd>Telescope live_grep<cr>',options)
map('n','<leader>fb','<cmd>Telescope buffers<cr>',options)
map('n','<leader>fh','<cmd>Telescope help_tags<cr>',options)

require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

require('telescope').load_extension('fzf')
