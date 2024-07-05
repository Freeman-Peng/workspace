local cmp = require "cmp"
local m = require "nvchad.configs.cmp"
local compare = require "cmp.config.compare"

m.sorting = {
  comparators = {
    compare.order,
  },
}

m.mapping["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm { select = true }
    else
      cmp.select_next_item()
    end
  elseif require("luasnip").expand_or_jumpable() then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
  else
    fallback()
  end
end, { "i", "s" })

return m
