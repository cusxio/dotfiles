local M = {
  colorscheme = "kanagawa",
  header = {
    "39 2C 39",
  },
  default_theme = {
    plugins = {
      ["indent_blankline"] = false,
    },
  },
  options = {
    opt = {
      relativenumber = false,
      scrolloff = 15,
      colorcolumn = "80",
    },
  },
  plugins = {
    init = {
      {
        "rebelot/kanagawa.nvim",
        as = "kanagawa",
        -- config = function()
        --   require("kanagawa").setup({
        --     commentStyle = "NONE",
        --     keywordStyle = "NONE",
        --     variablebuiltinStyle = "NONE",
        --   })
        -- end,
      },
    },
    ["indent_blankline"] = {
      show_first_indent_level = false,
    },
    cmp = {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
    },
    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
    telescope = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
    treesitter = {
      ensure_installed = {
        "bash",
        "css",
        "graphql",
        "go",
        "html",
        "javascript",
        "lua",
        "prisma",
        "tsx",
        "typescript",
        "rust",
        "solidity",
        "vim",
      },
      rainbow = {
        enable = false,
      },
    },
    ["null-ls"] = function(config)
      local null_ls = require("null-ls")
      local b = null_ls.builtins

      config.sources = {
        b.code_actions.eslint_d,
        b.diagnostics.eslint_d,
        b.formatting.eslint_d,

        b.formatting.gofmt,
        -- b.diagnostics.golangci_lint,

        b.formatting.prettier,

        b.formatting.stylua,
      }

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      config.on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              vim.lsp.buf.formatting_sync()
            end,
          })
        end
      end
      return config
    end,
  },

  lsp = {
    ["server-settings"] = {
      gopls = {
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false
        end,
      },
    },
    servers = {
      "bashls",
      "cssls",
      "emmet_ls",
      "gopls",
      "html",
      "rust_analyzer",
      "solidity_ls",
      "tsserver",
    },
  },
}

return M
