local M = {}

M.setup_lsp = function(attach, capabilities)
  require('rust-tools').setup({
    server = {
      on_attach = attach
    }
  })
end

return M
