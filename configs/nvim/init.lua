-- Plugins
vim.g.plugins = {
	-- PM
	"https://github.com/BryceVandegrift/pm",
	-- Colorschemes
	"https://github.com/neanias/everforest-nvim",
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/Everblush/nvim",
	-- Others
	"https://github.com/letieu/btw.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/lambdalisue/vim-suda",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/brenoprata10/nvim-highlight-colors",
}
vim.g.post_download_hooks = {}


-- Plugins Setup
require("btw").setup({ text = "I use neovim inside Arch (BTW)" })
require("flash").setup({})
require("oil").setup({})
require("nvim-autopairs").setup({})
require("nvim-highlight-colors").setup({})
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = {
		"bash",
		"lua",
		"vim",
		"css",
		"cpp",
		"html",
		"json",
		"jsonc",
		"python",
		"markdown",
		"javascript",
		"typescript",
		"markdown_inline",
	},
})

-- Colorschemes Setup
require("everforest").setup({ background = "medium" })
require("tokyonight").setup({ transparent = true, })
-- vim.cmd([[
-- 	augroup TransparentBackground
-- 	autocmd!
-- 	autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
-- 	autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
-- 	augroup END
-- ]])
vim.cmd("colorscheme everblush")


-- Basic Settings
vim.opt.title = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.g.have_nerd_font = true

-- Indentation Settings
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- always use space instead of tab chars.
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.textwidth = 0
vim.opt.autochdir = true

vim.opt_local.conceallevel = 2


-- Others

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Floaterminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
    vim.cmd("normal i")
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})


---- Remaps ----
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("x", "<leader>p", "\"_dP")
