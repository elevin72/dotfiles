-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  -- use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  -- use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  -- use 'hrsh7th/cmp-nvim-lsp'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'saadparwaiz1/cmp_luasnip'
  -- use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- My additions:
  use 'psliwka/vim-smoothie'
  use 'sainnhe/gruvbox-material'
  use 'rebelot/kanagawa.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }
  use 'windwp/nvim-autopairs'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end
  }
  -- use 'hrsh7th/cmp-path'
  use {
      'ray-x/lsp_signature.nvim',
  }
  use {
      'ThePrimeagen/harpoon',
      requires = { 'nvim-lua/popup.nvim' },
      config = function() require'harpoon'.setup {} end
  }
  use {
      'akinsho/flutter-tools.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
  }
  use 'mbbill/undotree'
  use "rafamadriz/friendly-snippets"

  -- coq
  use {
      'ms-jpq/coq_nvim',
      branch ='coq'
  }

  use {
      'ms-jpq/coq.artifacts',
      branch ='artifacts'
  }
  -- use {
  --     'ms-jpq/coq.thirdparty',
  --     branch='3p'
  -- }
  use 'averms/black-nvim'
  use('MunifTanjim/prettier.nvim')
  use 'b3nj5m1n/kommentary'
  -- use 'simrat39/rust-tools.nvim'
  use 'norcalli/nvim-colorizer.lua'
end)

require('lsp_signature').setup { floating_window = false, }

--NvimTree
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
view = {
    mappings = {
      custom_only = false,
      list = {
	  { key = {"-"}, cb = tree_cb("close"), mode = "n"}
      }
    }
  }
}
vim.api.nvim_set_keymap('n','-', ':NvimTreeToggle<CR>', {noremap = true})



vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.scrolloff = 8

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--copy to system clipboard
vim.cmd([[set clipboard+=unnamedplus]])

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2

vim.g.background = 'dark'
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_disable_italic_comment = 0

vim.cmd [[colorscheme gruvbox-material]]


--[[ require('kanagawa').setup({ statementStyle = "NONE" })

vim.cmd("colorscheme kanagawa") ]]


require'colorizer'.setup()

