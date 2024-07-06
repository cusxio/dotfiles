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
