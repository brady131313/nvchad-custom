local null_ls = require "null-ls"
local b = null_ls.builtins
local util = require "vim.lsp.util"

local sources = {
   b.formatting.stylua,
   b.formatting.rustfmt.with { extra_args = { "--edition=2021" } },
}

local formatting_callback = function(client, bufnr)
   local params = util.make_formatting_params {}
   client.request("textDocument/formatting", params, nil, bufnr)
end

local M = {}

M.setup = function()
   null_ls.setup {
      sources = sources,

      -- format on save
      on_attach = function(client, bufnr)
         if client.resolved_capabilities.document_formatting then
            -- vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
            vim.api.nvim_create_autocmd("BufWritePre", {
               pattern = "<buffer>",
               callback = function()
                  formatting_callback(client, bufnr)
               end,
            })
         end
      end,
   }
end

return M
