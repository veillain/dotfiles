require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    view_options = { show_hidden = true },
    keymaps = {
        ["<CR>"] = "actions.select",
        ["q"] = { "actions.close", mode = "n" },
        ["h"] = { "actions.parent", mode = "n" },
        ["l"] = { "actions.select", mode = "n" },
        ["."] = { "actions.toggle_hidden", mode = "n" },
    },
})