--Set statusbar
vim.g.lightline = {
  colorscheme = 'gruvbox_material',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'absolutepath', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('n', '<TAB>', '<C-^>', { noremap = true, silent = true } )
vim.api.nvim_set_keymap('n', '<c-p>', ':cp<CR>', { noremap = true} )
vim.api.nvim_set_keymap('n', '<c-n>', ':cn<CR>', { noremap = true} )

vim.api.nvim_set_keymap('n', 'q:', 'nop', { noremap = true, silent = true} )
vim.api.nvim_set_keymap('n', 'Q', 'nop', { noremap = true, silent = true} )

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- y/c/d in something by default
vim.api.nvim_set_keymap('n', 'Y', 'yg_', { noremap = true })
vim.api.nvim_set_keymap('n', 'P', 'vg_pgvy', { noremap = true })
vim.api.nvim_set_keymap('n', 'yw', 'yiw', { noremap = true })
vim.api.nvim_set_keymap('n', "y'", "yi'", { noremap = true })
vim.api.nvim_set_keymap('n', 'y"', 'yi"', { noremap = true })
vim.api.nvim_set_keymap('n', 'y)', 'yi)', { noremap = true })
vim.api.nvim_set_keymap('n', 'dw', 'diw', { noremap = true })
vim.api.nvim_set_keymap('n', 'd)', 'di)', { noremap = true })
vim.api.nvim_set_keymap('n', 'cw', 'ciw', { noremap = true })
vim.api.nvim_set_keymap('n', "c'", "ci'", { noremap = true })
vim.api.nvim_set_keymap('n', 'c"', 'ci"', { noremap = true })
vim.api.nvim_set_keymap('n', 'c)', 'ci)', { noremap = true })

-- replace current word/"/'/) with what is in default register
vim.api.nvim_set_keymap('n', '<leader>w', 'viwpgvy', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>"', 'vi"pgvy', { noremap = true })
vim.api.nvim_set_keymap('n', "<leader>'", "vi'pgvy", { noremap = true })
vim.api.nvim_set_keymap('n', "<leader>)", "vi)pgvy", { noremap = true })

vim.api.nvim_set_keymap('n', "<leader>P", [["_diwP]], { noremap = true })

vim.api.nvim_set_keymap('n', "J", "mzJ`z", { noremap = true })


--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = false
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Harpoon mark commands
-- vim.cmd([[
--     nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
--     nnoremap 'a :lua require("harpoon.ui").nav_file(1)<CR>
--     nnoremap 's :lua require("harpoon.ui").nav_file(2)<CR>
--     nnoremap 'd :lua require("harpoon.ui").nav_file(3)<CR>
--     nnoremap 'f :lua require("harpoon.ui").nav_file(4)<CR>
--     nnoremap 'ta :lua require("harpoon.term").gotoTerminal(1)<CR>
--     nnoremap 'ts :lua require("harpoon.term").gotoTerminal(2)<CR>
--     nnoremap 'td :lua require("harpoon.term").gotoTerminal(3)<CR>
-- ]])

-- COQ
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = {
    auto_start = true,
    clients = {
        tree_sitter = {
            enabled = false
        }
    },
    keymap = {
        recommended = false
    }
}

local coq = require "coq"

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end



remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>m", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", ':lua require("harpoon.mark").set_current_at(1)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", ':lua require("harpoon.mark").set_current_at(2)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ':lua require("harpoon.mark").set_current_at(3)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", ':lua require("harpoon.mark").set_current_at(4)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>h", ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>j", ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>th", ':lua require("harpoon.term").gotoTerminal(1)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tj", ':lua require("harpoon.term").gotoTerminal(2)<CR>', { noremap = true })

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end


-- nvim-cmp supports additional completion capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'clangd','rust_analyzer', 'pyright', 'tsserver', 'gopls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- require('rust-tools').setup({})

-- Example custom server
local sumneko_root_path = vim.fn.getenv 'HOME' .. '/repos/lua-language-server' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local pid = vim.fn.getpid()
local omnisharp_bin = vim.fn.getenv 'HOME' .. '/repos/omnisharp-linux-x64/run'
require'lspconfig'.omnisharp.setup(coq.lsp_ensure_capabilities{
     -- handlers = {
     --   ["textDocument/onTypeFormatting"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { }),
     -- },
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = on_attach,
    -- root_dir = nvim_lsp.util.root_pattern(".sln") or nvim_lsp.util.root_pattern(".csproj")
})

require("flutter-tools").setup{
    widget_guides = {
        enabled = true,
    },
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
        }
    }
}

require'lspconfig'.jdtls.setup{
    cmd = { 'jdtls' },
    root_dir = function(fname)
        return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
    end,
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- require('luasnip').filetype_extend("cs", {"csharp"});
-- local luasnip = require('luasnip');
-- require("luasnip/loaders/from_vscode").lazy_load()


-- nvim-cmp setup

-- local cmp = require 'cmp'
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end,
--     ['<S-Tab>'] = function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end,
--   },
--   formatting = {
--     format = function(entry, vim_item)
--       -- set a name for each source
--       vim_item.menu = ({
--         buffer = "[Buffer]",
--         nvim_lsp = "[LSP]",
--         path = "[Path]",
--         luasnip = "[Snip]"
--       })[entry.source.name]
--       return vim_item
--     end
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'path'},
--     { name = 'luasnip' },
--     { name = 'buffer' },
--   },
-- }
--


-- AutoPairs, after cmp
-- require('nvim-autopairs').setup{}
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local autopairs_cmp = require('cmp')
-- autopairs_cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


vim.cmd([[
augroup dartgroup
    autocmd!
    autocmd FileType dart set tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufWrite *.dart :Format
augroup END

augroup jsgroup
    autocmd!
    autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2
augroup END

augroup pythongroup
    autocmd!
    autocmd FileType python command! Black call Black()
augroup END

augroup xmlgroup
    autocmd!
    autocmd FileType xml setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
]])

