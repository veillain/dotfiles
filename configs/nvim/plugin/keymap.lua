-- Leader Settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sum Keymappings
local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
end
local imap_expr = function(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
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
    cnoreabbrev ft :Floaterminal
    ]])
vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>Floaterminal<cr>')
vim.keymap.set('n', ';', '<esc>:')       -- ; as :
vim.keymap.set('n', '-', '<cmd>Oil<cr>') -- Oil
vim.keymap.set('n', 's', function() require("flash").jump() end)
vim.keymap.set('n', 'S', function() require("flash").treesitter() end)
vim.keymap.set('n', 'f',
    function() require("flash").jump({ search = { forward = true, wrap = false, multi_window = false }, }) end)
vim.keymap.set('n', 't',
    function() require("flash").jump({ search = { forward = false, wrap = false, multi_window = false }, }) end)

---- Tab, Window, Buffer ----
vim.keymap.set('n', 'gb', '<cmd>bnext<cr>', { desc = "Move to next Buffer" })
vim.keymap.set('n', 'gB', '<cmd>bprevious<cr>', { desc = "Move to prev Buffer" })
vim.keymap.set('n', 'gw', '<C-w>w', { desc = "Move to next Window" })
vim.keymap.set('n', 'gW', '<C-w>W', { desc = "Move to prev Window" })
vim.keymap.set('n', 'gt', '<cmd>tabnext<cr>', { desc = "Move to next Tab" })
vim.keymap.set('n', 'gT', '<cmd>tabprevious<cr>', { desc = "Move to prev Tab" })
vim.keymap.set('n', 'gv', '<cmd>vnew<cr>', { desc = "Split new vertical window" })
vim.keymap.set('n', 'gqb', '<cmd>bd!<cr>', { desc = "Close current Buffer" })
vim.keymap.set('n', 'gqt', '<cmd>tabclose<cr>', { desc = "Close current Tab" })
vim.keymap.set('n', 'gnt', '<cmd>tab new<cr>', { desc = "Create new Tab" })

---- Others ----
vim.keymap.set('n', '<leader>xx', '<cmd>q<cr>', { desc = "Exit Neovim" })
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<cr>', { desc = "Find Buffer" })
vim.keymap.set('n', '<leader>nt', minifiles_toggle, { desc = "File Manager" })
vim.keymap.set('n', '<leader>dw', '<cmd>close<cr>', { desc = "Close current window" })
vim.keymap.set('n', '<leader>dow', '<cmd>only<cr>', { desc = "Close other windows, except focused" })
vim.keymap.set('n', '<leader>vs', '<cmd>vertical new<cr>', { desc = "Open new window in Vertical" })
vim.keymap.set('n', '<leader>hs', '<cmd>horizontal new<cr>', { desc = "Open new window in Vertical" })
vim.keymap.set('n', '<leader>db', '<cmd>enew<bar>bd #<cr>', { desc = "Close current buffer" })
vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<cr>', { desc = "Toggle render markdown" })
