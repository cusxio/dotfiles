return {
  as = "kanagawa",
  config = function()
    require("kanagawa").setup({
      colors = {
        bg = "#1b1d26",
      },
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
}
