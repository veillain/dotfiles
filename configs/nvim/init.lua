-- Plugins
vim.g.plugins = {
	"https://github.com/BryceVandegrift/pm",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/tpope/vim-surround",
	"https://github.com/tpope/vim-commentary",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/letieu/btw.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/ms-jpq/coq_nvim",
    "https://github.com/ms-jpq/coq.artifacts",
    "https://github.com/ms-jpq/coq.thirdparty",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/echasnovski/mini.indentscope",
    "https://github.com/echasnovski/mini.bracketed",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim"
}


-- Plugins Setup
require("oil").setup({ default_file_explorer = true, delete_to_trash = true, view_options = { show_hidden = true } })
require("tokyonight").setup({ transparent = true })
require("flash").setup({})
require("nvim-highlight-colors").setup({})
require("btw").setup({ text = "I use Neovim in an Arch (BTW)", })
require("nvim-autopairs").setup({})
require("fidget").setup({})
require("mini.indentscope").setup({})
require("mini.bracketed").setup({})
require("render-markdown").setup({})
require('render-markdown.integ.coq').setup()
require("nvim-treesitter.configs").setup({ 
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "bash", "lua", "vim", "javascript", "typescript", "python", "css", "cpp", "html", "json", "jsonc" }
})
vim.cmd("colorscheme tokyonight")


-- Leader Settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Sum Keymappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', ';', '<esc>:') -- ; as :
vim.keymap.set('n', '<Tab>', '<cmd>bnext<cr>') -- tab to go to next buffer
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<cr>') -- shift tab to go to previous buffer
vim.keymap.set('n', '<leader>xx', '<cmd>q<cr>') -- Exit using leader + xx
vim.keymap.set('n', '-', '<cmd>Oil<cr>') -- Oil
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fc', builtin.colorscheme)
vim.keymap.set('n', '<leader>f/', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', 's', function() require("flash").jump() end)
vim.keymap.set('n', 'S', function() require("flash").treesitter() end)
vim.keymap.set('n', '<leader>nt', '<Cmd>Neotree toggle<CR>')


-- Basic Settings
vim.opt.title = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.termguicolors = true


-- Indentation Settings
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- always use space instead of tab characters
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.textwidth = 0


require('telescope').setup {
  pickers = {
      find_files = { hidden = true }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')

vim.g.coq_settings = {
    auto_start = true,
}

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

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
