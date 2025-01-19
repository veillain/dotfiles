-- keymapping Informations
-- 'gcc' for autocomment
-- 'gS' for auto split or join text (must in the first letter after {}/()/[])
-- '<win>[hjkl]' for moving blocked text
-- 'sa[w]"' for surrounding text with ""
-- 'sd' for remove
-- 'sr' for replace
-- 'sh' for highlight surroundings
-- 'g=[i]' for execute operations
-- 'gx[iw]' for exchange word
-- 'gr[iw]' for replace word
-- 'gs[s|p]' for sorting line, paragraph
-- ']b' for next buffer
-- '[b' for prev buffer
-- '<leader>ff' for opening find files
-- '<leader>fg' for opening live grep
-- '<leader>nt' for opening/closing mini.files
-- '<leader>db' to delete current buffer

-- Plugins
vim.g.plugins = {
    -- Plugin Manager
	"https://github.com/BryceVandegrift/pm",
    -- Folke
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/folke/flash.nvim",
    -- Mini.nvim
	"https://github.com/echasnovski/mini.comment",
    "https://github.com/echasnovski/mini.bracketed",
    "https://github.com/echasnovski/mini.completion",
    "https://github.com/echasnovski/mini.files",
    "https://github.com/echasnovski/mini.indentscope",
    "https://github.com/echasnovski/mini.move",
    "https://github.com/echasnovski/mini.notify",
    "https://github.com/echasnovski/mini.operators",
    "https://github.com/echasnovski/mini.pick",
    "https://github.com/echasnovski/mini.splitjoin",
    "https://github.com/echasnovski/mini.statusline",
    "https://github.com/echasnovski/mini.surround",
    "https://github.com/echasnovski/mini.trailspace",
    "https://github.com/echasnovski/mini.bufremove",
    -- Other
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/letieu/btw.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
}

-- Mini.nvim
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()
require('mini.notify').setup()
require('mini.pick').setup()
require('mini.operators').setup()
require('mini.trailspace').setup()
require('mini.statusline').setup()
require('mini.bufremove').setup()
require('mini.move').setup({mappings = { left = '<D-h>', right = '<D-l>', down = '<D-j>', up = '<D-k>', line_left = '<D-h>', line_right = '<D-l>', line_down = '<D-j>', line_up = '<D-k>', },}
)

-- Plugins Setup
require("oil").setup({ default_file_explorer = true, delete_to_trash = true, view_options = { show_hidden = true } })
require("tokyonight").setup({ transparent = true })
require("flash").setup({})
require("nvim-highlight-colors").setup({})
require("btw").setup({ text = "I use Neovim in an Arch (BTW)", })
require("nvim-autopairs").setup({})
require("mini.indentscope").setup({})
require("mini.bracketed").setup({})
require("render-markdown").setup({})
require('render-markdown.integ.coq').setup()
require('mini.files').setup()
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
local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
  end
local imap_expr = function(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { expr = true })
  end
imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
vim.keymap.set('n', ';', '<esc>:') -- ; as :
vim.keymap.set('n', '<C-Tab>', '<cmd>bnext<cr>') -- tab to go to next buffer
vim.keymap.set('n', '<C-S-Tab>', '<cmd>bprevious<cr>') -- shift tab to go to previous buffer
vim.keymap.set('n', '<leader>xx', '<cmd>q<cr>') -- Exit using leader + xx
vim.keymap.set('n', '-', '<cmd>Oil<cr>') -- Oil
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>')
vim.keymap.set('n', 's', function() require("flash").jump() end)
vim.keymap.set('n', 'S', function() require("flash").treesitter() end)
vim.keymap.set('n', '<leader>nt', minifiles_toggle)
vim.keymap.set('n', '<leader>db', '<cmd>lua MiniBufremove.unshow()<cr>')


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
