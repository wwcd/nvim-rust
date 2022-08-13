local rust = require('nvim-rust')

vim.api.nvim_create_user_command("RustBuild", rust.rustbuild, {})
vim.api.nvim_create_user_command("RustRun", rust.rustrun, {})
