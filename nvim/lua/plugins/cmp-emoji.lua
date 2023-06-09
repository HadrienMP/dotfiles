return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "megalithic/cmp-gitmoji" },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "gitmoji" } }))
        end,
    },
}
