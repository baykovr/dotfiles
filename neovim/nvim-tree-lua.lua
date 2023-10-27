-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  view = {
    number = true,
  },
  renderer = {
    indent_width = 1,
    indent_markers = {
      enable = true,
      inline_arrows = true,
       icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
      }
    }
  }
})
