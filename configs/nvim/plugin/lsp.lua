-- Autoformat Setup
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
})
require("lspconfig").vimls.setup({})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "bashls",
        "cssls",
        "html",
        "jdtls",
        "glint",
        "biome",
        "marksman",
        "taplo",
        "yamlls",
        "vimls",
    },
})

require("mason-conform").setup({
    ignore_install = {}, -- List of formatters to ignore during install
})

local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        -- jsonc = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        java = { "google-java-format" },
        -- html = { "htmlbeautifier" },
        bash = { "beautysh" },
        conf = { "beautysh" },
        sh = { "beautysh" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
    },
    -- format_on_save = {
    -- 	timeout_ms = 500,
    -- 	lsp_fallback = true,
    -- },
})
vim.keymap.set({ "n", "v" }, "<leader>ft", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (in visual mode)" })

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	callback = function(args)
-- 		require("conform").format({ bufnr = args.buf })
-- 	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})
