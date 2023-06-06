return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-emoji", "megalithic/cmp-gitmoji" },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources =
                cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" }, { name = "gitmoji" } }))
        end,
    },
}
