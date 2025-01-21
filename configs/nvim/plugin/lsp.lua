-- Autoformat Setup
require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}
require("lspconfig").vimls.setup {}
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()
end)

lsp_zero.omnifunc.setup({
    trigger = '<C-Space>',
    tabcomplete = true,
    use_fallback = true,
    update_on_delete = true,
})

lsp_zero.new_client({
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    on_init = function(client)
        lsp_zero.nvim_lua_settings(client, {})
    end,
    root_dir = function(bufnr)
        return vim.fs.root(bufnr, { '.git', '.luarc.json', '.luarc.jsonc' })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})
