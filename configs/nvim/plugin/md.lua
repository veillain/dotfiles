-- Markdown Setup
require("render-markdown").setup({})
require('render-markdown.integ.coq').setup()
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
