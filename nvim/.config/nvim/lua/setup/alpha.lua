local dashboard = require("alpha.themes.dashboard")

-- https://github.com/AstroNvim/AstroNvim/blob/52adcb7b734e0a5f7b2a8916a10ab67939f1dc4d/lua/astronvim/utils/init.lua#L165
local function alpha_button(sc, txt)
  -- replace <leader> in shortcut text with LDR for nicer printing
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
  -- if the leader is set, replace the text with the actual leader key for nicer printing
  if vim.g.mapleader then
    sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
  end
  -- return the button entity to display the correct text and send the correct keybinding on press
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "DashboardDesc",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

dashboard.section.buttons.val = {
  alpha_button("LDR n  ", "  New File  "),
  alpha_button("LDR f f", "  Find File  "),
  alpha_button("LDR f o", "󰈙  Recents  "),
  alpha_button("LDR f w", "󰈭  Find Word  "),
}

dashboard.section.header.opts.hl = "DashboardHeader"

dashboard.config.opts.noautocmd = true

dashboard.config.layout[1].val =
  vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })

dashboard.config.layout[3].val = 5

require("alpha").setup(dashboard.config)

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  desc = "Add Alpha dashboard footer",
  once = true,
  callback = function()
    local stats = require("lazy").stats()
    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
    dashboard.section.footer.val = {
      " ",
      " ",
      " ",
      "Config loaded " .. stats.count .. " plugins  in " .. ms .. "ms",
    }
    dashboard.section.footer.opts.hl = "DashboardFooter"
    pcall(vim.cmd.AlphaRedraw)
  end,
})
