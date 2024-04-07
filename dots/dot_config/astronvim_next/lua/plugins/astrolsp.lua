---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      eslint = {
        settings = {
          eslint = {
            autoFixOnSave = true,
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
              },
              {
                fileMatch = { "tsconfig*.json" },
                url = "https://json.schemastore.org/tsconfig.json",
              },
              {
                fileMatch = {
                  ".prettierrc",
                  ".prettierrc.json",
                  "prettier.config.json",
                },
                url = "https://json.schemastore.org/prettierrc.json",
              },
              {
                fileMatch = { ".eslintrc", ".eslintrc.json" },
                url = "https://json.schemastore.org/eslintrc.json",
              },
              {
                fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                url = "https://json.schemastore.org/babelrc.json",
              },
              {
                fileMatch = { "now.json", "vercel.json" },
                url = "https://json.schemastore.org/now.json",
              },
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            hint = { enable = true, arrayIndex = "Disable" },
          },
        },
      },
      tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- https://github.com/paolotiu/tailwind-intellisense-regex-list
                { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
                -- https://cva.style/docs/installation#intellisense
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
            validate = true,
          },
        },
      },
      vtsls = {
        settings = {
          vtsls = {
            typescript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = { enabled = "always" },
            },
            javascript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = { enabled = "always" },
            },
            autoUseWorkspaceTsdk = true,
          },
        },
      },
      mappings = {
        i = {
          ["<C-l>"] = {
            function()
              vim.lsp.buf.signature_help()
            end,
            desc = "Signature help",
            cond = "textDocument/signatureHelp",
          },
        },
      },
    },
  },
}
