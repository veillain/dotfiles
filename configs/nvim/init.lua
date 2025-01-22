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
-- 'gt' next tab
-- 'gw' next window
-- 'gq' exit current
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
    "https://github.com/echasnovski/mini.clue",
    "https://github.com/echasnovski/mini.completion",
    "https://github.com/echasnovski/mini.files",
    "https://github.com/echasnovski/mini.hipatterns",
    "https://github.com/echasnovski/mini.indentscope",
    "https://github.com/echasnovski/mini.move",
    "https://github.com/echasnovski/mini.operators",
    "https://github.com/echasnovski/mini.pick",
    "https://github.com/echasnovski/mini.splitjoin",
    "https://github.com/echasnovski/mini.statusline",
    "https://github.com/echasnovski/mini.surround",
    "https://github.com/echasnovski/mini.tabline",
    "https://github.com/echasnovski/mini.trailspace",
    -- Nvim.cmp
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/hrsh7th/nvim-cmp",
    -- AutoFormat
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/zapling/mason-conform.nvim",
    "https://github.com/stevearc/conform.nvim",
    -- Markdown Plugin
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/toppair/peek.nvim",
    "https://github.com/epwalsh/obsidian.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    -- Pomodoro Plugin
    "https://github.com/epwalsh/pomo.nvim",
    "https://github.com/rcarriga/nvim-notify",
    -- Typing Test!
    "https://github.com/nvzone/typr",
    "https://github.com/nvzone/volt",
    -- Other
    "https://github.com/letieu/btw.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/lambdalisue/vim-suda",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/windwp/nvim-autopairs",
}
vim.g.post_download_hooks = {
    -- Markdown Afterinstall
    "!cd ~/.local/share/nvim/site/pack/plugins/start/peek.nvim; deno task --quiet build:fast"
}

-- Plugins Setup
require("oil").setup({ default_file_explorer = true, delete_to_trash = true, view_options = { show_hidden = true } })
require("tokyonight").setup({ transparent = true })
require("flash").setup({})
require("btw").setup({ text = "I use Neovim in an Arch (BTW)", })
require("nvim-autopairs").setup({})
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "bash", "lua", "vim", "javascript", "typescript", "python", "css", "cpp", "html", "json", "jsonc", "markdown", "markdown_inline" }
})
vim.cmd("colorscheme bliss")

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
vim.g.have_nerd_font = true


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
vim.opt.autochdir = true
-- Obsidian need this
vim.opt_local.conceallevel = 2

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- vim.api.nvim_create_augroup("floaterminal", { clear = true })
-- -- vim.api.nvim_create_autocmd("BufEnter",
-- --     { command = "source $HOME/.config/nvim/plugin/floaterminal.lua", group = "floaterminal" })
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--     group = "floaterminal",
--     pattern = "*",
--     callback = function()
--         vim.cmd([[  source $HOME/.config/nvim/plugin/floaterminal.lua ]])
--     end
-- })

-- Floaterminal

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
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
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
    vim.cmd('normal i')
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Open Floating Terminal" })
