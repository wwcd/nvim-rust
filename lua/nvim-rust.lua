local utils = require('nvim-rust.utils')

local M = {}

M.rustformat = function()
  vim.lsp.buf.formatting()
end

M.rustinstall = function()
  local tools = {
    'rust-src',
  }

  for _, v in pairs(tools) do
    local cmd = 'rustup component add ' .. v
    local callback = function(exitcode, _)
      if exitcode ~= 0 then
        vim.api.nvim_echo({{'[INSTALL] '..v..' FAILED', 'ErrorMsg'}}, true, {})
      else
        vim.api.nvim_echo({{'[INSTALL] '..v..' SUCCESS', 'Function'}}, true, {})
      end
    end
    utils.asynccmd(cmd, callback)
    -- vim.fn.jobwait({utils.asynccmd(cmd, callback)})
  end
end

M.rustbuild = function()
  vim.cmd('vs term://cargo build|startinsert')
end

M.rustrun = function()
  vim.cmd('vs term://cargo run|startinsert')
end

M.setup = function(_)
  vim.api.nvim_create_user_command("RustInstall", M.rustinstall, {})
  vim.api.nvim_create_autocmd({'BufWritePre'}, {pattern={'*.rs'}, callback=M.rustformat})
end

return M
