-- return {}
return {
    {
        'saghen/blink.compat',
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = '*',
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = "enter" },

            completion = {
                list = {
                    selection = {
                        preselect = false,
                    }
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
                        components = {
                            kind_icon = {
                                ellipsis = true,
                                text = function(ctx)
                                    local kind_icon = require "config.icons"[ctx.kind]
                                    return kind_icon .. "|"
                                end,
                            },
                            label_description = {
                                text = function(ctx)
                                    local item = ctx.item

                                    local sources = {
                                        {
                                            pattern = "bootstrap",
                                            label = "[Bootstrap]",
                                            icon = " ",
                                        },
                                        {
                                            pattern = "foundation",
                                            label = "[Foundation]",
                                            icon = " ",
                                        },
                                    }

                                    if ctx.source_name == "html-css" then
                                        for _, s in pairs(sources) do
                                            if item.data.source_name:match(s.pattern) then
                                                return s.icon
                                            elseif item.data.source_type == "local" then
                                                return "local"
                                            end
                                        end
                                    end
                                end
                            }
                        }
                    },
                }
            },


            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', "html-css" },
                providers = {
                    ["html-css"] = {
                        name = "html-css",
                        module = "blink.compat.source",
                    },
                },
            },
        },
        opts_extend = { "sources.default" }
    }
}
