return {
    {
        "LhKipp/nvim-nu",
        opts = {
            use_lsp_features = true,
            all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']],
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- add tsx and treesitter
            vim.list_extend(opts.ensure_installed, {
                "nu",
            })
        end,
    },
}
