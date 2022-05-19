-- comments.lua
-- start with defaults
require('Comment').setup()

-- configure Comment  (or any other comment plugin ) to work with complex filetypes
-- such as tsx and jsx by using context while commenting 
require('nvim-treesitter.configs').setup {
  context_commentstring = {
    enable = true,
  }
}
