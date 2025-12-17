---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        -- https://github.com/yioneko/vtsls/issues/167#issuecomment-2162166505
        root_dir = function()
          local lazyvimRoot = require("lazyvim.util.root")
          return lazyvimRoot.git()
        end,
      },
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = false,
            },
          },
        },
      },
      eslint = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "astro",
          "yaml",
          "json",
          "jsonc",
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.getenv("XDG_DATA_HOME") .. "/nvim-mini/site/pack/deps",
                "${3rd}/luv/library",
              },
            },
          },
        },
      },
    },
    -- https://github.com/LazyVim/LazyVim/issues/5861#issuecomment-2816353352
    setup = {
      eslint = function()
        local function get_client(buf)
          return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
        end

        local formatter = LazyVim.lsp.formatter({
          name = "eslint: lsp",
          primary = false,
          priority = 200,
          filter = "eslint",
        })

        -- Use EslintFixAll on Neovim < 0.10.0
        -- Changed from upstream: check the version explicitly instead of
        -- looking for `vim.lsp._require`. Seems like that check stopped working
        -- with Neovim 0.11.
        if vim.fn.has("nvim-0.10") == 0 then
          formatter.name = "eslint: EslintFixAll"
          formatter.sources = function(buf)
            local client = get_client(buf)
            return client and { "eslint" } or {}
          end
          formatter.format = function(buf)
            local client = get_client(buf)
            if client then
              local pull_diagnostics = vim.diagnostic.get(buf, {
                namespace = vim.lsp.diagnostic.get_namespace(client.id, false),
              })
              -- Older versions of the ESLint language server send push
              -- diagnostics rather than using pull. We support both for
              -- backwards compatibility.
              local push_diagnostics = vim.diagnostic.get(buf, {
                namespace = vim.lsp.diagnostic.get_namespace(client.id, true),
              })
              if (#pull_diagnostics + #push_diagnostics) > 0 then
                vim.cmd("EslintFixAll")
              end
            end
          end
        end

        -- register the formatter with LazyVim
        LazyVim.format.register(formatter)
      end,
      vtsls = function()
        LazyVim.lsp.on_attach(function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end, "vtsls")
      end,
    },
    inlay_hints = { enabled = false },
  },
}
