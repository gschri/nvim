local map = vim.api.nvim_set_keymap
options = { noremap = true, silent = true }
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

-- Completion items tab customization
local M = {}
-- protocol.CompletionItemKind = {
M.icons = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}

function M.setup() 
  local kinds = protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end



local luadev = require('lua-dev').setup {}
-- Add aditional capabilities supported by nvim-cmp

local lspsaga = require 'lspsaga'
lspsaga.setup {}

-- Uses on_attach to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr,...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr,...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  -- Lsp mappings
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

  -- formatting
  if client.name == 'tsserver' then 
    client.resolved_capabilities.document_formatting = false
  end
  
  if client.resolved_capabilities.document_formatting then
    -- Format on save
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
  
  -- CompletionItemKind setup
  M.setup()

end

local servers = { 'pyright', 'sumneko_lua','cssls','emmet_ls','gopls','dartls','jsonls' }
-- In order for nvim-lsp-installer to register the necessary hooks at the
-- right moment, make sure to call it before lspconfig setup
require('nvim-lsp-installer').setup {
  automatic_installation = true
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp = require('cmp_nvim_lsp')
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- configure tsserver separately
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = {"javascript","javascriptreact","typescript","typescriptreact","typescript.tsx"},
  capabilities = capabilities
}

-- configure diagnosticls separately
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {"javascript","javascriptreact","json","typescript","typescriptreact","css","less","scss","pandoc"},
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = {'.git'},
        debounce = 100,
        args = {'--stdin', '--stdin-filename','%filename','--format','json'},
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        rootPatterns = {'.git'},
        args = {'--stdin','--stdin-filename','%filename','--fix-to-stdout'},
      },
      prettier = {
        command = 'prettier_d_slim',
        rootPatterns = {'.git'},
        args = {'--stdin','--stdin-filepath','%filename'}
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
    }
  }
}

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

-- Lsp saga mappings
map('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', options)
map('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', options)
map('i', '<C-k>', '<Cmd>Lspsaga signature_help<cr>', options)
map('n', 'gh', '<Cmd>Lspsaga lsp_finder<cr>', options)

lspconfig.sumneko_lua.setup(luadev)

-- Luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization.
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}
