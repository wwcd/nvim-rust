local utils = require('nvim-rust.utils')

local M = {}

M.format = function()
  vim.lsp.buf.format({ async = true })
end

M.install = function()
  local tools = {
    'rust-src',
  }
  for _, v in pairs(tools) do
    local cmd = 'rustup component add ' .. v
    local callback = function(exitcode, _)
      if exitcode ~= 0 then
        vim.api.nvim_echo({ { '[INSTALL] ' .. v .. ' FAILED', 'ErrorMsg' } }, true, {})
      else
        vim.api.nvim_echo({ { '[INSTALL] ' .. v .. ' SUCCESS', 'Function' } }, true, {})
      end
    end
    utils.asynccmd(cmd, callback)
  end

  local v = 'rust-analyzer'
  local callback = function(exitcode, _)
    if exitcode ~= 0 then
      vim.api.nvim_echo({ { '[INSTALL] ' .. v .. ' FAILED', 'ErrorMsg' } }, true, {})
    else
      vim.api.nvim_echo({ { '[INSTALL] ' .. v .. ' SUCCESS', 'Function' } }, true, {})
    end
  end
  local url = 'https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz'
  local cmd = 'curl -L ' .. url .. '| gunzip -f -c - > ~/.cargo/bin/rust-analyzer && chmod +x ~/.cargo/bin/rust-analyzer'
  utils.asynccmd(cmd, callback)
end

M.build = function()
  vim.cmd('vs term://cargo build')
end

M.run = function()
  vim.cmd('vs term://cargo run')
end

M.setup = function(_)
  vim.api.nvim_create_user_command("RustInstall", M.install, {})
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, { pattern = { '*.rs' }, callback = M.format })
end

return M
