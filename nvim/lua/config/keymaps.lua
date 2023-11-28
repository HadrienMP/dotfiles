-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Disable arrow keys
-- map("", "<up>", "<nop>")
-- map("", "<down>", "<nop>")
-- map("", "<left>", "<nop>")
-- map("", "<right>", "<nop>")

-- Switch buffers
-- <S-r> means capital R (Shift + R)
-- Bépo mapping
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
