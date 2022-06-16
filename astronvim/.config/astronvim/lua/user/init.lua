local M = {
  colorscheme = "kanagawa",
  header = {
    "39 2C 39",
  },
  options = {
    opt = {
      relativenumber = false,
      scrolloff = 15,
      colorcolumn = "80",
      -- list = true,
      -- listchars = {
      --   eol = "↲",
      --   trail = "·",
      --   tab = "» ",
      --   nbsp = "␣",
      --   extends= "<",
      --   precedes = ">",
      --   conceal= "┊",
      --
      -- },
    },
  },
  plugins = {
    init = {
      ["declancm/cinnamon.nvim"] = { disable = true },
      ["Darazaki/indent-o-matic"] = { disable = true },
      ["nmac427/guess-indent.nvim"] = {
        event = "BufReadPost",
        config = function()
          require("guess-indent").setup()
        end,
      },
      ["echasnovski/mini.nvim"] = {
        event = "VimEnter",
        config = function()
          require("mini.surround").setup()
        end,
      },
      ["rebelot/kanagawa.nvim"] = {
        as = "kanagawa",
        config = function()
          require("kanagawa").setup({
            keywordStyle = {
              italic = false,
            },
            statementStyle = {
              italic = false,
            },
            variablebuiltinStyle = {
              italic = false,
            },
          })
        end,
      },
      ["jose-elias-alvarez/typescript.nvim"] = {
        after = "nvim-lsp-installer",
        config = function()
          require("typescript").setup({
            server = astronvim.lsp.server_settings("tsserver"),
          })
        end,
      },
    },
    ["indent_blankline"] = {
      show_first_indent_level = false,
      char = "┊",
      context_char = "┊",
    },
    -- cmp = {
    --   completion = {
    --     completeopt = "menu,menuone,noinsert",
    --   },
    -- },
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
        "json",
        "lua",
        "markdown",
        "prisma",
        "toml",
        "tsx",
        "typescript",
        "rust",
        "solidity",
        "vim",
        "yaml",
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
              vim.lsp.buf.formatting_sync(nil, 10000)
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
      emmet_ls = {
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
        },
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
      -- "eslint",
    },
    skip_setup = { "tsserver" },
  },

  polish = function()
    vim.filetype.add({
      extension = {
        conf = "config",
      },
    })
  end,
}

return M
