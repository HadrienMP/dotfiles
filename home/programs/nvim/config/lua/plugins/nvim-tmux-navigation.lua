return {
    {
        "alexghergh/nvim-tmux-navigation",
        keys = {
            {
                "<C-h>",
                function()
                    require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
                end,
                desc = "Go left one pane",
            },
            {
                "<C-j>",
                function()
                    require("nvim-tmux-navigation").NvimTmuxNavigateUp()
                end,
                desc = "Got up one pane",
            },
            {
                "<C-k>",
                function()
                    require("nvim-tmux-navigation").NvimTmuxNavigateDown()
                end,
                desc = "Go down one pane",
            },
            {
                "<C-l>",
                function()
                    require("nvim-tmux-navigation").NvimTmuxNavigateRight()
                end,
                desc = "Go right one pane",
            },
        },
    },
}
