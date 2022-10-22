return {
  update_in_insert = false,
  float = {
    format = function(diagnostic)
      if diagnostic.source == "eslint_d" then
        return string.format(
          "%s [%s]",
          diagnostic.message,
          -- shows the name of the rule
          diagnostic.code
        )
      end
      return string.format("%s [%s]", diagnostic.message, diagnostic.source)
    end,
  },
}
