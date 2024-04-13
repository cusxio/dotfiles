---@type LazySpec
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    opts.winbar = nil

    local status = require("astroui.status")
    opts.tabline[2] = status.heirline.make_buflist(
      status.component.tabline_file_info({ close_button = false })
    )
  end,
}
