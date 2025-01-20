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
    "https://github.com/machakann/vim-highlightedyank",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/windwp/nvim-autopairs",
}
vim.g.post_download_hooks = {
    -- Markdown Afterinstall
    "!cd ~/.local/share/nvim/site/pack/plugins/start/peek.nvim; deno task --quiet build:fast"
}

-- Mini.nvim
require('mini.comment').setup()
-- require('mini.completion').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()
require('mini.pick').setup()
require('mini.operators').setup()
require('mini.trailspace').setup()
-- require('mini.statusline').setup()
require('mini.hipatterns').setup()
require('mini.indentscope').setup()
require('mini.bracketed').setup()
require('mini.files').setup()
require('mini.tabline').setup()
require('mini.move').setup({mappings = { left = '<M-h>', right = '<M-l>', down = '<M-j>', up = '<M-k>', line_left = '<M-h>', line_right = '<M-l>', line_down = '<M-j>', line_up = '<M-k>', },})
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Tab triggers
    { mode = 'n', keys = '<Tab>'},

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

-- Completion Setup
vim.cmd([[lua <<EOF
    local luasnip = require'luasnip'
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'render-markdown' },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
EOF]])

-- Markdown Setup
require("peek").setup({
    app = 'browser',
    filetype = { 'markdown' },
    update_on_change = true,
    close_on_bdelete = true,
})
vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

require("obsidian").setup({
    workspaces = {
        {
            name = "Notes",
            path = "~/Notes",
        },
    },
    completion = {
        nvim_cmp = true,
        min_chars = 2,
    },
    mappings = {
        ["<cr>"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        },
    },
    ui = { enable = false },
})

-- Pomodoro Setup
require('pomo').setup({
    update_interval = 1000,
    notifiers = {
    {
      name = "Default",
      opts = {
        sticky = true,
        title_icon = "󱎫",
        text_icon = "󰄉",
        -- Replace the above with these if you don't have a patched font:
        -- title_icon = "⏳",
        -- text_icon = "⏱️",
      },
      { name = "System" },
    },
    timers = {
        Break = {
            { name = "System" },
        },
    },
  sessions = {
    pomodoro = {
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Long Break", duration = "15m" },
    },
  },
  },
})

-- Plugins Setup
require("oil").setup({ default_file_explorer = true, delete_to_trash = true, view_options = { show_hidden = true } })
require("tokyonight").setup({ transparent = true })
require("flash").setup({})
require("btw").setup({ text = "I use Neovim in an Arch (BTW)", })
require("nvim-autopairs").setup({})
require("render-markdown").setup({})
require('render-markdown.integ.coq').setup()
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "bash", "lua", "vim", "javascript", "typescript", "python", "css", "cpp", "html", "json", "jsonc", "markdown", "markdown_inline" }
})
vim.cmd("colorscheme bliss")


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
vim.cmd([[
    cnoreabbrev sw :SudaWrite<cr>
    cnoreabbrev ws :SudaWrite<cr>
    cnoreabbrev wf :SudaWrite<cr>
    cnoreabbrev fw :SudaWrite<cr>
    cnoreabbrev sq :SudaWrite<cr>
    cnoreabbrev qs :SudaWrite<cr>
    cnoreabbrev qf :q!<cr>
    cnoreabbrev fq :q!<cr>
    ]])
vim.keymap.set('n', ';', '<esc>:') -- ; as :
vim.keymap.set('n', '-', '<cmd>Oil<cr>') -- Oil
vim.keymap.set('n', 's', function() require("flash").jump() end)
vim.keymap.set('n', 'S', function() require("flash").treesitter() end)
vim.keymap.set('n', 'f', function() require("flash").jump({ search = { forward = true, wrap = false, multi_window = false }, }) end)
vim.keymap.set('n', 't', function() require("flash").jump({ search = { forward = false, wrap = false, multi_window = false }, }) end)
vim.keymap.set('n', '<C-Tab>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<C-S-Tab>', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<Tab>b', '<cmd>bnext<cr>', { desc = "Move to Next buffer"})
vim.keymap.set('n', '<Tab>B', '<cmd>bprevious<cr>', { desc = "Move to Previous buffer"})
vim.keymap.set('n', '<Tab>w', '<C-W>w', { desc = "Move to Next Window"})
vim.keymap.set('n', '<Tab>W', '<C-W>W', { desc = "Move to Previous Window"})
vim.keymap.set('n', '<leader>xx', '<cmd>q<cr>', { desc = "Exit Neovim"})
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = "Find Files"})
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = "Live Grep"})
vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<cr>', { desc = "Find Buffer"})
vim.keymap.set('n', '<leader>nt', minifiles_toggle, { desc = "File Manager"})
vim.keymap.set('n', '<leader>dw', '<cmd>close<cr>', { desc = "Close current window"})
vim.keymap.set('n', '<leader>dow', '<cmd>only<cr>', { desc = "Close other windows, except focused"})
vim.keymap.set('n', '<leader>vs', '<cmd>vertical new<cr>', { desc = "Open new window in Vertical"})
vim.keymap.set('n', '<leader>hs', '<cmd>horizontal new<cr>', { desc = "Open new window in Vertical"})
vim.keymap.set('n', '<leader>db', '<cmd>enew<bar>bd #<cr>', { desc = "Close current buffer"})
vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<cr>', { desc = "Toggle render markdown" })


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

-- Obsidian need this
vim.opt_local.conceallevel = 2
