---@type LazySpec
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    -- Remove winbar
    opts.winbar = nil

    local status = require("astroui.status")

    -- Remove close button on tabline
    opts.tabline[2] = status.heirline.make_buflist(
      status.component.tabline_file_info({ close_button = false })
    )
    -- Add mode text
    opts.statusline[1] = status.component.mode({
      mode_text = { padding = { left = 1, right = 1 } },
    })
  end,
  specs = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        status = {
          -- https://github.com/AstroNvim/AstroNvim/blob/eb8a4153d7cf6bd2555c806658f6110f15d51026/lua/astronvim/plugins/_astroui_status.lua#L111-L118
          attributes = {
            buffer_active = { bold = false, italic = false },
            buffer_picker = { bold = false },
            macro_recording = { bold = false },
            git_branch = { bold = false },
            git_diff = { bold = false },
            virtual_env = { bold = false },
          },
          separators = {
            left = { "", " " },
          },
        },
      },
    },
  },
}
