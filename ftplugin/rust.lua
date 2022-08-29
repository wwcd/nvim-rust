local rust = require('nvim-rust')

vim.api.nvim_buf_create_user_command(0, "RustBuild", rust.build, {})
vim.api.nvim_buf_create_user_command(0, "RustRun", rust.run, {})
