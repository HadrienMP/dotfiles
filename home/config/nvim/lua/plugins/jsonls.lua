return {
    {
        "neovim/nvim-lspconfig",
        enable = false,
        opts = {
            -- make sure mason installs the server
            servers = {
                jsonls = {
                    -- lazy-load schemastore when needed
                    settings = {
                        json = {
                            format = {
                                enable = false,
                            },
                        },
                    },
                },
            },
        },
    },
}
