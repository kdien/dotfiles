vim.api.nvim_create_user_command('StripANSI', '%s/\\e\\[[0-9;]*m//g', {})
