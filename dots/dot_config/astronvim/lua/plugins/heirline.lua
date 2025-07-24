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
}
