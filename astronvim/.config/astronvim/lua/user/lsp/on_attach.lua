return function(client)
  if vim.tbl_contains({ "astro", "gopls" }, client.name) then
    astronvim.lsp.disable_formatting(client)
  end
end
