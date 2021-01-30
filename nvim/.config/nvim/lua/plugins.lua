local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes) ") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/', vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format(
      "git clone %s %s", "https://github.com/wbthomason/packer.nvim",
        directory .. "packer.nvim"
    )
  )

  print(out)
  print("Downloading packer.nvim...")

  return
end

return require('packer').startup(
  function()
    use {'wbthomason/packer.nvim', opt = true}
    use {'jiangmiao/auto-pairs'}
    use {
      'machakann/vim-sandwich',
      config = function()
        vim.cmd("runtime macros/sandwich/keymap/surround.vim")
      end
    }
    use {
      'justinmk/vim-sneak',
      config = function()
        vim.g['sneak#label'] = 1
        vim.g['sneak#s_next'] = 1
      end
    }
    use {'tomtom/tcomment_vim'}

    use {'bluz71/vim-moonfly-colors'}
    use {'kyazdani42/blue-moon'}
    use {'wadackel/vim-dogrun'}
    use {'sainnhe/sonokai'}
    -- use 'bluz71/vim-nightfly-guicolors'
    -- use 'andreypopp/vim-colors-plain'

    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() vim.cmd [[TSUpdate]] end,
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = 'maintained',
          highlight = {enable = true},
          indent = {enable = true}
        }
      end,
      event = 'VimEnter *'
    }

    use {'neovim/nvim-lspconfig'}
    use {'nvim-lua/completion-nvim'}
  end
)
