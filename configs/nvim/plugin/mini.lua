-- Mini.nvim
require('mini.comment').setup()
require('mini.splitjoin').setup()
require('mini.notify').setup()
require('mini.surround').setup()
require('mini.pick').setup()
require('mini.operators').setup()
require('mini.trailspace').setup()
require('mini.statusline').setup()
require('mini.indentscope').setup()
require('mini.bracketed').setup()
require('mini.files').setup()
require('mini.tabline').setup()
require('mini.move').setup({ mappings = { left = '<M-h>', right = '<M-l>', down = '<M-j>', up = '<M-k>', line_left = '<M-h>', line_right = '<M-l>', line_down = '<M-j>', line_up = '<M-k>', }, })
local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Tab triggers
        { mode = 'n', keys = '<Tab>' },

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
